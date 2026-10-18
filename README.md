# Week 8 — Tech Challenge 3.1: Infrastructure as Code with Terraform and Ansible

## Project Overview

This project demonstrates Infrastructure as Code (IaC) on AWS using Terraform to provision cloud resources and Ansible to configure an Ubuntu EC2 web server.

The deployment installs Nginx and serves a simple Hello World webpage. An IAM role also grants the EC2 instance limited read access to a private S3 bucket.

## Architecture

- **Terraform:** Provisions the AWS infrastructure.
- **Amazon EC2:** Hosts the Ubuntu web server.
- **Amazon S3:** Provides private object storage.
- **AWS IAM:** Grants the EC2 instance least-privilege S3 read permissions.
- **Security group:** Restricts SSH access and permits HTTP traffic.
- **Docker:** Provides the Ansible execution environment.
- **Ansible:** Installs and configures Nginx and deploys the webpage.

## Project Structure

```text
tech-challenge-3.1/
├── README.md
├── terraform/
│   ├── provider.tf
│   ├── variables.tf
│   ├── terraform.tfvars.example
│   ├── network.tf
│   ├── security_group.tf
│   ├── iam.tf
│   ├── main.tf
│   └── outputs.tf
└── ansible/
    ├── ansible.cfg
    ├── inventory.ini.example
    └── playbook.yml
```

## Prerequisites

- An AWS account with appropriate permissions.
- AWS CLI configured locally.
- Terraform installed.
- Docker installed and running.
- Git installed.
- An existing EC2 SSH key pair.
- Ansible available through the Docker image used for this project.

## Deployment

### 1. Configure AWS

Configure AWS CLI credentials locally using an approved method:

```bash
aws configure
aws sts get-caller-identity
```

### 2. Configure Terraform

Create a local `terraform.tfvars` file using the example configuration and supply the appropriate values for the AWS region, project name, instance type, SSH source IP and globally unique S3 bucket name.

Do not commit `terraform.tfvars`.

### 3. Provision infrastructure

```bash
cd terraform
terraform init
terraform validate
terraform plan
terraform apply
```

Review the plan before applying changes.

### 4. Configure Ansible

Update the local inventory with the EC2 public IP, Ubuntu username and the private-key path available inside the Ansible container.

Keep private keys outside the Git repository.

### 5. Run the Ansible playbook

From the project root, run the Ansible playbook using the project's configured Docker image and SSH key mount.

The playbook installs Nginx, ensures that the service is running and enabled, and deploys the Hello World HTML page.

## Verification

The following checks were completed during the project:

- Terraform successfully provisioned the AWS infrastructure.
- Ansible connected to the EC2 instance and completed the playbook with zero failures.
- The Hello World webpage was accessible over HTTP.
- S3 public access block settings were enabled.
- The EC2 instance profile was associated with the intended IAM role.
- The IAM role successfully listed the S3 bucket and downloaded a test object.

## Security Considerations

- Restrict SSH access to an authorised IP address.
- Keep S3 Block Public Access enabled.
- Use an IAM role instead of long-lived AWS credentials on EC2.
- Grant only the S3 permissions required by the workload.
- Verify SSH host keys in production; do not routinely disable host-key checking.
- Never commit private keys, AWS credentials, Terraform state files, or sensitive plan files.

## Cleanup

When the infrastructure is no longer needed, review the resources and run:

```bash
cd terraform
terraform plan -destroy
terraform destroy
```

Confirm that the resources can safely be removed before approving destruction. Back up any required data first.

## Learning Outcomes

This project demonstrates practical experience with Terraform, AWS infrastructure provisioning, IAM roles, S3 access control, Docker, Ansible, Linux administration, Nginx deployment and infrastructure troubleshooting.
