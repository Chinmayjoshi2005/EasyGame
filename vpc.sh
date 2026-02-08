#!/bin/bash
set -euo pipefail

# ================= COLORS =================
BLACK_TEXT=$'\033[0;90m'
RED_TEXT=$'\033[0;91m'
GREEN_TEXT=$'\033[0;92m'
YELLOW_TEXT=$'\033[0;93m'
BLUE_TEXT=$'\033[0;94m'
MAGENTA_TEXT=$'\033[0;95m'
CYAN_TEXT=$'\033[0;96m'
WHITE_TEXT=$'\033[0;97m'
ORANGE_TEXT=$'\033[38;5;214m'
RESET_FORMAT=$'\033[0m'
BOLD_TEXT=$'\033[1m'

# ================= FUNCTIONS =================
log() {
  echo "${ORANGE_TEXT}${BOLD_TEXT}[$(date +%T)] $1${RESET_FORMAT}"
}

success() {
  echo "${GREEN_TEXT}${BOLD_TEXT}✔ $1${RESET_FORMAT}"
}

fail() {
  echo "${RED_TEXT}${BOLD_TEXT}✘ $1${RESET_FORMAT}"
  exit 1
}

# ================= BANNER =================
echo "${ORANGE_TEXT}${BOLD_TEXT}==================================================================${RESET_FORMAT}"
echo "${ORANGE_TEXT}${BOLD_TEXT}                  VPC Network Peering Setup.                      ${RESET_FORMAT}"
echo "${ORANGE_TEXT}${BOLD_TEXT}==================================================================${RESET_FORMAT}"
echo
# Welcome message with ASCII art
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

# ================= INPUT =================
# Get user input for required values
echo "${YELLOW}Please enter the following configuration details:${RESET}"
read -p "${YELLOW}Enter the Second Project ID: ${RESET}" SECOND_PROJECT_ID
read -p "${YELLOW}Enter Zone 1 for first project (e.g., us-west1-d): ${RESET}" ZONE_1
read -p "${YELLOW}Enter Zone 2 for second project (e.g., us-north1): ${RESET}" ZONE_2

# Initialize variables
echo
echo "${GREEN}${BOLD}Initializing environment variables...${RESET}"
export FIRST_PROJECT_ID=$DEVSHELL_PROJECT_ID
export SECOND_PROJECT_ID=$SECOND_PROJECT_ID
export ZONE_1=$ZONE_1
export ZONE_2=$ZONE_2

# Derive regions from zones
export REGION_1="${ZONE_1%-*}"
export REGION_2="${ZONE_2%-*}"

echo "${GREEN}✓ First Project: $FIRST_PROJECT_ID${RESET}"
echo "${GREEN}✓ Second Project: $SECOND_PROJECT_ID${RESET}"
echo "${GREEN}✓ Zone 1: $ZONE_1 (Region: $REGION_1)${RESET}"
echo "${GREEN}✓ Zone 2: $ZONE_2 (Region: $REGION_2)${RESET}"
echo

# First Project Setup
echo "${BLUE}${BOLD}Configuring first project ($FIRST_PROJECT_ID)...${RESET}"
gcloud config set project $FIRST_PROJECT_ID

# Create Network A
echo "${YELLOW}Creating network-a in $FIRST_PROJECT_ID...${RESET}"
gcloud compute networks create network-a --subnet-mode custom
gcloud compute networks subnets create network-a-subnet --network network-a \
    --range 10.0.0.0/16 --region $REGION_1
echo "${GREEN}✓ Network A created with subnet 10.0.0.0/16${RESET}"

# Create VM in Network A
echo "${YELLOW}Creating vm-a in $ZONE_1...${RESET}"
gcloud compute instances create vm-a \
    --zone $ZONE_1 \
    --network network-a \
    --subnet network-a-subnet \
    --machine-type e2-small
echo "${GREEN}✓ Instance vm-a created successfully${RESET}"

# Firewall Rules for Network A
echo "${YELLOW}Configuring firewall rules for network-a...${RESET}"
gcloud compute firewall-rules create network-a-fw \
    --network network-a \
    --allow tcp:22,icmp
echo "${GREEN}✓ Firewall rules configured for network-a${RESET}"

# Second Project Setup
echo
echo "${BLUE}${BOLD}Configuring second project ($SECOND_PROJECT_ID)...${RESET}"
gcloud config set project $SECOND_PROJECT_ID

# Create Network B
echo "${YELLOW}Creating network-b in $SECOND_PROJECT_ID...${RESET}"
gcloud compute networks create network-b --subnet-mode custom
gcloud compute networks subnets create network-b-subnet --network network-b \
    --range 10.8.0.0/16 --region $REGION_2
echo "${GREEN}✓ Network B created with subnet 10.8.0.0/16${RESET}"

# Create VM in Network B
echo "${YELLOW}Creating vm-b in $ZONE_2...${RESET}"
gcloud compute instances create vm-b \
    --zone $ZONE_2 \
    --network network-b \
    --subnet network-b-subnet \
    --machine-type e2-small
echo "${GREEN}✓ Instance vm-b created successfully${RESET}"

# Firewall Rules for Network B
echo "${YELLOW}Configuring firewall rules for network-b...${RESET}"
gcloud compute firewall-rules create network-b-fw \
    --network network-b \
    --allow tcp:22,icmp
echo "${GREEN}✓ Firewall rules configured for network-b${RESET}"

# VPC Peering Configuration
echo
echo "${BLUE}${BOLD}Setting up VPC peering between projects...${RESET}"

# First project peering
echo "${YELLOW}Creating peering from $FIRST_PROJECT_ID to $SECOND_PROJECT_ID...${RESET}"
gcloud config set project $FIRST_PROJECT_ID
gcloud compute networks peerings create peer-ab \
    --network=network-a \
    --peer-project=$SECOND_PROJECT_ID \
    --peer-network=network-b
echo "${GREEN}✓ Peering connection initiated from network-a to network-b${RESET}"

# Second project peering
echo "${YELLOW}Creating peering from $SECOND_PROJECT_ID to $FIRST_PROJECT_ID...${RESET}"
gcloud config set project $SECOND_PROJECT_ID
gcloud compute networks peerings create peer-ba \
    --network=network-b \
    --peer-project=$FIRST_PROJECT_ID \
    --peer-network=network-a
echo "${GREEN}✓ Peering connection initiated from network-b to network-a${RESET}"

# Final Output
echo
echo "${GREEN}Successfully configured VPC peering between:${RESET}"
echo " • Project ${FIRST_PROJECT_ID} (Network: network-a)"
echo " • Project ${SECOND_PROJECT_ID} (Network: network-b)"
echo
echo "${ORANGE_TEXT}${BOLD_TEXT}=======================================================${RESET_FORMAT}"
echo "${ORANGE_TEXT}${BOLD_TEXT}              LAB COMPLETED SUCCESSFULLY               ${RESET_FORMAT}"
echo "${ORANGE_TEXT}${BOLD_TEXT}=======================================================${RESET_FORMAT}"
echo
echo "${MAGENTA}For more cloud tutorials, subscribe to:${RESET}"
echo "${ORANGE_TEXT}${BOLD_TEXT}Subscribe: https://www.youtube.com/@Chinmay_Joshi-CJ${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}Like • Share • Subscribe${RESET_FORMAT}"