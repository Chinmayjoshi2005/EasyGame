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
echo "${CYAN_TEXT}${BOLD_TEXT}║    This script will guide you through all the lab steps.         ║${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}╚══════════════════════════════════════════════════════════════════╝${RESET_FORMAT}"
echo ""

# ============================================================
# SECTION 1: COLLECT ALL REQUIRED VARIABLES UPFRONT
# ============================================================
echo ""
echo "${MAGENTA_TEXT}${BOLD_TEXT}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${RESET_FORMAT}"
echo "${MAGENTA_TEXT}${BOLD_TEXT}┃     📋  SECTION 1: COLLECT ALL REQUIRED VARIABLES  📋        ┃${RESET_FORMAT}"
echo "${MAGENTA_TEXT}${BOLD_TEXT}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${RESET_FORMAT}"
echo ""
echo "${YELLOW_TEXT}${BOLD_TEXT}💡 Please enter all the required information below:${RESET_FORMAT}"
echo ""

# Collect PROJECT_ID_1
echo "${BLUE_TEXT}${BOLD_TEXT}🔹 PROJECT ID 1 (First Project ID)${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Find this in the Google Cloud Console top navigation bar.${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Go to: Navigation Menu > Home > Dashboard${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Look for 'Project info' section - copy the Project ID.${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Example format: qwiklabs-gcp-02-e523d969626c${RESET_FORMAT}"
read -p "   👉 Enter PROJECT_ID_1: " PROJECT_ID_1
echo ""

# Collect PROJECT_ID_2
echo "${GREEN_TEXT}${BOLD_TEXT}🔹 PROJECT ID 2 (Second Project ID)${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Click the project dropdown in the top navigation bar.${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Look for a second project in the list (different from PROJECT_ID_1).${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Example format: qwiklabs-gcp-03-75d39da6944a${RESET_FORMAT}"
read -p "   👉 Enter PROJECT_ID_2: " PROJECT_ID_2
echo ""

# Collect USER_2
echo "${ORANGE_TEXT}${BOLD_TEXT}🔹 USER 2 (Second User Email)${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Find this in your lab instructions panel on the left side.${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Look for 'Student 2' or 'Second User' credentials.${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Example format: student-02-37e1d0290408@qwiklabs.net${RESET_FORMAT}"
read -p "   👉 Enter USER_2 email: " USER_2
echo ""

# Collect REGION
echo "${CYAN_TEXT}${BOLD_TEXT}🔹 REGION (Compute Region)${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Check your lab instructions for the required region.${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Go to: Navigation Menu > Compute Engine > VM instances${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Look at the 'Zone' column to identify your region.${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Common examples: us-central1, us-east1, europe-west1, europe-west4${RESET_FORMAT}"
read -p "   👉 Enter REGION: " REGION
echo ""

# Collect ZONE
echo "${MAGENTA_TEXT}${BOLD_TEXT}🔹 ZONE (Compute Zone)${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Check your lab instructions for the required zone.${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Go to: Navigation Menu > Compute Engine > VM instances${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Look at the 'Zone' column of your existing VM (centos-clean).${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Common examples: us-central1-a, us-east1-b, europe-west1-b, europe-west4-a${RESET_FORMAT}"
read -p "   👉 Enter ZONE: " ZONE
echo ""

# Collect ZONE2 (for lab-3)
echo "${YELLOW_TEXT}${BOLD_TEXT}🔹 ZONE 2 (Zone for lab-3 instance)${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 This can be the same as ZONE or a different zone in the same region.${RESET_FORMAT}"
echo "${WHITE_TEXT}   📖 Check lab instructions if a specific zone is required for lab-3.${RESET_FORMAT}"
read -p "   👉 Enter ZONE_2 (press ENTER to use same as ZONE): " ZONE_2
if [ -z "$ZONE_2" ]; then
  ZONE_2="$ZONE"
fi
echo ""

