#!/bin/bash
set -e

function die() {
    echo "$@" 1>&2 ; exit 1;
}

master="snowplow-hosted-assets"
master_region="eu-west-1"
jsonpath_upload_dir="/4-storage/redshift-storage/jsonpaths/"

declare -a regions=( "ap-northeast-1" "ap-northeast-2" "ap-south-1" "ap-southeast-1" "ap-southeast-2" "ca-central-1" "eu-west-1" "eu-west-2" "eu-central-1" "sa-east-1" "us-east-1" "us-east-2" "us-west-1" "us-west-2" )

[ -z "${AWS_SHA_ACCESS_KEY_ID}" ] && die "Need to set AWS_SHA_ACCESS_KEY_ID"
[ -z "${AWS_SHA_SECRET_ACCESS_KEY}" ] && die "Need to set AWS_SHA_SECRET_ACCESS_KEY"

export AWS_ACCESS_KEY_ID=$AWS_SHA_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SHA_SECRET_ACCESS_KEY

for region in "${regions[@]}"
do
    echo "====================================="
    echo "SYNCHRONIZING JSONPATHS TO ${region}"
    echo "-------------------------------------"
    if [ $region == $master_region ]; then
        aws s3 sync jsonpaths/ s3://${master}${jsonpath_upload_dir} --include "*.*" --region=${region}
    else
        aws s3 sync jsonpaths/ s3://${master}-${region}${jsonpath_upload_dir} --include "*.*" --region=${region}
    fi
done
