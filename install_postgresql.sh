#!/bin/bash

# Disable default postgresql module to avoid conflicts
sudo dnf -qy module disable postgresql

# Add official PostgreSQL 15 repo
sudo tee /etc/yum.repos.d/pgdg.repo > /dev/null <<EOF
[pgdg15]
name=PostgreSQL 15 for RHEL 9 - x86_64
baseurl=https://download.postgresql.org/pub/repos/yum/15/redhat/rhel-9-x86_64
enabled=1
gpgcheck=0
EOF

# Install PostgreSQL 15 server and contrib packages
sudo dnf install -y postgresql15-server postgresql15-contrib

# Initialize database and enable PostgreSQL service
sudo /usr/pgsql-15/bin/postgresql-15-setup initdb
sudo systemctl enable --now postgresql-15
