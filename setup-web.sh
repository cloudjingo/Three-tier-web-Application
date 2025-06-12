#!/bin/bash

# Update system
sudo dnf update -y

# Install Apache HTTP Server
sudo dnf install -y httpd

# Enable and start Apache
sudo systemctl enable httpd
sudo systemctl start httpd

# Set up a simple proxy (adjust IP to your App instance private IP)
cat << EOF | sudo tee /etc/httpd/conf.d/app_proxy.conf
ProxyPreserveHost On
ProxyPass /api http://10.0.2.10:3000/api
ProxyPassReverse /api http://10.0.2.10:3000/api
EOF

# Restart Apache to apply config
sudo systemctl restart httpd

echo "Web server setup complete."
