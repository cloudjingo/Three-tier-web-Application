#!/bin/bash

# Update system
sudo dnf update -y

# Install dependencies (example: Node.js for backend app)
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo dnf install -y nodejs git

# Clone your backend repo (replace with your repo)
git clone https://github.com/yourusername/your-backend-repo.git /home/ec2-user/app

cd /home/ec2-user/app

# Install app dependencies
npm install

# Start the app (adjust as per your app)
npm start &

echo "Backend application setup complete."
