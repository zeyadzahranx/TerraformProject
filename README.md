# 🛠️ AWS Multi-Tier Architecture using Terraform

This project provisions a complete multi-tier AWS architecture using Terraform, designed for high availability, scalability, and modular reusability. It includes networking, compute instances, load balancers, and automation — ideal for showcasing infrastructure as code (IaC) practices.

---

## 📸 Architecture Overview

Terraform (dev workspace)
├── VPC (10.0.0.0/16)
│   ├── Public Subnet AZ1 (10.0.1.0/24)
│   ├── Public Subnet AZ2 (10.0.2.0/24)
│   ├── Private Subnet AZ1 (10.0.3.0/24)
│   ├── Private Subnet AZ2 (10.0.4.0/24)
│   ├── Internet Gateway
│   ├── NAT Gateway (for private subnet access)
│   └── Route Tables
├── Public Load Balancer (ALB)
│   └── Nginx Proxies
│       ├── EC2 Instance (AZ1)
│       └── EC2 Instance (AZ2)
├── Private Load Balancer (ALB)
│   └── Apache Web Servers
│       ├── EC2 Instance (AZ1)
│       └── EC2 Instance (AZ2)
└── Remote Backend
    ├── S3 (terraform.tfstate)
    └── DynamoDB (terraform-locks)

---

## 🚀 Project Goals

✅ Use Terraform modules to break down infrastructure  
✅ Provision Nginx proxy instances with remote provisioning  
✅ Provision Apache instances with custom `user_data`  
✅ Use ALBs to load balance traffic across instances  
✅ Automate public IP logging with `local-exec`  
✅ Store state remotely (S3 + DynamoDB)  
✅ Use `terraform workspace` for multi-environment support  

---

## 🧱 Module Structure

Each component is isolated into a module:

modules/
├── network/          # Foundation layer (VPC, Subnets, Routes, NAT, Security Groups)
├── alb/              # Reusable Application Load Balancer
├── nginx-proxy/      # Public EC2 with Nginx
└── apache-private/   # Private EC2 with Apache
---

## 🔧 How to Deploy

> Before deploying, make sure AWS credentials are configured locally.

1. **Clone the repo**  
```bash
git clone https://github.com/your-username/terraform-aws-architecture.git
cd terraform-aws-architecture
Initialize Terraform and switch to the dev workspace

terraform init
terraform workspace select dev || terraform workspace new dev
Apply the infrastructure


terraform apply
Check generated file
After deployment, all-ips.txt will list public IPs:

cpp
public-ip1  3.92.x.x
public-ip2  3.91.x.x

---

🌐 How to Test
Visit the public ALB DNS name from your browser or curl:

```bash

curl http://<alb-dns-name>
You’ll see one of the following (depending on which Apache instance is hit):

Welcome to Private Page1 !
        or
Welcome to Private Page2 !

✅ This confirms Nginx proxy → Private ALB → Apache instances are working together.

---

💾 Backend Setup (Remote State)
State stored in S3: s3://zeyad-terraform-states/dev/terraform.tfstate

Locking via DynamoDB table: terraform-locks

---

📂 Files and Folders
File/Folder	         Purpose
main.tf	             Root module config
backend.tf	         Remote backend definition
terraform.tfvars	 Input values
modules/	         All Terraform modules
all-ips.txt	         Logs public IPs
README.md	         Project overview -- << you're here lol >>
✍️ Author
Zeyad Zahran
🚀 DevOps Enthusiast | System Admin in the making
🌍 LinkedIn www.linkedin.com/in/zeyad-zahran
📍 Egypt

🏷️ Tags
#Terraform #AWS #InfrastructureasCode #DevOps #ModularDesign