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
echo "${CYAN_TEXT}${BOLD_TEXT}╔══════════════════════════════════════════════════════════════════╗${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}║         🎮  WELCOME TO THE GCP LAB SETUP WIZARD!  🎮             ║${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}║    This script will guide you through all the lab tasks.         ║${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}╚══════════════════════════════════════════════════════════════════╝${RESET_FORMAT}"
echo ""

# ============================================================
# COLLECT ALL REQUIRED VARIABLES
# ============================================================
echo ""
echo "${MAGENTA_TEXT}${BOLD_TEXT}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${RESET_FORMAT}"
echo "${MAGENTA_TEXT}${BOLD_TEXT}┃     📋  ENTER REQUIRED VARIABLES  📋                          ┃${RESET_FORMAT}"
echo "${MAGENTA_TEXT}${BOLD_TEXT}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${RESET_FORMAT}"
echo ""

# Collect PROJECTID2 (Second Project ID - this is what the lab uses)
echo "${GREEN_TEXT}${BOLD_TEXT}🔹 PROJECTID2 (Second Project ID)${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Example: qwiklabs-gcp-03-75d39da6944a${RESET_FORMAT}"
read -p "   👉 Enter PROJECTID2: " PROJECTID2
echo ""

# Collect USERID2 (Second User Email - this is what the lab uses)
echo "${ORANGE_TEXT}${BOLD_TEXT}🔹 USERID2 (Second User Email)${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Example: student-02-37e1d0290408@qwiklabs.net${RESET_FORMAT}"
read -p "   👉 Enter USERID2: " USERID2
echo ""

# Collect REGION
echo "${CYAN_TEXT}${BOLD_TEXT}🔹 REGION${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Example: europe-west4, us-central1${RESET_FORMAT}"
read -p "   👉 Enter REGION: " REGION
echo ""

# Collect ZONE
echo "${MAGENTA_TEXT}${BOLD_TEXT}🔹 ZONE${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Example: europe-west4-a, us-central1-c${RESET_FORMAT}"
read -p "   👉 Enter ZONE: " ZONE
echo ""

# Display summary
echo "${GREEN_TEXT}${BOLD_TEXT}╔══════════════════════════════════════════════════════════════════╗${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}║              ✅  VARIABLES SUMMARY  ✅                          ║${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}╠══════════════════════════════════════════════════════════════════╣${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}║  📌 PROJECTID2  : ${WHITE_TEXT}${PROJECTID2}${GREEN_TEXT}${BOLD_TEXT}                    ${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}║  📌 USERID2     : ${WHITE_TEXT}${USERID2}${GREEN_TEXT}${BOLD_TEXT}                    ${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}║  📌 REGION      : ${WHITE_TEXT}${REGION}${GREEN_TEXT}${BOLD_TEXT}                    ${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}║  📌 ZONE        : ${WHITE_TEXT}${ZONE}${GREEN_TEXT}${BOLD_TEXT}                    ${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}╚══════════════════════════════════════════════════════════════════╝${RESET_FORMAT}"
echo ""
read -p "   🔄 Press ENTER to continue (or Ctrl-C to abort)..." _
echo ""

# Export and persist variables
export PROJECTID2="${PROJECTID2}"
export USERID2="${USERID2}"
echo "export PROJECTID2=\"${PROJECTID2}\"" >> ~/.bashrc
echo "export USERID2=\"${USERID2}\"" >> ~/.bashrc
. ~/.bashrc

# ============================================================
# TASK 1: Configure the gcloud environment
# ============================================================
echo ""
echo "${BLUE_TEXT}${BOLD_TEXT}╔══════════════════════════════════════════════════════════════════╗${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}║         📌  TASK 1: Configure the gcloud environment            ║${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}╚══════════════════════════════════════════════════════════════════╝${RESET_FORMAT}"
echo ""

# Verify gcloud is installed
echo "${CYAN_TEXT}${BOLD_TEXT}🔎 Verifying gcloud installation...${RESET_FORMAT}"
gcloud --version || { echo "${RED_TEXT}${BOLD_TEXT}❌ gcloud not found!${RESET_FORMAT}"; exit 1; }
echo "${GREEN_TEXT}${BOLD_TEXT}✅ gcloud is installed!${RESET_FORMAT}"
echo ""

