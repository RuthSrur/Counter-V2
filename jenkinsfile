pipeline {
    agent any
    environment {
        AWS_REGION = 'us-east-1'
        AWS_CREDENTIALS_ID = 'aws-credentials-id'
        DOCKERHUB_REPO = 'ruthsrur/flask-counter-app'
        DOCKER_TAG = 'latest'
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Login to DockerHub
                    withDockerRegistry([credentialsId: 'dockerhub-credentials-id', url: 'https://index.docker.io/v1/']) {
                        // Build the Docker image
                        docker.build("${DOCKERHUB_REPO}:${DOCKER_TAG}")
                    }
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    // Login to DockerHub and push the image
                    withDockerRegistry([credentialsId: 'dockerhub-credentials-id', url: 'https://index.docker.io/v1/']) {
                        // Push the Docker image
                        docker.image("${DOCKERHUB_REPO}:${DOCKER_TAG}").push()
                    }
                }
            }
        }
    }
    post {
        always {
            // Clean up Docker environment
            sh 'docker system prune -af'
        }
    }
}
