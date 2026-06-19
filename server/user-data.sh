#!/bin/bash
sudo yum install ruby wget -y
cd /home/ec2-user
wget https://aws-codedeploy-ap-southeast-1.s3.ap-southeast-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo systemctl start codedeploy-agent
sudo systemctl enable codedeploy-agent

# เช็คว่ารันอยู่
sudo systemctl status codedeploy-agent