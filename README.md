# Buildkite Demo Project

This is a sample Buildkite demo project that generates a text file, saves it as an artifact, and uploads it to AWS S3.

## Project Structure
```
.buildkite/pipeline.yml   # Pipeline definition
scripts/upload.sh         # Upload script to S3
README.md                 # Instructions
```

## Steps

1. **Pipeline.yml**
   - Generates `output.txt`
   - Saves as a Buildkite artifact
   - Runs upload script

2. **Upload Script**
   - Uploads `output.txt` to your S3 bucket
   - Requires AWS CLI and IAM permissions

## Setup

1. Configure your Buildkite organization and add this repo.
2. Set up a Buildkite Agent with AWS CLI installed.
3. Configure AWS credentials via environment variables or IAM role: and store on Cluster Secret.
   ```bash
   export AWS_ACCESS_KEY_ID=$(buildkite-agent secret get accesskey)
   export AWS_SECRET_ACCESS_KEY=$(buildkite-agent secret get secretkey)
   export AWS_DEFAULT_REGION=ap-south-1
   ```
4. Run the pipeline from Buildkite UI.

## Result
- `output.txt` will be available as a Buildkite artifact.
- The same file will also be uploaded to your specified S3 bucket.
