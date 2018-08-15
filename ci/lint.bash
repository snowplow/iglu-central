#!/bin/bash
set -e

# Constants
source $TRAVIS_BUILD_DIR/ci/constants.sh

# Go to parent dir of this script
function cd_script_parent() {
    source="${BASH_SOURCE[0]}"
    while [ -h "${source}" ] ; do source="$(readlink "${source}")"; done
    dir="$( cd -P "$( dirname "${source}" )/.." && pwd )"
    cd ${dir}
}

# Downloads and installs the full-fat XXX jarfile
function install_validator() {
    if [ ! -f ${IGLUCTL} ] ; then
        wget ${VALIDATOR_URI} -P ${INSTALL_DIR}
    fi
    echo "Extract ${INSTALL_DIR}/${VALIDATOR_ZIP}"
    unzip -j "${INSTALL_DIR}/${VALIDATOR_ZIP}" -d ${INSTALL_DIR}
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

java -jar ${IGLUCTL} lint "schemas/"
