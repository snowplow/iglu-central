#!/bin/bash

set -e

# Constants
source $TRAVIS_BUILD_DIR/ci/constants.sh

if [ "$TRAVIS_PULL_REQUEST_BRANCH" == "" ]; then
    echo "TRAVIS_PULL_REQUEST_BRANCH environment variable is empty, this is not a PR. Skipping sync to dev mirror..."
    exit 0
fi

REGISTRY_PATH="http://iglucentral-dev.com.s3-website-us-east-1.amazonaws.com/$TRAVIS_PULL_REQUEST_BRANCH"

echo "=================================================="
echo "SYNCHRONIZING SCHEMAS TO DEV MIRROR $REGISTRY_PATH"
echo "--------------------------------------------------"

[ -z "${AWS_SHA_ACCESS_KEY_ID}" ] && die "Need to set AWS_SHA_ACCESS_KEY_ID"
[ -z "${AWS_SHA_SECRET_ACCESS_KEY}" ] && die "Need to set AWS_SHA_SECRET_ACCESS_KEY"

java -jar ${IGLUCTL} static s3cp schemas/ $DEV_MIRROR_BUCKET --s3path "$TRAVIS_PULL_REQUEST_BRANCH/" --region=us-east-1 --accessKeyId $AWS_SHA_ACCESS_KEY_ID --secretAccessKey $AWS_SHA_SECRET_ACCESS_KEY
