#!/bin/bash

exec > /var/log/user_data.log 2>&1
set -e

echo "========================================="
echo " Starting user_data.sh"
echo " Time: $(date)"
echo "========================================="

echo "[1/5] Updating system packages..."
apt-get update -y
apt-get upgrade -y
echo "System updated"

echo "[2/5] Installing Nginx and AWS CLI..."
apt-get install -y nginx awscli
echo "Nginx and AWS CLI installed"

echo "[3/5] Starting Nginx..."
systemctl start nginx
systemctl enable nginx
echo "Nginx started"

echo "[4/5] Downloading website from S3..."

rm -rf /var/www/html/*

aws s3 sync s3://devops-zubair-terraform-state/website/ /var/www/html/ \
    --region us-east-1

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
echo "Website downloaded and deployed"

echo "[5/5] Restarting Nginx..."
systemctl restart nginx
echo "Nginx restarted"

echo "========================================="
echo " user_data.sh completed successfully!"
echo " Time: $(date)"
echo "========================================="