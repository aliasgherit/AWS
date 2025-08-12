# choose unique bucket name: my-terraform-state-<your-unique-suffix>
aws s3api create-bucket --bucket terraform$(Get-Random) --region us-east-1

# enable versioning (recommended)
aws s3api put-bucket-versioning --bucket terraform1892983413 --versioning-configuration Status=Enabled

# create DynamoDB table for state locking
aws dynamodb create-table --table-name terraform-locks --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --billing-mode PAY_PER_REQUEST --region us-east-1
