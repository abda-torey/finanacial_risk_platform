#!/bin/bash
set -e

# === User Configuration ===
PROJECT_ID="financial-anomaly-464319"
REPO="abda-torey/finanacial_risk_platform"
POOL_ID="github-pool"
PROVIDER_ID="github-provider"
SERVICE_ACCOUNT_NAME="terraform-infra-sa"
SERVICE_ACCOUNT_EMAIL="${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"

# === Enable Required APIs ===
gcloud services enable iamcredentials.googleapis.com sts.googleapis.com iam.googleapis.com \
  compute.googleapis.com storage.googleapis.com bigquery.googleapis.com --project="${PROJECT_ID}"

# === Create Workload Identity Pool ===
gcloud iam workload-identity-pools create "${POOL_ID}" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --display-name="GitHub Actions Pool"

# === Get Pool Resource Name ===
WORKLOAD_IDENTITY_POOL_ID=$(gcloud iam workload-identity-pools describe "${POOL_ID}" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --format="value(name)")

# === Create OIDC Provider ===
gcloud iam workload-identity-pools providers create-oidc "${PROVIDER_ID}" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --workload-identity-pool="${POOL_ID}" \
  --display-name="GitHub OIDC Provider" \
  --issuer-uri="https://token.actions.githubusercontent.com" \
  --attribute-mapping="google.subject=assertion.sub,attribute.repository=assertion.repository,attribute.actor=assertion.actor,attribute.repository_owner=assertion.repository_owner" \
  --attribute-condition="assertion.repository == '${REPO}'"

# === Create Service Account ===
gcloud iam service-accounts create "${SERVICE_ACCOUNT_NAME}" \
  --project="${PROJECT_ID}" \
  --display-name="Terraform GitHub CI/CD"
# === IAM Bindings ===

# Workload Identity User
gcloud iam service-accounts add-iam-policy-binding "${SERVICE_ACCOUNT_EMAIL}" \
  --project="${PROJECT_ID}" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/${WORKLOAD_IDENTITY_POOL_ID}/attribute.repository/${REPO}"

# Compute Admin (VM)
gcloud projects add-iam-policy-binding "${PROJECT_ID}" \
  --member="serviceAccount:${SERVICE_ACCOUNT_EMAIL}" \
  --role="roles/compute.admin"

# BigQuery Admin
gcloud projects add-iam-policy-binding "${PROJECT_ID}" \
  --member="serviceAccount:${SERVICE_ACCOUNT_EMAIL}" \
  --role="roles/bigquery.admin"

# Storage Admin (GCS)
gcloud projects add-iam-policy-binding "${PROJECT_ID}" \
  --member="serviceAccount:${SERVICE_ACCOUNT_EMAIL}" \
  --role="roles/storage.admin"

# (Optional) Service Account Admin
gcloud projects add-iam-policy-binding "${PROJECT_ID}" \
  --member="serviceAccount:${SERVICE_ACCOUNT_EMAIL}" \
  --role="roles/iam.serviceAccountAdmin"

# === Allow GitHub to Impersonate the Service Account ===
gcloud iam service-accounts add-iam-policy-binding "${SERVICE_ACCOUNT_EMAIL}" \
  --project="${PROJECT_ID}" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/${WORKLOAD_IDENTITY_POOL_ID}/attribute.repository/${REPO}"

# === Final Output for GitHub Secrets ===
echo ""
echo "✅ OIDC Setup Complete!"
echo ""
echo "🔐 Paste the following secrets into your GitHub repo settings:"
echo "------------------------------------------------------------"
echo "WORKLOAD_IDENTITY_PROVIDER=${WORKLOAD_IDENTITY_POOL_ID}/providers/${PROVIDER_ID}"
echo "SERVICE_ACCOUNT_EMAIL=${SERVICE_ACCOUNT_EMAIL}"
