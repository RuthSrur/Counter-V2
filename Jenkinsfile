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
                    echo "Starting to build the Docker image ${DOCKERHUB_REPO}:${DOCKER_TAG}..."
                    withDockerRegistry([credentialsId: 'dockerhub-credentials-id', url: 'https://index.docker.io/v1/']) {
                        try {
                            docker.build("${DOCKERHUB_REPO}:${DOCKER_TAG}")
                            echo "Docker image ${DOCKERHUB_REPO}:${DOCKER_TAG} built successfully."
                        } catch (Exception e) {
                            echo "Error occurred while building Docker image: ${e.message}"
                            throw e
                        }
                    }
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    echo "Pushing Docker image to DockerHub..."
                    withDockerRegistry([credentialsId: 'dockerhub-credentials-id', url: 'https://index.docker.io/v1/']) {
                        try {
                            docker.image("${DOCKERHUB_REPO}:${DOCKER_TAG}").push()
                            echo "Docker image ${DOCKERHUB_REPO}:${DOCKER_TAG} pushed successfully."
                        } catch (Exception e) {
                            echo "Error occurred while pushing Docker image: ${e.message}"
                            throw e
                        }
                    }
                }
            }
        }
    }
    post {
        always {
            script {
                echo "Cleaning up Docker environment..."
                sh 'docker system prune -af || echo "Docker prune failed. Continuing..."'
            }
        }
    }
}
