#!/bin/bash
# Update system and install dependencies
apt update -y && apt upgrade -y
apt install -y nginx

# Start Nginx and enable it to run on boot
systemctl start nginx
systemctl enable nginx

echo "<h1>Welcome to Public EC2 - Frontend Server</h1>" > /var/www/html/index.html
