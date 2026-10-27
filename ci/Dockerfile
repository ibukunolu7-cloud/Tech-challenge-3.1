
FROM python:3.12-slim

ENV PIP_NO_CACHE_DIR=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    TF_IN_AUTOMATION=1

# Install utilities required to download Terraform
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       curl \
       unzip \
       git \
       openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Install Terraform CLI
ARG TERRAFORM_VERSION=1.15.8

RUN curl -fsSLo /tmp/terraform.zip \
      "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" \
    && unzip /tmp/terraform.zip -d /usr/local/bin \
    && rm /tmp/terraform.zip \
    && terraform version

# Install Ansible
RUN pip install ansible

WORKDIR /workspace

CMD ["sh"]
