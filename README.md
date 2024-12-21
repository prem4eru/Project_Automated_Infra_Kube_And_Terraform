# Project_Automated_Infra_Kube_And_Terraform
Project Title : Automated Infrastructure Management with Kubernetes and Terraform 
Project Goal :
Use Terraform to automate the setup and management of cloud infrastructure.
Use Kubernetes to manage and run applications automatically.
Make sure the infrastructure can heal itself, scale up or down, and follows Infrastructure as Code (IaC) principles.

Directory structure for infrastructure
.
├── Project_Architecture_Diagram
│   └── diagram.jpeg.jpeg       
├── README.md
├── environment
│   ├── dev
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variable.tf
│   ├── prod
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variable.tf
│   └── staging
│       ├── main.tf
│       ├── output.tf
│       ├── terraform.tfstate
│       ├── terraform.tfstate.backup
│       ├── terraform.tfvars
│       └── variable.tf
└── modules
    ├── ec2
    │   ├── id-rsa
    │   ├── id-rsa.pub
    │   ├── main.tf
    │   ├── output.tf
    │   └── variable.tf
    ├── eks
    │   ├── main.tf
    │   ├── output.tf
    │   └── variable.tf
    ├── security-groups
    │   ├── main.tf
    │   ├── output.tf
    │   └── varaiable.tf
    └── vpc
        ├── main.tf
        ├── output.tf
        └── variable.tf

# Breakdown of Key Directories and Files:
Project_Automated_Infra_Kube_And_Terraform:
terraform: Contains Terraform configurations to provision and manage cloud infrastructure.
modules: Reusable Terraform modules for specific resources (e.g., networking, compute, Kubernetes).
environments: Environment-specific configurations (dev, staging, production).
kubernetes: Contains Kubernetes manifests, including deployments, services, and Helm charts.
ansible: Contains Ansible playbooks for post-deployment configuration and infrastructure management.
scripts: Shell scripts for automating Terraform and Kubernetes operations.

    