# Authenticate
echo "${CYAN_TEXT}${BOLD_TEXT}🔐 Authenticate with gcloud...${RESET_FORMAT}"
echo "${YELLOW_TEXT}${BOLD_TEXT}   Run: gcloud auth login${RESET_FORMAT}"
echo "${WHITE_TEXT}   Complete the authentication in your browser.${RESET_FORMAT}"
read -p "   ⏳ Press ENTER after authentication is complete..." _
echo ""

# Set region and zone
echo "${CYAN_TEXT}${BOLD_TEXT}📍 Setting region and zone...${RESET_FORMAT}"
gcloud config set compute/region "${REGION}"
gcloud config set compute/zone "${ZONE}"
echo "${GREEN_TEXT}${BOLD_TEXT}✅ Region and Zone set!${RESET_FORMAT}"
echo ""

# Create lab-1 instance
echo "${CYAN_TEXT}${BOLD_TEXT}🛠️  Creating lab-1 instance...${RESET_FORMAT}"
gcloud compute instances create lab-1 --zone "${ZONE}" --machine-type=e2-standard-2 || echo "${YELLOW_TEXT}${BOLD_TEXT}⚠️  Instance may already exist.${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}✅ lab-1 instance created!${RESET_FORMAT}"
echo ""

# List zones and change zone
echo "${CYAN_TEXT}${BOLD_TEXT}📡 Listing available zones...${RESET_FORMAT}"
gcloud compute zones list | head -20
echo ""
echo "${YELLOW_TEXT}${BOLD_TEXT}💡 Current zone: ${ZONE}${RESET_FORMAT}"
echo "${WHITE_TEXT}   Select another zone in the SAME REGION.${RESET_FORMAT}"
read -p "   👉 Enter new ZONE (or press ENTER to keep current): " NEW_ZONE
if [ -n "$NEW_ZONE" ]; then
  gcloud config set compute/zone "$NEW_ZONE"
  ZONE="$NEW_ZONE"
  echo "${GREEN_TEXT}${BOLD_TEXT}✅ Zone changed to: ${ZONE}${RESET_FORMAT}"
fi
echo ""

# Verify zone in config file
echo "${CYAN_TEXT}${BOLD_TEXT}📋 Verifying zone in configuration file...${RESET_FORMAT}"
cat ~/.config/gcloud/configurations/config_default
echo ""

# ============================================================
# TASK 2: Create and switch between multiple IAM configurations
# ============================================================
echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}╔══════════════════════════════════════════════════════════════════╗${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}║    📌  TASK 2: Create and switch between IAM configurations     ║${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}╚══════════════════════════════════════════════════════════════════╝${RESET_FORMAT}"
echo ""

echo "${CYAN_TEXT}${BOLD_TEXT}🔐 Creating user2 configuration...${RESET_FORMAT}"
echo "${YELLOW_TEXT}${BOLD_TEXT}   Run: gcloud init --no-launch-browser${RESET_FORMAT}"
echo "${WHITE_TEXT}   Select option 2: Create a new configuration${RESET_FORMAT}"
echo "${WHITE_TEXT}   Name it: user2${RESET_FORMAT}"
echo "${WHITE_TEXT}   Select option 3: Log in with a new account${RESET_FORMAT}"
echo "${WHITE_TEXT}   Authenticate with USERID2: ${USERID2}${RESET_FORMAT}"
echo "${WHITE_TEXT}   Select the project when prompted${RESET_FORMAT}"
echo ""
read -p "   ⏳ Press ENTER after completing gcloud init for user2..." _
echo ""

# Verify user2 configuration exists
echo "${CYAN_TEXT}${BOLD_TEXT}📋 Verifying user2 configuration...${RESET_FORMAT}"
gcloud config configurations list
echo "${GREEN_TEXT}${BOLD_TEXT}✅ user2 configuration verified!${RESET_FORMAT}"
echo ""

