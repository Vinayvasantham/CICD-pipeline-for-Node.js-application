# Node.js Application CI/CD Pipeline with Jenkins

This repository contains a Jenkins pipeline for automating the build, test, and deployment of a Node.js application. The pipeline also includes email notifications for successful and failed deployments.

---

## Pipeline Stages**

1. **Checkout**: Clones the latest code from the source repository.
2. **Install Dependencies**: Installs required Node.js dependencies using `npm install`.
3. **Run Tests**: Executes test cases to ensure code quality using `npm test`.
4. **Build Docker Image**: Builds a Docker image for the application.
5. **Push Docker Image**: Pushes the Docker image to DockerHub.
6. **Deploy to Kubernetes**: Deploys the application to a Kubernetes cluster using `kubectl`.

---

## **Features**

- Automated CI/CD for Node.js applications.
- Integration with Docker and Kubernetes.
- Configurable environment variables for flexibility.
- Email notifications for deployment success and failure.

---

## **Setup Instructions**

### **Pre-requisites**
1. **Jenkins Setup**:
   - Install Jenkins on your server.
   - Add necessary plugins: 
     - NodeJS
     - Pipeline
     - Email Extension
   - Configure credentials for:
     - DockerHub (`dockerhub-credentials`)
   - Configure the SMTP server for email notifications.

2. **Environment Requirements**:
   - Kubernetes cluster and `kubectl` installed.
   - Docker installed and configured.
   - Node.js and npm installed locally.

3. **Repository Structure**:
   - `k8s/deployment.yaml`: Kubernetes deployment manifest.
   - `k8s/service.yaml`: Kubernetes service manifest.

---

## **Pipeline Script**

Below is a summary of the pipeline script:

- Uses `NodeJS` configured in Jenkins.
- Dynamically replaces the build number in Kubernetes manifests.
- Authenticates DockerHub using credentials stored in Jenkins.
- Deploys the application using `kubectl` with a specified `KUBECONFIG`.

---

## **Email Notifications**

- **Success**:
  - Sends an email to `vinayvasantham7@gmail.com` indicating successful deployment.
- **Failure**:
  - Sends an email to the same address with details of the failure.

**Sample Email Content**:
- **Subject**: Deployment Success: `vinayvasantham/nodejs-app:<BUILD_NUMBER>`
- **Body**: The application was successfully deployed to Kubernetes.

---

## **Usage**

1. Clone this repository:
   ```bash
   git clone https://github.com/vinayvasantham/your-repo.git