# Display summary of collected variables
echo "${GREEN_TEXT}${BOLD_TEXT}╔══════════════════════════════════════════════════════════════════╗${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}║              ✅  VARIABLES SUMMARY  ✅                          ║${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}╠══════════════════════════════════════════════════════════════════╣${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}║  📌 PROJECT_ID_1  : ${WHITE_TEXT}${PROJECT_ID_1}${GREEN_TEXT}${BOLD_TEXT}                    ${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}║  📌 PROJECT_ID_2  : ${WHITE_TEXT}${PROJECT_ID_2}${GREEN_TEXT}${BOLD_TEXT}                    ${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}║  📌 USER_2        : ${WHITE_TEXT}${USER_2}${GREEN_TEXT}${BOLD_TEXT}                    ${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}║  📌 REGION        : ${WHITE_TEXT}${REGION}${GREEN_TEXT}${BOLD_TEXT}                    ${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}║  📌 ZONE          : ${WHITE_TEXT}${ZONE}${GREEN_TEXT}${BOLD_TEXT}                    ${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}║  📌 ZONE_2        : ${WHITE_TEXT}${ZONE_2}${GREEN_TEXT}${BOLD_TEXT}                    ${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}╚══════════════════════════════════════════════════════════════════╝${RESET_FORMAT}"
echo ""
read -p "   🔄 Press ENTER to continue with the lab setup (or Ctrl-C to abort)..." _
echo ""

# ============================================================
# SECTION 2: VERIFY GCLOUD INSTALLED
# ============================================================
echo ""
echo "${MAGENTA_TEXT}${BOLD_TEXT}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${RESET_FORMAT}"
echo "${MAGENTA_TEXT}${BOLD_TEXT}┃        🚀  STEP 1 — VERIFY GCLOUD INSTALLED  🚀               ┃${RESET_FORMAT}"
echo "${MAGENTA_TEXT}${BOLD_TEXT}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${RESET_FORMAT}"
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}🔎 Checking that the Cloud SDK (gcloud) is available on this VM...${RESET_FORMAT}"
echo ""
echo "   📋 Running: gcloud --version"
echo ""
gcloud --version || { echo "${RED_TEXT}${BOLD_TEXT}❌ gcloud not found — install Cloud SDK or use the provided VM.${RESET_FORMAT}"; exit 1; }
echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}✅ gcloud is installed and ready!${RESET_FORMAT}"
echo ""

# ============================================================
# SECTION 3: AUTHENTICATE DEFAULT USER
# ============================================================
echo ""
echo "${BLUE_TEXT}${BOLD_TEXT}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}┃      🔐  STEP 2 — AUTHENTICATE DEFAULT USER  🔐               ┃${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${RESET_FORMAT}"
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}🌐 Follow the browser flow to grant gcloud access to your default account.${RESET_FORMAT}"
echo ""
echo "   📋 Instructions:"
echo "   ${WHITE_TEXT}1️⃣  Run: gcloud auth login${RESET_FORMAT}"
echo "   ${WHITE_TEXT}2️⃣  A browser window will open${RESET_FORMAT}"
echo "   ${WHITE_TEXT}3️⃣  Sign in with your Google account${RESET_FORMAT}"
echo "   ${WHITE_TEXT}4️⃣  Grant the requested permissions${RESET_FORMAT}"
echo ""
read -p "   ⏳ Press ENTER after you complete gcloud auth login..." _
echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}✅ Authentication step completed!${RESET_FORMAT}"
echo ""

# ============================================================
# SECTION 4: SET REGION/ZONE & CREATE lab-1
# ============================================================
echo ""
echo "${ORANGE_TEXT}${BOLD_TEXT}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${RESET_FORMAT}"
echo "${ORANGE_TEXT}${BOLD_TEXT}┃   🧭  STEP 3 — SET REGION/ZONE & CREATE lab-1  🧭             ┃${RESET_FORMAT}"
echo "${ORANGE_TEXT}${BOLD_TEXT}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${RESET_FORMAT}"
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}📍 Setting compute region and zone...${RESET_FORMAT}"
echo ""
echo "   📋 Setting project to: ${YELLOW_TEXT}${PROJECT_ID_1}${RESET_FORMAT}"
gcloud config set project "$PROJECT_ID_1"
echo ""
echo "   📋 Setting region to: ${YELLOW_TEXT}${REGION}${RESET_FORMAT}"
gcloud config set compute/region "${REGION}"
echo ""
echo "   📋 Setting zone to: ${YELLOW_TEXT}${ZONE}${RESET_FORMAT}"
gcloud config set compute/zone "${ZONE}"
echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}✅ Region and Zone configured!${RESET_FORMAT}"
echo ""
echo "${ORANGE_TEXT}${BOLD_TEXT}🛠️  Creating instance lab-1 in PROJECT_ID_1...${RESET_FORMAT}"
echo ""
echo "   📋 Running: gcloud compute instances create lab-1 --project ${PROJECT_ID_1} --zone ${ZONE} --machine-type=e2-standard-2"
echo ""
gcloud compute instances create lab-1 --project "$PROJECT_ID_1" --zone "${ZONE}" --machine-type=e2-standard-2 || echo "${YELLOW_TEXT}${BOLD_TEXT}⚠️  Instance creation may have failed or already exist.${RESET_FORMAT}"
echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}✅ lab-1 instance creation attempted!${RESET_FORMAT}"
echo ""

