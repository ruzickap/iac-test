# iac-test

Repository to test IaC

## Create S3 bucket for Terraform

```bash
aws cloudformation deploy --region=eu-central-1 \
  --parameter-overrides "TFStateFileS3BucketName=ruzickap-iac-test-tfstate" \
  --stack-name "ruzickap-iac-test-s3-tfstate" --template-file "./cloudformation/s3-dynamodb-tfstate.yaml"
```

Configure GH Action Federation (if needed):

```bash
aws cloudformation deploy --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides "GitHubFullRepositoryName=ruzickap/iac-test" \
  --stack-name "gh-action-iam-role-oidc" --template-file "./cloudformation/gh-action-iam-role-oidc.yaml"
```

## Local test run

```bash
TERRAFORM_CODE_DIR="terraform"
TERRAFORM_BUCKET="ruzickap-iac-test-tfstate"
TERRAFORM_KEY="terraform-ruzickap-iac-test.tfstate"
TERRAFORM_REGION="eu-central-1"
TERRAFORM_DYNAMODB_TABLE="ruzickap-iac-test-tfstate"

terraform -chdir="${TERRAFORM_CODE_DIR}" init \
  -backend-config="bucket=${TERRAFORM_BUCKET}" \
  -backend-config="key=terraform-${TERRAFORM_KEY}.tfstate" \
  -backend-config="region=${TERRAFORM_REGION}" \
  -backend-config="dynamodb_table=${TERRAFORM_DYNAMODB_TABLE}"

terraform -chdir="${TERRAFORM_CODE_DIR}" apply
```
