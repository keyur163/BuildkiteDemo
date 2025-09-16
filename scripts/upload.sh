#!/bin/bash
set -e

export AWS_ACCESS_KEY_ID=$(buildkite-agent secret get accesskey)
export AWS_SECRET_ACCESS_KEY=$(buildkite-agent secret get secretkey)
export AWS_DEFAULT_REGION=AWS-REGION


BUCKET_NAME="my-buildkite-demo-bucket"
FILE="output.txt"

if [ ! -f "$FILE" ]; then
  echo "Error: $FILE not found!"
  exit 1
fi

echo "Uploading $FILE to s3://$BUCKET_NAME/ ..."
aws s3 cp "$FILE" "s3://$BUCKET_NAME/"

echo "✅ Upload complete!"
