pipeline {
    agent any
    
    environment {
        TF_VAR_region = "${params.region}"
        TF_VAR_subnet_id = "${params.subnet_id}"
        TF_VAR_security_group_ids = "${params.security_group_ids}"
        TF_VAR_server_name = "${params.server_name}"
        TF_VAR_username = "${params.username}"
        TF_VAR_password = "${params.password}"
        TF_VAR_instance_type = "${params.instance_type}"
        TF_VAR_ami = "${params.ami}"
    }

    parameters {
        string(name: 'region', description: 'AWS region', defaultValue: 'us-east-1')
        string(name: 'subnet_id', description: 'Subnet ID')
        string(name: 'security_group_ids', description: 'Security Group IDs')
        string(name: 'server_name', description: 'Name of the server')
        string(name: 'username', description: 'Username for accessing the server')
        string(name: 'password', description: 'Password for accessing the server')
        string(name: 'instance_type', description: 'Instance type for the server', defaultValue: 't2.micro')
        string(name: 'ami', description: 'AMI for the server', defaultValue: 'ami-12345678')
        // Add more parameters as needed
    }

    stages {
        stage('Terraform Init') {
            steps {
                script {
                    // Assuming Terraform is installed and available in PATH
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }

    post {
        always {
            // Cleanup step
            script {
                sh 'terraform destroy -auto-approve'
            }
        }
    }
}
