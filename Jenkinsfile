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
                    try {
                        // Print Docker version for debugging
                        sh 'docker --version'
                        
                        // Login to DockerHub
                        withDockerRegistry([credentialsId: 'dockerhub-credentials-id', url: 'https://index.docker.io/v1/']) {
                            // Build the Docker image
                            docker.build("${DOCKERHUB_REPO}:${DOCKER_TAG}")
                        }
                    } catch (Exception e) {
                        echo "Error during Docker build: ${e.getMessage()}"
                        throw e
                    }
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    try {
                        // Login to DockerHub and push the image
                        withDockerRegistry([credentialsId: 'dockerhub-credentials-id', url: 'https://index.docker.io/v1/']) {
                            docker.image("${DOCKERHUB_REPO}:${DOCKER_TAG}").push()
                        }
                    } catch (Exception e) {
                        echo "Error during Docker push: ${e.getMessage()}"
                        throw e
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
