#!/bin/bash

# Define color variables
BLACK_TEXT=$'\033[0;90m'
RED_TEXT=$'\033[0;91m'
GREEN_TEXT=$'\033[0;92m'
YELLOW_TEXT=$'\033[0;93m'
BLUE_TEXT=$'\033[0;94m'
MAGENTA_TEXT=$'\033[0;95m'
CYAN_TEXT=$'\033[0;96m'
WHITE_TEXT=$'\033[0;97m'
ORANGE_TEXT=$'\033[38;5;214m'  

NO_COLOR=$'\033[0m'
RESET_FORMAT=$'\033[0m'

# Define text formatting variables
BOLD_TEXT=$'\033[1m'
UNDERLINE_TEXT=$'\033[4m'


echo "${ORANGE_TEXT}${BOLD_TEXT}==================================================================${RESET_FORMAT}"
echo "${ORANGE_TEXT}${BOLD_TEXT}      SUBSCRIBE TO EASY GAME FOR MORE SUCH TUTORIALS AND GUIDE    ${RESET_FORMAT}"
echo "${ORANGE_TEXT}${BOLD_TEXT}==================================================================${RESET_FORMAT}"
echo

# Welcome message with animation
echo -e "${CYAN}"
cat << "EOF"
   _______                _     _   _________
  |   ___ |              \  \ /  / |   _____ |        _
  |  |__     __ _   ____  \  V  /  |  |   ___   __ _  \ \ __   __    ____
  |   __|   / _` | / ___|  \   /   |  |  |   | / _` | | | _  | _  | /  _ \
  |  |____ | (_| | \ __ \   | |     \  \__|  || (_| | | |  | |  | ||   __/
  |_______| \__,_| |____/   |_|      \_______| \__,_| |_|  |_|  |_| \____|
EOF
echo -e "${NC}"

#lab start

echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}🚀 Starting Google Kubernetes Engine Lab Setup...${RESET_FORMAT}"
echo "${YELLOW_TEXT}${BOLD_TEXT}📚 This lab will guide you through Kubernetes orchestration!${RESET_FORMAT}"
echo ""

# Display progress function with emojis
progress() {
    echo "${GREEN_TEXT}${BOLD_TEXT}✅ $1${RESET_FORMAT}"
    sleep 2
}

# Display section header function
section_header() {
    echo ""
    echo "${BLUE_TEXT}${BOLD_TEXT}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET_FORMAT}"
    echo "${CYAN_TEXT}${BOLD_TEXT}$1${RESET_FORMAT}"
    echo "${BLUE_TEXT}${BOLD_TEXT}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET_FORMAT}"
    echo ""
}

# Task: Initial Setup
echo "${MAGENTA_TEXT}${BOLD_TEXT}# Task: Initial Setup${RESET_FORMAT}"
section_header "⚙️  TASK 0: Initial Configuration"
progress "🔐 Authenticating with Google Cloud..."
gcloud auth list

export ZONE=$(gcloud compute project-info describe --format="value(commonInstanceMetadata.items[google-compute-default-zone])")
export REGION=$(gcloud compute project-info describe --format="value(commonInstanceMetadata.items[google-compute-default-region])")
export PROJECT_ID=$(gcloud config get-value project)

progress "🌍 Setting compute zone to: $ZONE"
gcloud config set compute/zone "$ZONE"

# Task: Create Kubernetes Cluster
echo "${MAGENTA_TEXT}${BOLD_TEXT}# Task: Create Kubernetes Cluster${RESET_FORMAT}"
section_header "🎯 TASK 1: Create Kubernetes Cluster"
progress "🏗️  Creating Kubernetes cluster 'io' in zone: $ZONE (This may take a few minutes...)"
gcloud container clusters create io --zone $ZONE
progress "🎉 Cluster 'io' created successfully!"

# Task: Get Sample Code
echo "${MAGENTA_TEXT}${BOLD_TEXT}# Task: Get Sample Code${RESET_FORMAT}"
section_header "📦 TASK 2: Get Sample Code"
progress "📥 Downloading sample code from Google Cloud Storage..."
gcloud storage cp -r gs://spls/gsp021/* .
cd orchestrate-with-kubernetes/kubernetes
progress "📂 Sample code downloaded and ready!"
ls

# Task: Quick Kubernetes Demo
echo "${MAGENTA_TEXT}${BOLD_TEXT}# Task: Quick Kubernetes Demo${RESET_FORMAT}"
section_header "🚀 TASK 3: Quick Kubernetes Demo"
progress "🐳 Creating nginx deployment (version 1.27.0)..."
kubectl create deployment nginx --image=nginx:1.27.0
kubectl get pods

progress "🌐 Exposing nginx as LoadBalancer service..."
kubectl expose deployment nginx --port 80 --type LoadBalancer
kubectl get services

# Wait for external IP to be assigned
progress "⏳ Waiting for external IP assignment..."
sleep 30
kubectl get services
progress "✨ Nginx service is now accessible externally!"

# Task: Create Fortune App Pod
echo "${MAGENTA_TEXT}${BOLD_TEXT}# Task: Create Fortune App Pod${RESET_FORMAT}"
section_header "📦 TASK 4: Create Pods"
progress "🎲 Creating fortune-app pod..."
kubectl create -f pods/fortune-app.yaml
kubectl get pods

progress "🔍 Describing fortune-app pod..."
kubectl describe pods fortune-app

# Task: Interact with Pods (Port Forwarding)
echo "${MAGENTA_TEXT}${BOLD_TEXT}# Task: Interact with Pods (Port Forwarding)${RESET_FORMAT}"
section_header "🔌 TASK 5: Interact with Pods"
progress "🔗 Setting up port forwarding for fortune-app..."
echo "${YELLOW_TEXT}Note: Port forwarding runs in background for testing${RESET_FORMAT}"
kubectl port-forward fortune-app 10080:8080 &
PORT_FORWARD_PID=$!
sleep 5

progress "🎯 Testing fortune app endpoint..."
curl http://127.0.0.1:10080

progress "🔒 Testing secure endpoint (expected to fail)..."
curl http://127.0.0.1:10080/secure

progress "🔑 Logging in to get authentication token..."
TOKEN=$(curl -s -u user:password http://127.0.0.1:10080/login | jq -r '.token')
echo "${GREEN_TEXT}${BOLD_TEXT}🎫 Token acquired successfully!${RESET_FORMAT}"

progress "✅ Testing secure endpoint with authentication token..."
curl -H "Authorization: Bearer $TOKEN" http://127.0.0.1:10080/secure

progress "📋 Viewing application logs..."
kubectl logs fortune-app

# Task: Create Secure Fortune Pod and Service
echo "${MAGENTA_TEXT}${BOLD_TEXT}# Task: Create Secure Fortune Pod and Service${RESET_FORMAT}"
section_header "🔐 TASK 7: Create a Service"
progress "🔒 Creating TLS certificates secret..."
kubectl create secret generic tls-certs --from-file tls/

progress "⚙️  Creating nginx proxy configuration..."
kubectl create configmap nginx-proxy-conf --from-file nginx/proxy.conf

progress "🎲 Creating secure-fortune pod..."
kubectl create -f pods/secure-fortune.yaml

progress "🌐 Creating fortune-app service..."
kubectl create -f services/fortune-app.yaml

progress "🔥 Creating firewall rule for port 31000..."
gcloud compute firewall-rules create allow-fortune-nodeport --allow=tcp:31000

# Task: Add Labels to Pods
echo "${MAGENTA_TEXT}${BOLD_TEXT}# Task: Add Labels to Pods${RESET_FORMAT}"
section_header "🏷️  TASK 8: Add Labels to Pods"
progress "🏷️  Adding 'secure=enabled' label to secure-fortune pod..."
kubectl label pods secure-fortune 'secure=enabled'
kubectl get pods secure-fortune --show-labels

progress "🔍 Checking service endpoints..."
kubectl describe services fortune-app | grep Endpoints

# Test secure fortune service
progress "🧪 Testing secure fortune service externally..."
EXTERNAL_IP=$(gcloud compute instances list --format="value(EXTERNAL_IP)" | head -1)
curl -k https://$EXTERNAL_IP:31000
progress "🎉 Secure fortune service is working!"

# Task: Create Microservices Deployments
echo "${MAGENTA_TEXT}${BOLD_TEXT}# Task: Create Microservices Deployments${RESET_FORMAT}"
section_header "🎯 TASK 10: Create Deployments"
echo "${CYAN_TEXT}${BOLD_TEXT}Breaking down the fortune-app into microservices:${RESET_FORMAT}"
echo "${YELLOW_TEXT}  • Auth Service - Generates JWT tokens${RESET_FORMAT}"
echo "${YELLOW_TEXT}  • Fortune Service - Serves fortunes${RESET_FORMAT}"
echo "${YELLOW_TEXT}  • Frontend Service - Routes traffic${RESET_FORMAT}"
echo ""

progress "🔐 Creating auth microservice deployment..."
kubectl create -f deployments/auth.yaml
sleep 5

progress "🌐 Creating auth service..."
kubectl create -f services/auth.yaml

progress "🎲 Creating fortune service deployment..."
kubectl create -f deployments/fortune-service.yaml
sleep 5

progress "🌐 Creating fortune service..."
kubectl create -f services/fortune-service.yaml

progress "⚙️  Creating frontend configuration..."
kubectl create configmap nginx-frontend-conf --from-file=nginx/frontend.conf

progress "🎨 Creating frontend deployment..."
kubectl create -f deployments/frontend.yaml
sleep 5

progress "🌐 Creating frontend service..."
kubectl create -f services/frontend.yaml

# Wait for frontend service to get external IP
echo "${MAGENTA_TEXT}${BOLD_TEXT}# Wait for frontend service to get external IP${RESET_FORMAT}"
progress "⏳ Waiting for frontend external IP assignment..."
sleep 30

progress "📊 Checking frontend service status..."
kubectl get services frontend

# Test frontend service
echo "${MAGENTA_TEXT}${BOLD_TEXT}# Test frontend service${RESET_FORMAT}"
FRONTEND_IP=$(kubectl get service frontend -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
if [ ! -z "$FRONTEND_IP" ]; then
    progress "🧪 Testing frontend service at https://$FRONTEND_IP"
    curl -k https://$FRONTEND_IP
    echo ""
    progress "🎉 All microservices are up and running!"
fi

# Clean up port forwarding
progress "🧹 Cleaning up background processes..."
kill $PORT_FORWARD_PID 2>/dev/null

#lab completed

echo ""
echo "${BLUE_TEXT}${BOLD_TEXT}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}              🎉 LAB COMPLETED SUCCESSFULLY! 🎉              ${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET_FORMAT}"
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}📝 Summary of what you accomplished:${RESET_FORMAT}"
echo "${GREEN_TEXT}  ✅ Created a Kubernetes cluster${RESET_FORMAT}"
echo "${GREEN_TEXT}  ✅ Deployed and managed Pods${RESET_FORMAT}"
echo "${GREEN_TEXT}  ✅ Created and exposed Services${RESET_FORMAT}"
echo "${GREEN_TEXT}  ✅ Worked with Labels and Selectors${RESET_FORMAT}"
echo "${GREEN_TEXT}  ✅ Created Deployments for microservices${RESET_FORMAT}"
echo ""
echo "${ORANGE_TEXT}${BOLD_TEXT}🔔 Subscribe for more: https://www.youtube.com/@Chinmay_Joshi-CJ${RESET_FORMAT}"
echo "${YELLOW_TEXT}${BOLD_TEXT}👍 Don't forget to Like, Share and Subscribe for more Videos${RESET_FORMAT}"
echo ""