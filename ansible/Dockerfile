
FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1

# Install SSH tools required by Ansible
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       openssh-client \
       sshpass \
    && rm -rf /var/lib/apt/lists/*

# Install Ansible
RUN pip install --no-cache-dir ansible

# Directory where inventory and playbooks will be mounted
WORKDIR /workspace/ansible

CMD ["ansible", "--version"]
