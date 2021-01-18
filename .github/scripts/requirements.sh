#!/bin/bash
set -e

# Constants
source $GITHUB_WORKSPACE/.github/scripts/constants.sh

function install_igluctl() {
    if [ ! -f "${IGLUCTL}" ]
    then
        echo "igluctl not found, downloading..."
        wget "${VALIDATOR_URI}" -P "${INSTALL_DIR}"
        echo "Extract ${INSTALL_DIR}/${VALIDATOR_ZIP}"
        unzip -j "${INSTALL_DIR}/${VALIDATOR_ZIP}" -d "${INSTALL_DIR}"
        echo "igluctl is installed!"
    else
        echo "igluctl is already installed!"
    fi
}