# ============================================================
# SECTION 5: ZONES LISTING & OPTIONAL CHANGE
# ============================================================
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}┃     🧭  STEP 4 — ZONES & OPTIONAL ZONE CHANGE  🧭             ┃${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${RESET_FORMAT}"
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}📡 Listing available zones (showing first 10)...${RESET_FORMAT}"
echo ""
gcloud compute zones list | sed -n '1,10p'
echo ""
echo "${YELLOW_TEXT}${BOLD_TEXT}💡 Current zone: ${ZONE}${RESET_FORMAT}"
echo ""
read -p "   🔄 Enter another ZONE to switch to (or press ENTER to keep ${ZONE}): " NEW_ZONE
echo ""
if [ -n "$NEW_ZONE" ]; then
  gcloud config set compute/zone "$NEW_ZONE"
  ZONE="$NEW_ZONE"
  echo "${GREEN_TEXT}${BOLD_TEXT}✅ Zone changed to: ${ZONE}${RESET_FORMAT}"
else
  echo "${GREEN_TEXT}${BOLD_TEXT}✅ Keeping zone: ${ZONE}${RESET_FORMAT}"
fi
echo ""

# ============================================================
# SECTION 6: CREATE USER2 CONFIGURATION
# ============================================================
echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}┃   👥  STEP 5 — CREATE SECOND CONFIGURATION (user2)  👥        ┃${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${RESET_FORMAT}"
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}🔁 Creating a new gcloud configuration for the second (viewer) user.${RESET_FORMAT}"
echo ""

# Create user2 configuration
echo "   📋 Creating user2 configuration..."
gcloud config configurations create user2 --no-activate 2>/dev/null || echo "${YELLOW_TEXT}${BOLD_TEXT}⚠️  user2 configuration may already exist.${RESET_FORMAT}"

echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}🔐 Now you need to authenticate USER_2: ${USER_2}${RESET_FORMAT}"
echo ""
echo "   📋 Instructions:"
echo "   ${WHITE_TEXT}1️⃣  Run: gcloud config configurations activate user2${RESET_FORMAT}"
echo "   ${WHITE_TEXT}2️⃣  Run: gcloud auth login${RESET_FORMAT}"
echo "   ${WHITE_TEXT}3️⃣  Complete the authentication for USER_2: ${USER_2}${RESET_FORMAT}"
echo "   ${WHITE_TEXT}4️⃣  Run: gcloud config set project ${PROJECT_ID_2}${RESET_FORMAT}"
echo "   ${WHITE_TEXT}5️⃣  Run: gcloud config set compute/zone ${ZONE}${RESET_FORMAT}"
echo ""
read -p "   ⏳ Press ENTER once you've completed authentication for user2..." _
echo ""

# Set project and zone for user2 configuration
echo "   📋 Setting project and zone for user2 configuration..."
gcloud config configurations activate user2
gcloud config set project "$PROJECT_ID_2"
gcloud config set compute/zone "${ZONE}"
gcloud config set compute/region "${REGION}"

echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}✅ user2 configuration created and configured!${RESET_FORMAT}"
echo ""

