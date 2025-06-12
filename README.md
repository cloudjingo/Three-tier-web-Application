# 3-Tier Web Application Deployment on AWS with PostgreSQL

## Overview

This project deploys a simple 3-tier web application on AWS EC2 instances, using a PostgreSQL database in a private subnet. The setup includes proper networking, security, and package management on Amazon Linux.

---

## AWS Resources Created

- **VPC** with:
  - Public subnet (for NAT Gateway)
  - Private subnet (for Application and Database servers)
- **NAT Gateway** for internet access to private subnet instances
- **EC2 Instances**:
  - Web server (public subnet)
  - Application server (private subnet)
  - Database server (PostgreSQL, private subnet)
- **Security Groups**:
  - DB SG: allows inbound PostgreSQL (port 5432) from App server subnet only
  - App SG: allows inbound traffic from Web server subnet
  - Web SG: allows HTTP/HTTPS inbound from internet; SSH from your IP

---

## Tools Used

- Amazon Linux 2023 AMI on EC2 instances
- `dnf` package manager for software installation
- PostgreSQL 15 installed from PostgreSQL official yum repository
- `systemd` for service management
- AWS Systems Manager Session Manager or Bastion host for secure SSH access to private instances

---

## Setup Summary

1. Disable default PostgreSQL module to avoid conflicts:

   ```bash
   sudo dnf -qy module disable postgresql
   ```

2. Add PostgreSQL 15 official repository by creating `/etc/yum.repos.d/pgdg.repo` with:

   ```
   [pgdg15]
   name=PostgreSQL 15 for RHEL 9 - x86_64
   baseurl=https://download.postgresql.org/pub/repos/yum/15/redhat/rhel-9-x86_64
   enabled=1
   gpgcheck=0
   ```

3. Install PostgreSQL 15 server and contrib packages:

   ```bash
   sudo dnf install -y postgresql15-server postgresql15-contrib
   ```

4. Initialize and start PostgreSQL service:

   ```bash
   sudo /usr/pgsql-15/bin/postgresql-15-setup initdb
   sudo systemctl enable --now postgresql-15
   ```

5. Configure PostgreSQL for remote access:
   - Set `listen_addresses = '*'` in `postgresql.conf`
   - Allow App subnet CIDR in `pg_hba.conf` with `md5` authentication
   - Reload PostgreSQL service

6. Create your database and user with proper permissions.

7. Configure Security Groups to restrict traffic:
   - DB SG: inbound port 5432 from App subnet only
   - App SG: inbound from Web server subnet
   - Web SG: inbound HTTP/HTTPS from Internet; SSH from your IP only

8. Access private subnet instances securely using:
   - AWS Systems Manager Session Manager OR
   - Bastion host in public subnet

---

## Notes

- The NAT Gateway allows private subnet instances internet access without public IPs.
- PostgreSQL is installed manually because Amazon Linux 2023 does not have compatible default repos.
- Security Group rules ensure minimal exposure of services.
- AWS Systems Manager Session Manager is preferred for private instance access due to security.


