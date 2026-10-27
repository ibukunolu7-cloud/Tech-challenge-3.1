
pipeline {
    agent any

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

        stage('Terraform and Ansible Tooling') {
            steps {
                sh '''
                    echo "Checking available validation tools..."

                    if command -v terraform >/dev/null 2>&1; then
                        terraform version
                    else
                        echo "Terraform is not installed on this Jenkins agent yet."
                    fi

                    if command -v ansible-playbook >/dev/null 2>&1; then
                        ansible-playbook --version
                    else
                        echo "Ansible is not installed on this Jenkins agent yet."
                    fi
                '''
            }
        }
    }

    post {
        success {
            echo 'Initial project checks completed successfully.'
        }
        failure {
            echo 'The pipeline failed. Review the Console Output.'
        }
    }
}
