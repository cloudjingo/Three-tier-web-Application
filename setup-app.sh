#!/bin/bash

# Update system
sudo dnf update -y

# Install dependencies 
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo dnf install -y nodejs git


cd /home/ec2-user/app

# Install app dependencies
npm install

# Start the app 
npm start &

echo "Backend application setup complete."
