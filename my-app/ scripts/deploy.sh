#!/bin/bash
set -e

REGION="ap-southeast-1"
ACCOUNT_ID="123456789012"
REPO_URI="$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/my-app"

echo "Logging in to ECR..."
aws ecr get-login-password --region $REGION | \
  docker login --username AWS --password-stdin $REPO_URI

echo "Pulling latest image..."
docker pull $REPO_URI:latest

echo "Stopping old container (if exists)..."
docker stop my-app || true
docker rm my-app || true

echo "Starting new container..."
docker run -d \
  --name my-app \
  -p 80:3000 \
  --restart unless-stopped \
  $REPO_URI:latest

echo "Deployment complete."