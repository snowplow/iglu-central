#!/bin/bash

set -e

# Constants
source $GITHUB_WORKSPACE/.github/scripts/constants.sh

if [ "$GITHUB_HEAD_REF" == "" ]; then
    echo "GITHUB_HEAD_REF environment variable is empty, this is not a PR. Skipping sync to dev mirror..."
    exit 0
fi
if [ "$AWS_SHA_ACCESS_KEY_ID" == "" ]; then
    echo "AWS_SHA_ACCESS_KEY_ID environment variable is empty. Cannot deploy to a dev mirror..."
    exit 1
fi
if [ "$AWS_SHA_SECRET_ACCESS_KEY" == "" ]; then
    echo "AWS_SHA_SECRET_ACCESS_KEY environment variable is empty. Cannot deploy to a dev mirror..."
    exit 1
fi

REGISTRY_PATH="http://iglucentral-dev.com.s3-website-us-east-1.amazonaws.com/$GITHUB_HEAD_REF"

echo "=================================================="
echo "SYNCHRONIZING SCHEMAS TO DEV MIRROR $REGISTRY_PATH"
echo "--------------------------------------------------"

java -jar ${IGLUCTL} static s3cp $GITHUB_WORKSPACE/schemas/ $DEV_MIRROR_BUCKET --s3path "$GITHUB_HEAD_REF/" --region=us-east-1 --accessKeyId $AWS_SHA_ACCESS_KEY_ID --secretAccessKey $AWS_SHA_SECRET_ACCESS_KEY
