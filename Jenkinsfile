pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'vinayvasantham/nodejs-app:${BUILD_NUMBER}'
        KUBECONFIG = "$HOME/.kube/config" // Default location for Minikube's kubeconfig
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Vinayvasantham/CICD-pipeline-for-Node.js-application.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'npm test'
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                sh """
                docker build -t ${DOCKER_IMAGE} .
                docker login -u your-dockerhub-username -p your-dockerhub-password
                docker push ${DOCKER_IMAGE}
                """
            }
        }

        stage('Deploy to Minikube') {
            steps {
                script {
                    // Modify the Kubernetes manifest to use the current image
                    sh """
                    sed -i 's|vinayvasantham/nodejs-app:latest|${DOCKER_IMAGE}|g' kubernetes/deployment.yaml
                    kubectl apply -f kubernetes/deployment.yaml
                    """
                }
            }
        }
    }

    post {
        success {
            mail to: 'vinayvasantham7@gmail.com',
                 subject: "Deployment Success: ${DOCKER_IMAGE}",
                 body: "The application was successfully deployed to Kubernetes."
        }
        failure {
            mail to: 'vinayvasantham7@gmail.com',
                 subject: "Deployment Failure: ${DOCKER_IMAGE}",
                 body: "The deployment failed. Please check the Jenkins logs."
        }
    }
}
