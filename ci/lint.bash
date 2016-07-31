#!/bin/bash
set -e

# Constants
install_dir="/tmp"
validator_v="0.1.0_rc1"
validator_zip="igluctl_${validator_v}.zip"
validator_uri="http://dl.bintray.com/snowplow/snowplow-generic/${validator_zip}"
validator_jar="igluctl"

# Go to parent dir of this script
function cd_script_parent() {
    source="${BASH_SOURCE[0]}"
    while [ -h "${source}" ] ; do source="$(readlink "${source}")"; done
    dir="$( cd -P "$( dirname "${source}" )/.." && pwd )"
    cd ${dir}
}

# Downloads and installs the full-fat XXX jarfile
function install_validator() {
    if [ ! -f ${install_dir}/${validator_jar} ] ; then
        wget ${validator_uri} -P ${install_dir}
    fi
    echo "Extract ${install_dir}/${validator_zip}"
    unzip -j "${install_dir}/${validator_zip}" -d ${install_dir}
    echo "... done"
}

cd_script_parent

echo "================================"
echo "INSTALLING JSON SCHEMA VALIDATOR"
echo "--------------------------------"

install_validator

echo "========================"
echo "LINTING ALL JSON SCHEMAS"
echo "------------------------"

java -jar ${install_dir}/${validator_jar} lint "schemas/"
