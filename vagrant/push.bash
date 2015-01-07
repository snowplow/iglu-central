#!/bin/bash
set -e

s3_bucket=iglucentral.com

# Get the parent directory of where this script is.
source="${BASH_SOURCE[0]}"
while [ -h "${source}" ] ; do source="$(readlink "${source}")"; done
dir="$( cd -P "$( dirname "${source}" )/.." && pwd )"
cd ${dir}

# Note - this runs on HOST: https://groups.google.com/forum/#!topic/vagrant-up/LgqE-JFAqZc 
aws s3 cp schemas/ s3://${s3_bucket}/schemas/ --include "*.*" --recursive
