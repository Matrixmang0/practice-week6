#!/bin/bash
set -e

echo "🔧 Building Docker image..."
docker build -t iris-api docker/

echo "🏷️ Tagging image for Google Artifact Registry..."
docker tag iris-api uus-central1-docker.pkg.dev/neural-mantra-461520-m0/my-repo/iris-api:latest

echo "🚀 Pushing image to Artifact Registry..."
docker push us-central1-docker.pkg.dev/neural-mantra-461520-m0/my-repo/iris-api:latest

echo "♻️  Updating Kubernetes deployment image..."
kubectl set image deployment/iris-deployment iris-api=us-central1-docker.pkg.dev/neural-mantra-461520-m0/my-repo/iris-api:latest --namespace=default
echo "✅ Deployment updated with new image!"