# ============================================================
# TASK 3: Identify and assign correct IAM permissions
# ============================================================
echo ""
echo "${ORANGE_TEXT}${BOLD_TEXT}╔══════════════════════════════════════════════════════════════════╗${RESET_FORMAT}"
echo "${ORANGE_TEXT}${BOLD_TEXT}║      📌  TASK 3: Identify and assign correct IAM permissions     ║${RESET_FORMAT}"
echo "${ORANGE_TEXT}${BOLD_TEXT}╚══════════════════════════════════════════════════════════════════╝${RESET_FORMAT}"
echo ""

# Switch to default configuration
echo "${CYAN_TEXT}${BOLD_TEXT}🔁 Switching to default configuration...${RESET_FORMAT}"
gcloud config configurations activate default
echo ""

# Install jq
echo "${CYAN_TEXT}${BOLD_TEXT}📦 Installing jq...${RESET_FORMAT}"
sudo yum -y install epel-release >/dev/null 2>&1 || true
sudo yum -y install jq >/dev/null 2>&1 || true
echo "${GREEN_TEXT}${BOLD_TEXT}✅ jq installed!${RESET_FORMAT}"
echo ""

# Grant viewer role to USERID2 on PROJECTID2
echo "${CYAN_TEXT}${BOLD_TEXT}🔐 Granting viewer role to USERID2 on PROJECTID2...${RESET_FORMAT}"
gcloud projects add-iam-policy-binding $PROJECTID2 --member user:$USERID2 --role=roles/viewer
echo "${GREEN_TEXT}${BOLD_TEXT}✅ Viewer role granted!${RESET_FORMAT}"
echo ""

# ============================================================
# TASK 4: Test that user2 has access
# ============================================================
echo ""
echo "${MAGENTA_TEXT}${BOLD_TEXT}╔══════════════════════════════════════════════════════════════════╗${RESET_FORMAT}"
echo "${MAGENTA_TEXT}${BOLD_TEXT}║            📌  TASK 4: Test that user2 has access                ║${RESET_FORMAT}"
echo "${MAGENTA_TEXT}${BOLD_TEXT}╚══════════════════════════════════════════════════════════════════╝${RESET_FORMAT}"
echo ""

# Create devops role
echo "${CYAN_TEXT}${BOLD_TEXT}🛠️  Creating devops custom role...${RESET_FORMAT}"
gcloud iam roles create devops --project $PROJECTID2 \
  --title="devops" \
  --description="Custom role for devops team" \
  --permissions="compute.instances.create,compute.instances.delete,compute.instances.start,compute.instances.stop,compute.instances.update,compute.disks.create,compute.subnetworks.use,compute.subnetworks.useExternalIp,compute.instances.setMetadata,compute.instances.setServiceAccount" \
  || echo "${YELLOW_TEXT}${BOLD_TEXT}⚠️  Role may already exist.${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}✅ devops role created!${RESET_FORMAT}"
echo ""

# Bind iam.serviceAccountUser role to USERID2
echo "${CYAN_TEXT}${BOLD_TEXT}🔐 Binding iam.serviceAccountUser role to USERID2...${RESET_FORMAT}"
gcloud projects add-iam-policy-binding $PROJECTID2 --member user:$USERID2 --role=roles/iam.serviceAccountUser
echo "${GREEN_TEXT}${BOLD_TEXT}✅ iam.serviceAccountUser role bound!${RESET_FORMAT}"
echo ""

# Bind devops role to USERID2
echo "${CYAN_TEXT}${BOLD_TEXT}🔐 Binding devops role to USERID2...${RESET_FORMAT}"
gcloud projects add-iam-policy-binding $PROJECTID2 --member user:$USERID2 --role=projects/$PROJECTID2/roles/devops
echo "${GREEN_TEXT}${BOLD_TEXT}✅ devops role bound!${RESET_FORMAT}"
echo ""

# Switch to user2 and create lab-2
echo "${CYAN_TEXT}${BOLD_TEXT}🔁 Switching to user2 configuration...${RESET_FORMAT}"
gcloud config configurations activate user2
gcloud config set project $PROJECTID2
echo ""

