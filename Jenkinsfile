pipeline {
    agent any
    tools {
        nodejs 'NodeJS' // Use the name you configured in Jenkins
    }
    environment {
        DOCKER_IMAGE = 'vinayvasantham/nodejs-app:latest'
        K8S_DEPLOYMENT_PATH = 'k8s/deployment.yaml'
        K8S_SERVICE_PATH = 'k8s/service.yaml'
        KUBECONFIG = 'C:\\Users\\vinay\\.kube\\config'  // Set the path to your kubeconfig file
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Install Dependencies') {
            steps {
                bat 'npm install'
            }
        }
        stage('Run Tests') {
            steps {
                bat 'npm test'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('Sonarqube') {  // 'SonarQube' is the name configured in Jenkins
                    bat 'npx sonarqube-scanner'
                }
            }
        }
        stage('Build Docker') {
            steps {
                script {
                    bat '''
                    echo Building Docker Image
                    docker build -t vinayvasantham/nodejs-app:latest .
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
                        docker push vinayvasantham/nodejs-app:latest
                        '''
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Set the KUBECONFIG environment variable before running kubectl commands
                    bat '''
                    echo Authenticating with Kubernetes using KUBECONFIG
                    set KUBECONFIG=%KUBECONFIG%
                    kubectl apply -f %K8S_DEPLOYMENT_PATH% --validate=false
                    kubectl apply -f %K8S_SERVICE_PATH% --validate=false
                    '''
                }
            }
        }
    }
    // post {
    //     success {
    //         mail to: 'vinayvasantham7@gmail.com',
    //              subject: "Deployment Success: ${DOCKER_IMAGE}",
    //              body: """
    //              The application was successfully deployed to Kubernetes.
                 
    //              Deployment Details:
    //              - Docker Image: ${DOCKER_IMAGE}
    //              - Job Name: ${env.JOB_NAME}
    //              - Build Number: ${env.BUILD_NUMBER}
    //              - Build URL: ${env.BUILD_URL}
    //              """
    //     }
    //     failure {
    //         mail to: 'vinayvasantham7@gmail.com',
    //              subject: "Deployment Failure: ${DOCKER_IMAGE}",
    //              body: """
    //              The deployment failed. Please check the Jenkins logs for details.
                 
    //              Deployment Details:
    //              - Docker Image: ${DOCKER_IMAGE}
    //              - Job Name: ${env.JOB_NAME}
    //              - Build Number: ${env.BUILD_NUMBER}
    //              - Build URL: ${env.BUILD_URL}
    //              """
    //     }
    // }
}
