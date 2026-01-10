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
echo "${ORANGE_TEXT}${BOLD_TEXT}        CLOUD IAM: QWIK START (GSP064) AUTO SOLVER                 ${RESET_FORMAT}"
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

# ================= INPUT =================
read -p "${ORANGE_TEXT}${BOLD_TEXT}Enter PROJECT ID: ${RESET_FORMAT}" PROJECT_ID
read -p "${ORANGE_TEXT}${BOLD_TEXT}Enter USERNAME 1 (Owner): ${RESET_FORMAT}" USER_1
read -p "${ORANGE_TEXT}${BOLD_TEXT}Enter USERNAME 2 (Viewer): ${RESET_FORMAT}" USER_2

[[ -z "$PROJECT_ID" || -z "$USER_1" || -z "$USER_2" ]] && fail "Inputs cannot be empty"

gcloud config set project "$PROJECT_ID" >/dev/null

log "Using Project: $PROJECT_ID"
success "Inputs validated"

# ================= TASK 1 =================
log "Task 1: Verifying IAM roles"

gcloud projects get-iam-policy "$PROJECT_ID" \
  --flatten="bindings[].members" \
  --format="table(bindings.role, bindings.members)" | grep "$USER_1" || fail "Username 1 not found"

gcloud projects get-iam-policy "$PROJECT_ID" \
  --flatten="bindings[].members" \
  --format="table(bindings.role, bindings.members)" | grep "$USER_2" || fail "Username 2 not found"

success "IAM users detected"

# ================= TASK 2 =================
log "Task 2: Creating Cloud Storage bucket"

BUCKET_NAME="iam-lab-$PROJECT_ID-$RANDOM"
gsutil mb -p "$PROJECT_ID" -l US gs://$BUCKET_NAME

echo "Cloud IAM Lab Sample File" > sample.txt
gsutil cp sample.txt gs://$BUCKET_NAME/sample.txt

success "Bucket created: gs://$BUCKET_NAME"
success "sample.txt uploaded"

# ================= VERIFY VIEWER ACCESS =================
log "Verifying Viewer access (Username 2)"

gsutil iam ch user:$USER_2:objectViewer gs://$BUCKET_NAME
success "Temporary viewer access confirmed"

# ================= TASK 3 =================
log "Task 3: Removing Project Viewer role from Username 2"

gcloud projects remove-iam-policy-binding "$PROJECT_ID" \
  --member="user:$USER_2" \
  --role="roles/viewer" || true

success "Project Viewer role removed"

log "Waiting for IAM propagation (90 seconds)"
sleep 90

# ================= TASK 4 =================
log "Task 4: Granting Storage Object Viewer role"

gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="user:$USER_2" \
  --role="roles/storage.objectViewer"

success "Storage Object Viewer role granted"

# ================= VERIFY ACCESS =================
log "Final verification command for Username 2:"
echo
echo "${CYAN_TEXT}gsutil ls gs://$BUCKET_NAME${RESET_FORMAT}"
echo

# ================= DONE =================
echo
echo "${ORANGE_TEXT}${BOLD_TEXT}=======================================================${RESET_FORMAT}"
echo "${ORANGE_TEXT}${BOLD_TEXT}        LAB COMPLETED SUCCESSFULLY (GSP064)            ${RESET_FORMAT}"
echo "${ORANGE_TEXT}${BOLD_TEXT}=======================================================${RESET_FORMAT}"
echo
echo "${GREEN_TEXT}${BOLD_TEXT}Now switch to USERNAME 2 → Cloud Shell → run above gsutil command${RESET_FORMAT}"
echo
echo "${ORANGE_TEXT}${BOLD_TEXT}Subscribe: https://www.youtube.com/@Chinmay_Joshi-CJ${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}Like • Share • Subscribe${RESET_FORMAT}"