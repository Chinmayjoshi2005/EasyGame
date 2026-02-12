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
read -p "${YELLOW_TEXT}Enter Zone: ${RESET}" ZONE

gcloud config set compute/zone $ZONE

gcloud container clusters create hello-world

git clone https://github.com/GoogleCloudPlatform/kubernetes-engine-samples

cd kubernetes-engine-samples/quickstarts/hello-app

docker build -t gcr.io/$DEVSHELL_PROJECT_ID/hello-app:1.0 .

gcloud docker -- push gcr.io/$DEVSHELL_PROJECT_ID/hello-app:1.0

kubectl create deployment hello-app --image=gcr.io/$DEVSHELL_PROJECT_ID/hello-app:1.0

kubectl expose deployment hello-app --name=hello-app --type=LoadBalancer --port=80 --target-port=8080
#lab completed

echo ""
echo "${BLUE_TEXT}${BOLD_TEXT}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}              🎉 LAB COMPLETED SUCCESSFULLY! 🎉              ${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET_FORMAT}"
echo ""

echo ""
echo "${ORANGE_TEXT}${BOLD_TEXT}🔔 Subscribe for more: https://www.youtube.com/@Chinmay_Joshi-CJ${RESET_FORMAT}"
echo "${YELLOW_TEXT}${BOLD_TEXT}👍 Don't forget to Like, Share and Subscribe for more Videos${RESET_FORMAT}"
echo ""