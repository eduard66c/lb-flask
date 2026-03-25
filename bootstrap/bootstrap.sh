#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# Load variables from .env if it exists
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

# Check if required variables are set
if [ -z "$PROJECT_ID" ] || [ -z "$GITHUB_REPO" ]; then
    echo "Error: PROJECT_ID and GITHUB_REPO must be set in .env"
    exit 1
fi

cd "$SCRIPT_DIR/../terraform"
terraform init
terraform apply -target=module.identity \
  -var="project_id=$PROJECT_ID" \
  -var="region=$REGION" \
  -var="github_repo=$GITHUB_REPO"
