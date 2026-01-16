# AWS High-Availability Load Balancer Project

## 📋 Summary
This repository contains Infrastructure-as-Code (Terraform) and Configuration Management (Ansible) to deploy a redundant web architecture on AWS.

### Key Features:
- **Dynamic Load Balancing**: Nginx configured to distribute traffic across multiple backends.
- **High Availability**: Implementation of a `backup` server logic to ensure zero downtime.
- **Secure Networking**: Backend communication performed over **Private IPs**.

## 🛠️ Technical Highlights

### Nginx Failover Logic
The load balancer uses a Jinja2 template to dynamically inject backend Private IPs.
```nginx
upstream backend_servers {
    server {{ hostvars['backend1'].private_ip }}:80;
    server {{ hostvars['backend2'].private_ip }}:80;
    server {{ hostvars['backend3'].private_ip }}:80 backup;
}
```


## ✅ Verification & Results
- **Deployment**: Successful execution of Ansible playbooks across 4 nodes.
- **Failover Test**: Verified that traffic shifts to Backend 3 when primary nodes are down.
- **Documentation**: Detailed step-by-step screenshots and terminal logs are available in the **Open_Ended_Lab_Report_Terraform_Ansible.pdf** uploaded to this repository.


