DevOps Project on AWS
This project demonstrates the setup and deployment of an application infrastructure using Terraform, AWS EKS, and Kubernetes. The infrastructure includes networking components, security configurations, an EKS cluster, worker node management, and an EC2 instance for basic operations.

Features
AWS VPC: Configured using a custom Terraform module, setting up public and private subnets, and security groups.
EKS Cluster: Managed Kubernetes cluster setup, including IAM roles and policies.
EC2 Instance: Provisioning of an EC2 instance with a specified Ubuntu AMI, with a security group allowing all inbound/outbound traffic.
EKS Node Group: Autoscaling Kubernetes worker nodes for the cluster with customizable settings for size and scaling.
Kubernetes Deployment: A simple deployment for a web application, using an ECR image for containers.
Setup Instructions
Clone the repository:

git clone https://github.com/NurhakS/Devops-Project-AWS.git
cd Devops-Project-AWS/Devops-Project-AWS
Initialize Terraform: Install Terraform if not already installed. Initialize Terraform and apply configurations:

terraform init
terraform apply
Update Kubernetes Deployment: Modify the deployment.yaml file to point to the correct ECR repository for your application image.

Deploy the application: Once Terraform provisioning is complete, deploy the application to your EKS cluster using:

kubectl apply -f k/k8s/deployment.yaml
kubectl apply -f k/k8s/ingress.yaml
Resources Created
VPC with public and private subnets.
EKS Cluster with associated IAM roles.
EKS Node Group for scalable worker nodes.
EC2 Instance configured for access.
Kubernetes Deployment for a sample app.
Notes
Modify the main.tf and deployment.yaml to match your specific needs (e.g., application image, instance types, etc.).
Ensure AWS credentials are set up properly for Terraform and kubectl to interact with your AWS resources.
This setup assumes an ECR container image for Kubernetes deployments, ensure the ECR repository is created and accessible.
