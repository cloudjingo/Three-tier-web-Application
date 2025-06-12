# Single AZ 3-Tier Web Application Deployment on AWS Using EC2 Database

## Project Overview

This project demonstrates deploying a 3-tier web application architecture in a **single AWS Availability Zone** using only **EC2 instances**, including the database tier without relying on managed services like RDS. It covers network design, security group configuration, and software setup on the instances.

## Architecture Diagram

![Architecture Diagram](docs/architecture-diagram.png)

---

## Tools and Technologies

| Category         | Tools/Services Used                  |
|------------------|------------------------------------|
| Cloud Provider   | AWS EC2, VPC, NAT Gateway           |
| Operating System | Amazon Linux 2023 AMI                |
| Database         | PostgreSQL 15 (installed on EC2)    |
| Web Server       | Apache / Nginx                      |
| Security         | AWS Security Groups                 |
| Networking       | VPC, Subnets, NAT Gateway          |

---

## Components and Resources

| Resource Type    | Description                                         |
|------------------|-----------------------------------------------------|
| EC2 Instances    | Three instances for Web, Application, and Database tiers |
| Security Groups  | Firewall rules restricting and allowing traffic between tiers |
| VPC & Subnets    | Custom VPC with designated subnets for isolation    |
| NAT Gateway      | Allows private subnet internet access                |

---

## Deployment Steps

### Step 1: EC2 Instances Provisioning

- Launch three EC2 instances in the same AWS Availability Zone.
- Assign appropriate security groups to each instance (Web, App, DB).

### Step 2: Database Setup (PostgreSQL)

- SSH into the database EC2 instance.
- Run `scripts/setup-db.sh` to install and configure PostgreSQL 15.
- Configure PostgreSQL to accept connections only from the Application tier.

### Step 3: Application Layer Setup

- SSH into the application EC2 instance.
- Run `scripts/setup-app.sh` to deploy the backend application.
- Configure the app to connect securely to the PostgreSQL database using the DB instance’s private IP.

### Step 4: Web Server Configuration

- SSH into the web EC2 instance.
- Run `scripts/setup-web.sh` to install and configure Apache or Nginx.
- Set up the web server to serve static frontend content and proxy backend API requests to the App instance.

---

## Networking and Security

- All instances are deployed within the same VPC and Availability Zone.
- Security Groups are configured to strictly allow only necessary inbound and outbound traffic:
  - Web SG: HTTP/HTTPS traffic from the internet.
  - App SG: Accepts traffic only from the Web SG.
  - DB SG: Accepts database port traffic only from the App SG.
- NAT Gateway configured for private subnet instances requiring outbound internet access.

---

## Testing and Validation

- Verify connectivity between Web and App tiers via private IP.
- Test App to Database connection on port 5432.
- Access the web application from a browser using the public IP or domain name assigned to the Web tier.
- Validate security group rules by confirming restricted access from unauthorized IPs.


---

## Repository Structure