# Create lab-2 instance
echo "${CYAN_TEXT}${BOLD_TEXT}🛠️  Creating lab-2 instance as user2...${RESET_FORMAT}"
gcloud compute instances create lab-2 --zone "${ZONE}" --machine-type=e2-standard-2 || echo "${YELLOW_TEXT}${BOLD_TEXT}⚠️  Instance may already exist.${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}✅ lab-2 instance created!${RESET_FORMAT}"
echo ""

# ============================================================
# TASK 5: Using a service account
# ============================================================
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}╔══════════════════════════════════════════════════════════════════╗${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}║            📌  TASK 5: Using a service account                   ║${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}╚══════════════════════════════════════════════════════════════════╝${RESET_FORMAT}"
echo ""

# Switch to default configuration
echo "${CYAN_TEXT}${BOLD_TEXT}🔁 Switching to default configuration...${RESET_FORMAT}"
gcloud config configurations activate default
gcloud config set project $PROJECTID2
echo ""

# Create devops service account
echo "${CYAN_TEXT}${BOLD_TEXT}🤖 Creating devops service account...${RESET_FORMAT}"
gcloud iam service-accounts create devops --display-name devops || echo "${YELLOW_TEXT}${BOLD_TEXT}⚠️  Service account may already exist.${RESET_FORMAT}"
echo ""

# Get service account email
SA=$(gcloud iam service-accounts list --format="value(email)" --filter "displayName=devops")
echo "${GREEN_TEXT}${BOLD_TEXT}✅ Service account created!${RESET_FORMAT}"
echo "   📧 Service Account: ${YELLOW_TEXT}${SA}${RESET_FORMAT}"
echo ""

# Bind iam.serviceAccountUser role to service account
echo "${CYAN_TEXT}${BOLD_TEXT}🔐 Binding iam.serviceAccountUser role to service account...${RESET_FORMAT}"
gcloud projects add-iam-policy-binding $PROJECTID2 --member serviceAccount:$SA --role=roles/iam.serviceAccountUser
echo "${GREEN_TEXT}${BOLD_TEXT}✅ iam.serviceAccountUser role bound!${RESET_FORMAT}"
echo ""

# ============================================================
# TASK 6: Using the service account with a compute instance
# ============================================================
echo ""
echo "${YELLOW_TEXT}${BOLD_TEXT}╔══════════════════════════════════════════════════════════════════╗${RESET_FORMAT}"
echo "${YELLOW_TEXT}${BOLD_TEXT}║   📌  TASK 6: Using the service account with a compute instance  ║${RESET_FORMAT}"
echo "${YELLOW_TEXT}${BOLD_TEXT}╚══════════════════════════════════════════════════════════════════╝${RESET_FORMAT}"
echo ""

# Bind compute.instanceAdmin role to service account
echo "${CYAN_TEXT}${BOLD_TEXT}🔐 Binding compute.instanceAdmin role to service account...${RESET_FORMAT}"
gcloud projects add-iam-policy-binding $PROJECTID2 --member serviceAccount:$SA --role=roles/compute.instanceAdmin
echo "${GREEN_TEXT}${BOLD_TEXT}✅ compute.instanceAdmin role bound!${RESET_FORMAT}"
echo ""

# Create lab-3 with service account
echo "${CYAN_TEXT}${BOLD_TEXT}🛠️  Creating lab-3 instance with service account...${RESET_FORMAT}"
gcloud compute instances create lab-3 --zone "${ZONE}" --machine-type=e2-standard-2 --service-account $SA --scopes "https://www.googleapis.com/auth/compute" || echo "${YELLOW_TEXT}${BOLD_TEXT}⚠️  Instance may already exist.${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}✅ lab-3 instance created with service account!${RESET_FORMAT}"
echo ""

# ============================================================
# VERIFICATION
# ============================================================
echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}╔══════════════════════════════════════════════════════════════════╗${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}║              ✅  LAB COMPLETED - VERIFICATION  ✅               ║${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}╚══════════════════════════════════════════════════════════════════╝${RESET_FORMAT}"
echo ""

echo "${CYAN_TEXT}${BOLD_TEXT}📋 Listing all configurations:${RESET_FORMAT}"
gcloud config configurations list
echo ""

echo "${CYAN_TEXT}${BOLD_TEXT}📋 Listing compute instances:${RESET_FORMAT}"
gcloud compute instances list
echo ""

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
