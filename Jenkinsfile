pipeline {
    agent any
    environment {
        AWS_REGION = 'us-east-1'
        AWS_CREDENTIALS_ID = 'aws-credentials-id'
        DOCKERHUB_REPO = 'ruthsrur/flask-counter-app'
        DOCKER_TAG = 'latest'
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials-id' // Add DockerHub credentials ID
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    try {
                        // Print Docker version for debugging
                        sh 'docker --version'
                        
                        // Print current working directory and list files
                        sh 'pwd'
                        sh 'ls -la'
                        
                        // Build the Docker image
                        echo "Building Docker image ${DOCKERHUB_REPO}:${DOCKER_TAG}"
                        sh "docker build -t ${DOCKERHUB_REPO}:${DOCKER_TAG} ."
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
                        echo "Pushing Docker image ${DOCKERHUB_REPO}:${DOCKER_TAG}"
                        withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                            sh "echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin"
                            sh "docker push ${DOCKERHUB_REPO}:${DOCKER_TAG}"
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
