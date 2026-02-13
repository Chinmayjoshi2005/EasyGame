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

# Heading: Verify gcloud installed
echo ""
echo "${MAGENTA_TEXT}${BOLD_TEXT}🚀  STEP 1 — VERIFY gcloud INSTALLED  🚀${RESET_FORMAT}"
echo "${MAGENTA_TEXT}${BOLD_TEXT}🔎 Checking that the Cloud SDK (gcloud) is available on this VM...${RESET_FORMAT}"
echo
echo "1) Verify gcloud is installed:"
gcloud --version || { echo "gcloud not found — install Cloud SDK or use the provided VM."; exit 1; }

# Heading: Authenticate default user
echo ""
echo "${BLUE_TEXT}${BOLD_TEXT}🔐  STEP 2 — AUTHENTICATE DEFAULT USER  🔐${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}🌐 Follow the browser flow to grant gcloud access to your default account.${RESET_FORMAT}"
echo
echo "2) Authenticate default user (interactive). Follow the browser prompts."
echo "   Run: gcloud auth login"
read -p "Press ENTER after you complete gcloud auth login (or Ctrl-C to abort)..." _

# Heading: Set region & zone and create lab-1
echo ""
echo "${ORANGE_TEXT}${BOLD_TEXT}🧭  STEP 3 — SET REGION/ZONE & CREATE lab-1  🧭${RESET_FORMAT}"
echo "${ORANGE_TEXT}${BOLD_TEXT}📍 Provide a region and zone for the default configuration and create lab-1.${RESET_FORMAT}"
echo
read -p "Enter REGION (e.g. us-central1): " REGION
read -p "Enter ZONE (e.g. us-central1-a): " ZONE

echo "Setting compute region and zone to ${REGION}/${ZONE}"
gcloud config set compute/region "${REGION}"
gcloud config set compute/zone "${ZONE}"

echo
echo "${ORANGE_TEXT}${BOLD_TEXT}🛠️  Creating instance lab-1 in the configured zone...${RESET_FORMAT}"
echo "3) Create instance lab-1 in the configured zone:"
gcloud compute instances create lab-1 --zone "${ZONE}" --machine-type=e2-standard-2 || echo "Instance creation may have failed or already exist."

# Heading: Zones listing & optional change
echo ""
echo "${CYAN_TEXT:-$CYAN_TEXT}${BOLD_TEXT}🧭  STEP 4 — ZONES & OPTIONAL ZONE CHANGE  🧭${RESET_FORMAT}"
echo "${CYAN_TEXT:-$CYAN_TEXT}${BOLD_TEXT}📡 Review available zones and optionally change the current zone.${RESET_FORMAT}"
echo
echo "4) List available zones and optionally change zone:"
gcloud compute zones list | sed -n '1,10p'
read -p "Enter another ZONE to switch to (or press ENTER to keep ${ZONE}): " NEW_ZONE
if [ -n "$NEW_ZONE" ]; then
  gcloud config set compute/zone "$NEW_ZONE"
  echo "Zone changed to $(gcloud config get-value compute/zone)"
else
  echo "Keeping zone: $(gcloud config get-value compute/zone)"
fi

# Heading: Create user2 configuration
echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}👥  STEP 5 — CREATE SECOND CONFIGURATION (user2)  👥${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}🔁 Start a new gcloud configuration for the second (viewer) user.${RESET_FORMAT}"
echo
echo "5) Create a second gcloud configuration for user2 (interactive)."
echo "   Run: gcloud init --no-launch-browser  -> choose 'Create a new configuration' (option 2), name it user2, then choose option to log in with the other account."
echo
read -p "Press ENTER once you've run gcloud init --no-launch-browser and completed login for user2..." _

# Heading: Switch back to default and install helpers
echo ""
echo "${YELLOW_TEXT}${BOLD_TEXT}🛡️  STEP 6–7 — SWITCH BACK & INSTALL TOOLS  🛡️${RESET_FORMAT}"
echo "${YELLOW_TEXT}${BOLD_TEXT}🔁 Return to default, then install jq and prepare environment variables.${RESET_FORMAT}"
echo
echo "6) Switch back to default configuration to grant permissions."
gcloud config configurations activate default

echo
echo "7) Install jq (needed later):"
sudo yum -y install epel-release >/dev/null 2>&1 || true
sudo yum -y install jq >/dev/null 2>&1 || true
echo "jq install attempted (may already be installed)."

# Heading: Set PROJECTID2 and USERID2
echo ""
echo "${BLUE_TEXT}${BOLD_TEXT}📦  STEP 8 — SET PROJECT & USER VARIABLES  📦${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}📝 Provide the second project id and user email to persist into ~/.bashrc${RESET_FORMAT}"
echo
read -p "Enter PROJECTID2 (second project id): " PROJECTID2
read -p "Enter USERID2 (second user's email): " USERID2

