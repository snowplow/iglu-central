#!/bin/bash
set -e

# Similar to Perl die
function die() {
    echo "$@" 1>&2 ; exit 1;
}

s3_bucket=iglucentral.com
s3_region=us-east-1

[ -z "${AWS_ACCESS_KEY_ID}" ] && die "Need to set AWS_ACCESS_KEY_ID"
[ -z "${AWS_SECRET_ACCESS_KEY}" ] && die "Need to set AWS_SECRET_ACCESS_KEY"

# Get the parent directory of where this script is.
source="${BASH_SOURCE[0]}"
while [ -h "${source}" ] ; do source="$(readlink "${source}")"; done
dir="$( cd -P "$( dirname "${source}" )/.." && pwd )"
cd ${dir}

# Note - this runs on HOST: https://groups.google.com/forum/#!topic/vagrant-up/LgqE-JFAqZc 
aws s3 cp schemas/ s3://${s3_bucket}/schemas/ --include "." --recursive --region=${s3_region}
