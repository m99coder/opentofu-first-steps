# OpenTofu: First Steps

## Install

```shell
→ brew install opentofu
```

It’s adviced to also install the [OpenTofu plugin](https://marketplace.visualstudio.com/items?itemName=OpenTofu.vscode-opentofu) if you are using VSCode.

## Init

```shell
→ vim main.tf
→ tofu init
```

Don’t forget to add the relevant files to your `.gitignore` file, as described [here](https://www.env0.com/blog/gitignore-command-guide-practical-examples-and-terraform-tips).

```shell
→ tofu providers

Providers required by configuration:
.
└── provider[registry.opentofu.org/hashicorp/aws] ~> 6.0
```

## AWS

Get the latest ARM-based Amazon Linux 2023 AMI version using the AWS CLI like this:

```shell
→ aws ec2 describe-images \
    --owners amazon \
    --filters "Name=name,Values=al2023-*-arm64" "Name=state,Values=available" \
    --query 'Images | sort_by(@, &CreationDate)[-1]' \
    --output table
```

Get a matching instance type eligible for the free tier using the AWS CLI like this:

```shell
→ aws ec2 describe-instance-types \
    --filters "Name=processor-info.supported-architecture,Values=arm64" \
              "Name=free-tier-eligible,Values=true" \
    --query 'InstanceTypes[*].InstanceType' \
    --output table
```

Now we can plan and apply the plan and check the state afterwards:

```shell
→ echo "name_prefix = \"opentofu-first-steps\"" >> my.tfvars

cat > my.tfvars <<EOF
name_prefix = "opentofu-first-steps"
ssh_key     = "~/.ssh/id_ed25519.pub"
EOF

→ tofu plan -var-file my.tfvars
→ tofu apply -var-file my.tfvars

→ tofu state list
→ tofu state show aws_instance.example
```

With the `outputs.tf` in place, we can run `tofu refresh` and see the output of the instance ARN.

In case you want to recreate the instance, you can use `tofu taint` as follows:

```shell
→ tofu taint aws_instance.example
→ tofu apply -var-file my.tfvars [-auto-approve]
```

Hint: SSH into the EC2 instance and check `/var/log/cloud-init-output.log` to see if there was any error during the setup.

Finally, clean up.

```shell
→ tofu destroy -var-file my.tfvars [-auto-approve]
```

## Azure

_tbw._

## GCP

_tbw._