# ============================================================
# SECTION 7: SWITCH BACK TO DEFAULT & INSTALL TOOLS
# ============================================================
echo ""
echo "${YELLOW_TEXT}${BOLD_TEXT}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${RESET_FORMAT}"
echo "${YELLOW_TEXT}${BOLD_TEXT}┃      🛡️  STEP 6–7 — SWITCH BACK & INSTALL TOOLS  🛡️           ┃${RESET_FORMAT}"
echo "${YELLOW_TEXT}${BOLD_TEXT}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${RESET_FORMAT}"
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}🔁 Switching back to default configuration...${RESET_FORMAT}"
echo ""
echo "   📋 Running: gcloud config configurations activate default"
gcloud config configurations activate default
echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}✅ Switched to default configuration!${RESET_FORMAT}"
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}📦 Installing jq (needed for JSON processing)...${RESET_FORMAT}"
echo ""
echo "   📋 Running: sudo yum -y install epel-release && sudo yum -y install jq"
sudo yum -y install epel-release >/dev/null 2>&1 || true
sudo yum -y install jq >/dev/null 2>&1 || true
echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}✅ jq installation attempted!${RESET_FORMAT}"
echo ""

# ============================================================
# SECTION 8: SET PROJECT & USER VARIABLES
# ============================================================
echo ""
echo "${BLUE_TEXT}${BOLD_TEXT}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}┃       📦  STEP 8 — SET PROJECT & USER VARIABLES  📦           ┃${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${RESET_FORMAT}"
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}📝 Setting up environment variables...${RESET_FORMAT}"
echo ""
echo "   📋 PROJECT_ID_1: ${PROJECT_ID_1}"
echo "   📋 PROJECT_ID_2: ${PROJECT_ID_2}"
echo "   📋 USER_2: ${USER_2}"
echo ""

# Export variables for immediate use
export PROJECT_ID_1="${PROJECT_ID_1}"
export PROJECT_ID_2="${PROJECT_ID_2}"
export USER_2="${USER_2}"
export USERID2="${USER_2}"  # Lab expects USERID2 variable name

# Persist environment variables for convenience
grep -q 'export PROJECT_ID_1=' ~/.bashrc 2>/dev/null || echo "export PROJECT_ID_1=\"${PROJECT_ID_1}\"" >> ~/.bashrc
grep -q 'export PROJECT_ID_2=' ~/.bashrc 2>/dev/null || echo "export PROJECT_ID_2=\"${PROJECT_ID_2}\"" >> ~/.bashrc
grep -q 'export USER_2=' ~/.bashrc 2>/dev/null || echo "export USER_2=\"${USER_2}\"" >> ~/.bashrc
grep -q 'export USERID2=' ~/.bashrc 2>/dev/null || echo "export USERID2=\"${USER_2}\"" >> ~/.bashrc

echo "${CYAN_TEXT}${BOLD_TEXT}🔧 Setting project to PROJECT_ID_1 for default configuration...${RESET_FORMAT}"
gcloud config set project "$PROJECT_ID_1"
echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}✅ Environment variables configured!${RESET_FORMAT}"
echo ""

# ============================================================
# SECTION 9: GRANT VIEWER & CREATE CUSTOM DEVOPS ROLE
# ============================================================
echo ""
echo "${ORANGE_TEXT}${BOLD_TEXT}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${RESET_FORMAT}"
echo "${ORANGE_TEXT}${BOLD_TEXT}┃  🔒  STEP 9–10 — IAM: GRANT VIEWER & CREATE DEVOPS ROLE  🔒   ┃${RESET_FORMAT}"
echo "${ORANGE_TEXT}${BOLD_TEXT}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${RESET_FORMAT}"
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}🔐 Setting project to PROJECT_ID_2 for IAM operations...${RESET_FORMAT}"
gcloud config set project "$PROJECT_ID_2"
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}🔐 Assigning viewer role to USER_2 on PROJECT_ID_2...${RESET_FORMAT}"
echo ""
echo "   📋 Running: gcloud projects add-iam-policy-binding ${PROJECT_ID_2} --member user:${USER_2} --role=roles/viewer"
echo ""
gcloud projects add-iam-policy-binding "$PROJECT_ID_2" --member "user:${USER_2}" --role=roles/viewer
echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}✅ Viewer role granted!${RESET_FORMAT}"
echo ""

