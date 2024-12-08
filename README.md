# CI/CD Pipeline for Node.js Application

This repository demonstrates a CI/CD pipeline using Jenkins for a Node.js application.

## Features
1. Automatic testing on pull requests.
2. Docker image build and push to Docker Hub.
3. Deployment to a Kubernetes cluster.
4. Email notifications for success or failure.

## Repository Structure
- `Dockerfile`: For building the Node.js application image.
- `kubernetes/`: Contains Kubernetes deployment and service YAML files.
- `Jenkinsfile`: Defines the Jenkins pipeline.

## Prerequisites
- Docker and Kubernetes cluster setup.
- Jenkins server with necessary plugins.

## Steps to Run the Pipeline
1. Fork the repository and configure Jenkins with your credentials.
2. Trigger the pipeline from Jenkins.
