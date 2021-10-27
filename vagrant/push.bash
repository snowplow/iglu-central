#!/bin/bash
set -e

# Similar to Perl die
function die() {
    echo "$@" 1>&2 ; exit 1;
}

function install_igluctl() {
    if [ ! -f igluctl ]
    then
        echo "igluctl not found, downloading..."
        wget https://github.com/snowplow-incubator/igluctl/releases/download/0.8.0/igluctl_0.8.0.zip
        unzip igluctl_0.8.0.zip
        chmod u+x igluctl
        echo "done!"
    else
        echo "igluctl is already downloaded!"
    fi
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

install_igluctl

# Note - this runs on HOST: https://groups.google.com/forum/#!topic/vagrant-up/LgqE-JFAqZc 
./igluctl static s3cp --region=${s3_region} schemas/ $s3_bucket