echo "${CYAN_TEXT}${BOLD_TEXT}🛠️  Creating custom devops role in PROJECT_ID_2...${RESET_FORMAT}"
echo ""
echo "   📋 Permissions included:"
echo "   ${WHITE_TEXT}  • compute.instances.create${RESET_FORMAT}"
echo "   ${WHITE_TEXT}  • compute.instances.delete${RESET_FORMAT}"
echo "   ${WHITE_TEXT}  • compute.instances.start${RESET_FORMAT}"
echo "   ${WHITE_TEXT}  • compute.instances.stop${RESET_FORMAT}"
echo "   ${WHITE_TEXT}  • compute.instances.update${RESET_FORMAT}"
echo "   ${WHITE_TEXT}  • compute.disks.create${RESET_FORMAT}"
echo "   ${WHITE_TEXT}  • compute.subnetworks.use${RESET_FORMAT}"
echo "   ${WHITE_TEXT}  • compute.subnetworks.useExternalIp${RESET_FORMAT}"
echo "   ${WHITE_TEXT}  • compute.instances.setMetadata${RESET_FORMAT}"
echo "   ${WHITE_TEXT}  • compute.instances.setServiceAccount${RESET_FORMAT}"
echo ""
gcloud iam roles create devops --project="$PROJECT_ID_2" \
  --title="devops" \
  --description="Custom role for devops team" \
  --permissions="compute.instances.create,compute.instances.delete,compute.instances.start,compute.instances.stop,compute.instances.update,compute.disks.create,compute.subnetworks.use,compute.subnetworks.useExternalIp,compute.instances.setMetadata,compute.instances.setServiceAccount" \
  || echo "${YELLOW_TEXT}${BOLD_TEXT}⚠️  Role creation may have failed (role may already exist).${RESET_FORMAT}"
echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}✅ Custom devops role created!${RESET_FORMAT}"
echo ""

echo "${CYAN_TEXT}${BOLD_TEXT}🔧 Binding iam.serviceAccountUser and devops role to USER_2...${RESET_FORMAT}"
echo ""
echo "   📋 Granting iam.serviceAccountUser role..."
gcloud projects add-iam-policy-binding "$PROJECT_ID_2" --member "user:${USER_2}" --role=roles/iam.serviceAccountUser
echo ""
echo "   📋 Binding custom devops role..."
gcloud projects add-iam-policy-binding "$PROJECT_ID_2" --member "user:${USER_2}" --role="projects/${PROJECT_ID_2}/roles/devops"
echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}✅ IAM roles bound to USER_2!${RESET_FORMAT}"
echo ""

# ============================================================
# SECTION 10: CREATE SERVICE ACCOUNT & BIND ROLES
# ============================================================
echo ""
echo "${MAGENTA_TEXT}${BOLD_TEXT}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${RESET_FORMAT}"
echo "${MAGENTA_TEXT}${BOLD_TEXT}┃   🤖  STEP 11 — CREATE SERVICE ACCOUNT & BIND ROLES  🤖       ┃${RESET_FORMAT}"
echo "${MAGENTA_TEXT}${BOLD_TEXT}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${RESET_FORMAT}"
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}🔧 Setting project to PROJECT_ID_2 for service account creation...${RESET_FORMAT}"
gcloud config set project "$PROJECT_ID_2"
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}🔁 Creating 'devops' service account in PROJECT_ID_2...${RESET_FORMAT}"
echo ""
echo "   📋 Running: gcloud iam service-accounts create devops --display-name devops"
gcloud iam service-accounts create devops --display-name devops || echo "${YELLOW_TEXT}${BOLD_TEXT}⚠️  Service account may already exist.${RESET_FORMAT}"
echo ""
# Get service account email - construct it directly since we know the format
SA="devops@${PROJECT_ID_2}.iam.gserviceaccount.com"
echo "${GREEN_TEXT}${BOLD_TEXT}✅ Service account created!${RESET_FORMAT}"
echo ""
echo "   📧 Service Account Email: ${YELLOW_TEXT}${SA}${RESET_FORMAT}"
echo ""

