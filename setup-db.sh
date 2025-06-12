#!/bin/bash

# Update and install PostgreSQL 15
sudo dnf update -y
sudo dnf install -y postgresql-server postgresql-contrib

# Initialize database
sudo /usr/bin/postgresql-setup --initdb

# Enable and start PostgreSQL service
sudo systemctl enable postgresql
sudo systemctl start postgresql

# Allow remote connections from App tier subnet 
PG_HBA_CONF="/var/lib/pgsql/data/pg_hba.conf"
POSTGRESQL_CONF="/var/lib/pgsql/data/postgresql.conf"

# Backup config files
sudo cp $PG_HBA_CONF ${PG_HBA_CONF}.bak
sudo cp $POSTGRESQL_CONF ${POSTGRESQL_CONF}.bak

# Allow MD5 auth from your App subnet, e.g., 10.0.2.0/24
echo "host    all             all             10.0.2.0/24           md5" | sudo tee -a $PG_HBA_CONF

# Listen on all interfaces
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" $POSTGRESQL_CONF

# Restart PostgreSQL
sudo systemctl restart postgresql

echo "PostgreSQL installation and configuration complete."

