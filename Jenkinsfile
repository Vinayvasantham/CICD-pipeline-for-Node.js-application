pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'vinayvasantham/nodejs-app:${BUILD_NUMBER}'
        K8S_DEPLOYMENT_PATH = 'k8s/deployment.yaml'
        K8S_SERVICE_PATH = 'k8s/service.yaml'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
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
        stage('Build Docker') {
            steps {
                script {
                    bat '''
                    echo Building Docker Image
                    docker build -t vinayvasantham/nodejs-app:%BUILD_NUMBER% .
                    '''
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        bat '''
                        echo Logging in to DockerHub
                        docker login -u %DOCKER_USERNAME% -p %DOCKER_PASSWORD%
                        echo Pushing Docker Image
                        docker push vinayvasantham/todo-app-cicd:%BUILD_NUMBER%
                        '''
                    }
                }
            }
       }
        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f ${K8S_DEPLOYMENT_PATH}'
                sh 'kubectl apply -f ${K8S_SERVICE_PATH}'
            }
        }
    }
}
