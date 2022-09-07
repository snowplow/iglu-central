#!/bin/bash
set -e

# Constants
source $GITHUB_WORKSPACE/.github/scripts/constants.sh

function install_igluctl() {
    if [ ! -f "${IGLUCTL}" ]
    then
        echo "igluctl not found, downloading..."
        wget "${VALIDATOR_URI}" -P "${INSTALL_DIR}"
        echo "unzipping..."
        unzip ${INSTALL_DIR}/$VALIDATOR_ZIP -d ${INSTALL_DIR}
        echo "done!"
    else
        echo "igluctl is already downloaded!"
    fi
}
