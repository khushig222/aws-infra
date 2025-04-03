pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        TERRAFORM_VERSION = '1.10.5'
        TF_WORK_DIR = "/var/lib/jenkins/workspace/terra"
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
               dir("${TF_WORK_DIR}") { 
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
               dir("${TF_WORK_DIR}") { 
                    sh ' terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir("${TF_WORK_DIR}") {  
                    sh 'terraform apply -auto-approve tfplan'
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
