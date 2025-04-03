pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        TERRAFORM_VERSION = '1.10.5'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/khushig222/aws-infra.git'
            }
        }

        stage('Verify Directory') {
            steps {
                sh 'pwd && ls -la'  // Debugging step
            }
        }

        stage('Terraform Init') {
            steps {
                dir('aws-infra') { 
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('aws-infra') { 
                    sh ' terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('aws-infra') { 
                    sh 'terraform apply tfplan'
                }
            }
        }
    }

    post {
        success {
            echo "Infrastructure deployed successfully!"
        }
        failure {
            echo "Deployment failed! Rolling back..."
        }
    }
}
