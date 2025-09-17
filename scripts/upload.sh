set -euo pipefail

# --- AWS Credentials from Buildkite Secrets ---
export AWS_ACCESS_KEY_ID="$(buildkite-agent secret get accesskey)"
export AWS_SECRET_ACCESS_KEY="$(buildkite-agent secret get secretkey)"
export AWS_DEFAULT_REGION="eu-north-1"

# --- Artifact & S3 settings ---
BUCKET_NAME="buildkitedemo"
FILE="output.txt"

# --- Download artifact from previous step ---
echo "🔽 Downloading artifact: $FILE"
buildkite-agent artifact download "$FILE" ./

# --- Validate file exists ---
if [[ ! -f "$FILE" ]]; then
  echo "❌ Error: $FILE not found after artifact download!"
  exit 1
fi

# --- Upload to S3 ---
DEST="s3://$BUCKET_NAME/${BUILDKITE_PIPELINE_SLUG}/${BUILDKITE_BUILD_NUMBER}/$FILE"

echo "☁️ Uploading $FILE to $DEST ..."
aws s3 cp "$FILE" "$DEST"

echo "✅ Upload complete!"
