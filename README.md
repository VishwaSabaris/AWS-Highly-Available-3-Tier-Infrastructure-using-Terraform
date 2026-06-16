# AWS Highly Available 3-Tier Infrastructure using Terraform

![Terraform](https://img.shields.io/badge/Terraform-IaC-blue)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI/CD-success)

## Project Overview

This project demonstrates Infrastructure as Code (IaC) using Terraform to provision a highly available and scalable AWS 3-Tier Architecture.

The infrastructure includes:

- Virtual Private Cloud (VPC)
- Public and Private Subnets
- Application Load Balancer (ALB)
- Auto Scaling Group (ASG)
- Amazon EC2 Instances
- Amazon RDS Database
- Security Groups
- GitHub Actions CI/CD Pipeline

The architecture follows cloud best practices for scalability, security, and high availability.

---

## Architecture Diagram

![Architecture](architecture.png)

---

## Workflow Diagram

![Workflow](workflow.png)

---

## Project Highlights

- Built using reusable Terraform modules
- Automated infrastructure provisioning
- Highly available architecture using ALB and Auto Scaling Group
- Private RDS deployment
- Multi-tier network segmentation
- GitHub Actions based Terraform CI/CD
- Environment-aware scaling using Terraform Workspaces
- Infrastructure version controlled using Git
- Modular and production-ready design

---

## Architecture Components

### Networking Layer

- Custom VPC
- Public Subnet 1
- Public Subnet 2
- Private Subnet 1
- Private Subnet 2
- Internet Gateway
- Route Tables

### Load Balancing Layer

- Application Load Balancer (ALB)
- Target Groups
- Health Checks

### Compute Layer

- Auto Scaling Group
- Amazon EC2 Instances
- Launch Template

### Database Layer

- Amazon RDS
- Private Database Subnets
- Security Group Restrictions

### Security Layer

- Dedicated Security Groups
- Controlled Network Access
- Least Privilege Design

---

## Terraform Modules

```text
modules/
├── alb/
├── asg/
├── ec2/
├── rds/
├── security-group/
└── vpc/
```

Each module is independently reusable and follows Terraform best practices.

---

## Repository Structure

```text
.
├── .github/workflows/
├── modules/
│   ├── alb/
│   ├── asg/
│   ├── ec2/
│   ├── rds/
│   ├── security-group/
│   └── vpc/
├── backend.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── import-demo.tf
├── architecture.png
├── workflow.png
└── README.md
```

---

## Infrastructure Workflow

1. Terraform initializes AWS provider
2. VPC and networking resources are created
3. Security Groups are provisioned
4. Application Load Balancer is deployed
5. Auto Scaling Group launches EC2 instances
6. RDS database is created in private subnets
7. GitHub Actions validates Terraform configuration
8. Infrastructure becomes accessible through ALB DNS

---

## Technologies Used

- Terraform
- AWS VPC
- Amazon EC2
- Auto Scaling Group
- Application Load Balancer
- Amazon RDS
- GitHub Actions
- Git
- Infrastructure as Code (IaC)

---

## CI/CD Pipeline

GitHub Actions is used to automate:

- Terraform Format Check
- Terraform Validation
- Terraform Initialization
- Infrastructure Deployment Workflow

---

## Learning Outcomes

Through this project I gained hands-on experience in:

- Infrastructure as Code
- AWS Networking
- VPC Design
- Auto Scaling
- Load Balancing
- Database Deployment
- Terraform Modules
- GitHub Actions
- DevOps Automation
- Cloud Architecture Design

---

## Future Enhancements

- Remote Terraform State using S3
- State Locking using DynamoDB
- Monitoring with CloudWatch
- Logging with CloudWatch Logs
- Route53 Integration
- HTTPS using ACM Certificates
- Kubernetes Deployment on EKS

---

## Author

**Vishwa Sabaris V**

Computer Science and Engineering (AI & ML)

Interested in:
- Cloud Computing
- DevOps
- Infrastructure Automation
- Artificial Intelligence
- Machine Learning

GitHub:
https://github.com/VishwaSabaris

LinkedIn:
https://www.linkedin.com/in/vishwa-sabaris-aa487837b/

---

## License

This project is licensed under the MIT License.