# Persist environment variables for convenience
grep -q 'export PROJECTID2=' ~/.bashrc 2>/dev/null || echo "export PROJECTID2=\"${PROJECTID2}\"" >> ~/.bashrc
grep -q 'export USERID2=' ~/.bashrc 2>/dev/null || echo "export USERID2=\"${USERID2}\"" >> ~/.bashrc
. ~/.bashrc

echo "Attempting to set project to PROJECTID2 (may warn if access not yet granted):"
gcloud config set project "$PROJECTID2" || true

# Heading: Grant viewer & create custom devops role
echo ""
echo "${ORANGE_TEXT}${BOLD_TEXT}🔒  STEP 9–10 — IAM: GRANT VIEWER & CREATE/BIND devops ROLE  🔒${RESET_FORMAT}"
echo "${ORANGE_TEXT}${BOLD_TEXT}🔐 Assign viewer and the custom devops role to USERID2 (run as admin/default).${RESET_FORMAT}"
echo
echo "8) Grant viewer role to user2 on PROJECTID2 (run as default user with rights):"
gcloud projects add-iam-policy-binding "$PROJECTID2" --member "user:${USERID2}" --role=roles/viewer

echo
echo "9) Create custom devops role in PROJECTID2 (permissions for compute instance lifecycle):"
gcloud iam roles create devops --project "$PROJECTID2" \
  --permissions "compute.instances.create,compute.instances.delete,compute.instances.start,compute.instances.stop,compute.instances.update,compute.disks.create,compute.subnetworks.use,compute.subnetworks.useExternalIp,compute.instances.setMetadata,compute.instances.setServiceAccount" \
  || echo "Role creation may have failed (role may already exist)."

echo
echo "${ORANGE_TEXT}${BOLD_TEXT}🔧 Binding iam.serviceAccountUser and the custom devops role to USERID2...${RESET_FORMAT}"
echo "10) Grant iam.serviceAccountUser to USERID2 and bind the custom devops role:"
gcloud projects add-iam-policy-binding "$PROJECTID2" --member "user:${USERID2}" --role=roles/iam.serviceAccountUser
gcloud projects add-iam-policy-binding "$PROJECTID2" --member "user:${USERID2}" --role="projects/${PROJECTID2}/roles/devops"

# Heading: Service account creation and bindings
echo ""
echo "${MAGENTA_TEXT}${BOLD_TEXT}🤖  STEP 11 — CREATE SERVICE ACCOUNT & BIND ROLES  🤖${RESET_FORMAT}"
echo "${MAGENTA_TEXT}${BOLD_TEXT}🔁 Create 'devops' service account and give it Service Account User + Compute InstanceAdmin roles.${RESET_FORMAT}"
echo
echo "11) Create a service account 'devops' and assign service account + compute roles:"
gcloud iam service-accounts create devops --display-name devops
SA=$(gcloud iam service-accounts list --format="value(email)" --filter "displayName=devops")
echo "Service account email: $SA"

gcloud projects add-iam-policy-binding "$PROJECTID2" --member "serviceAccount:${SA}" --role=roles/iam.serviceAccountUser
gcloud projects add-iam-policy-binding "$PROJECTID2" --member "serviceAccount:${SA}" --role=roles/compute.instanceAdmin

# Heading: Create lab-3 with service account
echo ""
echo "${CYAN_TEXT:-$CYAN_TEXT}${BOLD_TEXT}🧪  STEP 12 — CREATE lab-3 WITH SERVICE ACCOUNT  🧪${RESET_FORMAT}"
echo "${CYAN_TEXT:-$CYAN_TEXT}${BOLD_TEXT}⚙️  Use the devops service account when creating lab-3 (may require APIs to be enabled).${RESET_FORMAT}"
echo
read -p "Enter ZONE2 for creating lab-3 (e.g. same region zone like us-central1-a): " ZONE2
echo "12) Create lab-3 with the devops service account attached (may require APIs enabled):"
gcloud compute instances create lab-3 --zone "${ZONE2}" --machine-type=e2-standard-2 --service-account "${SA}" --scopes "https://www.googleapis.com/auth/compute" || echo "lab-3 creation may have failed (check IAM/API)."

# Heading: Quick verification
echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}✅  STEP 13 — QUICK VERIFICATION  ✅${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}🔎 List compute instances to confirm creations and attachments.${RESET_FORMAT}"
echo
echo "13) Quick verification: list compute instances in current project:"
gcloud compute instances list

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