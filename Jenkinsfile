pipeline {
    agent {
        label 'terraform-ansible'
    }

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Check Project Files') {
            steps {
                sh '''
                    set -eu

                    echo "Checking required project files..."

                    test -f README.md
                    test -f terraform/provider.tf
                    test -f terraform/main.tf
                    test -f terraform/variables.tf
                    test -f terraform/outputs.tf
                    test -f terraform/iam.tf
                    test -f terraform/security_group.tf
                    test -f ansible/playbook.yml
                    test -f ansible/Dockerfile
                    test -f terraform/terraform.tfvars.example
                    test -f ansible/inventory.ini.example

                    echo "All required project files are present."
                '''
            }
        }

        stage('Check Tool Versions') {
            steps {
                sh '''
                    set -eu
                    terraform version
                    ansible-playbook --version
                '''
            }
        }

        stage('Terraform Format Check') {
            steps {
                sh '''
                    set -eu
                    terraform fmt -check -recursive terraform
                '''
            }
        }

        stage('Terraform Initialize') {
            steps {
                sh '''
                    set -eu
                    terraform -chdir=terraform init -backend=false -input=false
                '''
            }
        }

        stage('Terraform Validate') {
            steps {
                sh '''
                    set -eu
                    terraform -chdir=terraform validate
                '''
            }
        }

        stage('Ansible Syntax Check') {
            steps {
                sh '''
                    set -eu

                    printf "[defaults]\\n" > /tmp/ci-ansible.cfg
                    printf "[webservers]\\nlocalhost ansible_connection=local\\n" > /tmp/ci-inventory.ini

                    cd ansible
                    ANSIBLE_CONFIG=/tmp/ci-ansible.cfg \
                        ansible-playbook \
                        -i /tmp/ci-inventory.ini \
                        --syntax-check \
                        playbook.yml
                '''
            }
        }
    }

    post {
        success {
            echo 'All Terraform and Ansible validation checks passed.'
        }
        failure {
            echo 'Validation failed. Review the Console Output for the failing stage.'
        }
    }
}
