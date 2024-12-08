pipeline {
    agent {
        docker { image 'node:16' }
    }

    environment {
        DOCKER_IMAGE = 'vinayvasantham/nodejs-app:${BUILD_NUMBER}'
        KUBECONFIG = credentials('kubeconfig-credential-id') // Kubernetes config
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

        stage('Build Docker Image') {
            steps {
                sh """
                docker build -t ${DOCKER_IMAGE} .
                docker login -u vinayvasantham -p Vinay@123
                docker push ${DOCKER_IMAGE}
                """
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh """
                kubectl apply -f kubernetes/deployment.yaml
                """
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
