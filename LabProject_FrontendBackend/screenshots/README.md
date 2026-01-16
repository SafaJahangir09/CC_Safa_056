# Lab Project: Frontend–Backend Nginx High Availability Architecture

This project demonstrates automated infrastructure provisioning and configuration using **Terraform** and **Ansible** to deploy a highly available frontend–backend web architecture on **AWS EC2**.

## 📌 Project Overview

The objective of this lab is to provision cloud infrastructure using Terraform and configure services using Ansible roles.  
The architecture consists of:

- **1 Frontend EC2 instance** running **Nginx** as a load balancer
- **3 Backend EC2 instances** running **Apache HTTPD**
- Nginx distributes traffic using **2 active backends and 1 backup backend**
- Full automation: Terraform triggers Ansible automatically after provisioning

## 🏗 Architecture Description

- Terraform creates:
  - VPC, public subnet, internet gateway, and route table
  - Security group allowing SSH (from user IP) and HTTP (port 80)
  - 1 frontend EC2 instance
  - 3 backend EC2 instances

- Ansible configures:
  - Backend servers with Apache and unique index pages
  - Frontend server with Nginx configured as a reverse proxy and load balancer

Traffic Flow:
User → Frontend (Nginx) → Backend 1 / Backend 2 → Backup Backend (if primaries fail)

## 🧰 Technologies Used

- Terraform (Infrastructure as Code)
- Ansible (Configuration Management)
- AWS EC2, VPC, Security Groups
- Nginx (Frontend Load Balancer)
- Apache HTTPD (Backend Web Servers)
- Git & GitHub (Version Control)

## 📁 Project Directory Structure

LabProject_FrontendBackend/
├── ansible/
│   ├── ansible.cfg
│   ├── inventory/hosts
│   ├── playbooks/site.yaml
│   └── roles/
│       ├── backend/
│       ├── frontend/
│       └── common/
├── modules/
│   ├── subnet/
│   └── webserver/
├── main.tf
├── variables.tf
├── outputs.tf
├── locals.tf
├── screenshots/
|       ├── README.md
│       └── Lab-Project-Frontend-Backend.md
└── .gitignore

## 📦 Terraform Modules

### Subnet Module
Responsible for:
- Creating VPC
- Creating public subnet
- Internet gateway and routing

### Webserver Module
Responsible for:
- Creating EC2 instances
- Attaching security groups
- Assigning SSH key pairs

## ⚙️ Ansible Roles

### Backend Role
- Installs Apache HTTPD
- Enables and starts the service
- Deploys a unique index page on each backend

### Frontend Role
- Installs Nginx
- Configures Nginx as a reverse proxy
- Defines upstream with:
  - 2 active backend servers
  - 1 backup backend server

### Common Role
- Used for shared configurations (optional base setup)

## 🔄 Automation Flow

1. terraform init
2. terraform apply -auto-approve
3. Terraform provisions infrastructure
4. Terraform triggers Ansible using null_resource
5. Ansible configures frontend and backend servers automatically

No manual execution of ansible-playbook is required.

## ▶️ How to Run the Project

### Prerequisites
- AWS CLI configured
- Terraform installed
- Ansible installed
- SSH key present locally (not committed)

### Steps
terraform init
terraform apply -auto-approve

## ✅ Verification

- Access backend servers directly:
  http://<backend-public-ip>

- Access frontend load balancer:
  http://<frontend-public-ip>

- Load balancing observed between backend 1 and backend 2
- Backup backend responds when primary backends are stopped

## 🏁 Conclusion

This project demonstrates a complete DevOps workflow using Infrastructure as Code and Configuration Management.  
It fulfills all lab requirements, uses Ansible roles correctly, and ensures automated, repeatable deployments.

## 👤 Author

Name: Safa Jahangir
Course: Cloud Computing
Lab Type: Open-Ended Lab Project
