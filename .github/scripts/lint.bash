#!/bin/bash
set -e

# Constants
source $GITHUB_WORKSPACE/.github/scripts/constants.sh

# Required artifacts
source $GITHUB_WORKSPACE/.github/scripts/requirements.sh

echo "================================"
echo "INSTALLING JSON SCHEMA VALIDATOR"
echo "--------------------------------"

install_igluctl

echo "========================"
echo "LINTING ALL JSON SCHEMAS"
echo "------------------------"

java -jar ${IGLUCTL} lint --skip-checks optionalNull,description,numericMinMax,stringLength,stringMaxLengthRange,rootObject $GITHUB_WORKSPACE/schemas/
