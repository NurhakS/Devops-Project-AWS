# Devops-Project-AWS
# Create Ubuntu ec2 via Terraform
 
# INSTALL Jenkins
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
# install java
sudo apt update
sudo apt install fontconfig openjdk-17-jre
java -version
openjdk version "17.0.8" 2023-07-18
OpenJDK Runtime Environment (build 17.0.8+7-Debian-1deb12u1)
OpenJDK 64-Bit Server VM (build 17.0.8+7-Debian-1deb12u1, mixed mode, sharing)
# start jenkins


You can enable the Jenkins service to start at boot with the command:

sudo systemctl enable jenkins

You can start the Jenkins service with the command:

sudo systemctl start jenkins

You can check the status of the Jenkins service using the command:

sudo systemctl status jenkins
# setup pipeline in jenkins 
pipeline {
  agent any
  environment {
    AWS_DEFAULT_REGION = 'us-west-2'
    ECR_REPO_NAME = 'my-ecr-repo'
    IMAGE_TAG = "my-ecr-repo:${env.BUILD_ID}"
  }
  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/your-repo.git'
      }
    }
    stage('Build Docker Image') {
      steps {
        script {
          dockerImage = docker.build("${env.ECR_REPO_NAME}:${env.BUILD_ID}")
        }
      }
    }
    stage('Scan with Trivy') {
      steps {
        script {
          sh 'trivy image --exit-code 1 --severity HIGH,CRITICAL ${dockerImage.id}'
        }
      }
    }
    stage('Push Docker Image') {
      steps {
        script {
          docker.withRegistry("https://${env.AWS_ACCOUNT_ID}.dkr.ecr.${env.AWS_DEFAULT_REGION}.amazonaws.com", 'ecr:aws-credentials') {
            dockerImage.push()
          }
        }
      }
    }
    stage('Deploy to EKS') {
      steps {
        script {
          sh '''
          aws eks --region $AWS_DEFAULT_REGION update-kubeconfig --name $CLUSTER_NAME
          kubectl apply -f k8s/deployment.yaml
          '''
        }
      }
    }
  }
}


sudo apt-get update
# Install Docker
sudo apt-get install -y docker.io
# Add Jenkins user to Docker group
sudo usermod -aG docker jenkins
# Restart Jenkins to apply group changes
sudo systemctl restart jenkins

docker run -d -p 8081:8081 --name nexus sonatype/nexus3
docker run -d -p 9000:9000 --name sonarqube sonarqube
sudo apt-get install wget apt-transport-https gnupg lsb-release -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy
Set up terraform eks
 # install prometheus and grafana using helm
 helm install prometheus prometheus-community/prometheus
 helm install grafana prometheus-community/grafana
 helm install prometheus prometheus-community/prometheus --set server.port=9091
helm install grafana prometheus-community/grafana --set server.port=3000
kubectl get service prometheus -n monitoring
kubectl get service grafana -n monitoring
