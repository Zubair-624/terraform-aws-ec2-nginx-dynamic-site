#!/bin/bash

exec > /var/log/user_data.log 2>&1
set -e

echo "========================================="
echo " Starting user_data.sh"
echo " Time: $(date)"
echo "========================================="

echo "[1/6] Updating system packages..."
apt-get update -y
apt-get upgrade -y
echo "System updated"

echo "[2/6] Installing Nginx and dependencies..."
apt-get install -y nginx unzip curl
echo "Nginx installed"

echo "[3/6] Installing AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm -rf awscliv2.zip aws/
echo "AWS CLI v2 installed"

echo "[4/6] Starting Nginx..."
systemctl start nginx
systemctl enable nginx
echo "Nginx started"

echo "[5/6] Downloading website from S3..."
rm -rf /var/www/html/*
aws s3 sync s3://devops-zubair-terraform-state/website/ /var/www/html/ \
    --region us-east-1
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
echo "Website deployed"

echo "[6/6] Restarting Nginx..."
systemctl restart nginx
echo "Nginx restarted"

echo "========================================="
echo " user_data.sh completed successfully!"
echo " Time: $(date)"
echo "========================================="