echo "${CYAN_TEXT}${BOLD_TEXT}🔧 Binding roles to service account...${RESET_FORMAT}"
echo ""
echo "   📋 Granting iam.serviceAccountUser role..."
gcloud projects add-iam-policy-binding "$PROJECT_ID_2" --member "serviceAccount:${SA}" --role=roles/iam.serviceAccountUser
echo ""
echo "   📋 Granting compute.instanceAdmin role..."
gcloud projects add-iam-policy-binding "$PROJECT_ID_2" --member "serviceAccount:${SA}" --role=roles/compute.instanceAdmin
echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}✅ Service account roles configured!${RESET_FORMAT}"
echo ""

# ============================================================
# SECTION 11: CREATE lab-3 WITH SERVICE ACCOUNT
# ============================================================
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}┃     🧪  STEP 12 — CREATE lab-3 WITH SERVICE ACCOUNT  🧪       ┃${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${RESET_FORMAT}"
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}⚙️  Creating lab-3 with the devops service account attached...${RESET_FORMAT}"
echo ""
echo "   📋 Project: ${PROJECT_ID_2}"
echo "   📋 Zone: ${ZONE_2}"
echo "   📋 Service Account: ${SA}"
echo ""
echo "   📋 Running: gcloud compute instances create lab-3 --project ${PROJECT_ID_2} --zone ${ZONE_2} --machine-type=e2-standard-2 --service-account ${SA}"
echo ""
gcloud compute instances create lab-3 --project "$PROJECT_ID_2" --zone "${ZONE_2}" --machine-type=e2-standard-2 --service-account "${SA}" --scopes "https://www.googleapis.com/auth/compute" || echo "${YELLOW_TEXT}${BOLD_TEXT}⚠️  lab-3 creation may have failed (check IAM/API).${RESET_FORMAT}"
echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}✅ lab-3 instance creation attempted!${RESET_FORMAT}"
echo ""

# ============================================================
# SECTION 12: TEST USER2 PERMISSIONS & CREATE lab-2
# ============================================================
echo ""
echo "${YELLOW_TEXT}${BOLD_TEXT}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${RESET_FORMAT}"
echo "${YELLOW_TEXT}${BOLD_TEXT}┃     🧪  STEP 13 — TEST USER2 & CREATE lab-2  🧪              ┃${RESET_FORMAT}"
echo "${YELLOW_TEXT}${BOLD_TEXT}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${RESET_FORMAT}"
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}🔐 Switching to user2 configuration to test permissions...${RESET_FORMAT}"
echo ""
gcloud config configurations activate user2
gcloud config set project "$PROJECT_ID_2"
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}📋 Listing compute instances as user2...${RESET_FORMAT}"
gcloud compute instances list
echo ""

echo "${CYAN_TEXT}${BOLD_TEXT}🛠️  Creating lab-2 instance in PROJECT_ID_2...${RESET_FORMAT}"
echo ""
echo "   📋 Running: gcloud compute instances create lab-2 --zone ${ZONE} --machine-type=e2-standard-2"
gcloud compute instances create lab-2 --zone "${ZONE}" --machine-type=e2-standard-2 || echo "${YELLOW_TEXT}${BOLD_TEXT}⚠️  lab-2 creation may have failed or already exist.${RESET_FORMAT}"
echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}✅ lab-2 instance creation attempted!${RESET_FORMAT}"
echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}✅ User2 testing completed!${RESET_FORMAT}"
echo ""

# ============================================================
# SECTION 13: QUICK VERIFICATION
# ============================================================
echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}┃            ✅  STEP 14 — QUICK VERIFICATION  ✅               ┃${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${RESET_FORMAT}"
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}🔎 Switching back to default configuration...${RESET_FORMAT}"
gcloud config configurations activate default
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}🔎 Listing compute instances in PROJECT_ID_1...${RESET_FORMAT}"
echo ""
echo "   📋 Running: gcloud compute instances list --project ${PROJECT_ID_1}"
echo ""
gcloud compute instances list --project "$PROJECT_ID_1"
echo ""
echo "${CYAN_TEXT}${BOLD_TEXT}🔎 Listing compute instances in PROJECT_ID_2...${RESET_FORMAT}"
echo ""
echo "   📋 Running: gcloud compute instances list --project ${PROJECT_ID_2}"
echo ""
gcloud compute instances list --project "$PROJECT_ID_2"
echo ""
echo "${GREEN_TEXT}${BOLD_TEXT}✅ Verification complete!${RESET_FORMAT}"
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
