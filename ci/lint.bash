#!/bin/bash
set -e

# Constants
install_dir="/tmp"
validator_v="2.2.6"
validator_uri="https://bintray.com/artifact/download/fge/maven/com/github/fge/json-schema-validator/${validator_v}"
validator_jar="json-schema-validator-${validator_v}-lib.jar"
jsonschema_glob="schemas/*/*/jsonschema"

# Similar to Perl die
function die() {
    echo "$@" 1>&2 ; exit 1;
}

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
        wget ${validator_uri}/${validator_jar} -P ${install_dir}
    fi
    echo "... done"
}

# Checks a single JSON Schema's syntax.
#
# Arguments:
# 1. schema_path
# 2. sucesses
# 3. failures
# 4. out_successes (out parameter)
# 5. out_failures (out parameter)
function check_syntax() {
    [ "$#" -eq 5 ] || die "5 arguments required, $# provided"
    local __schema_path=$1
    local __successes=$2
    local __failures=$3
    local __out_successes=$4
    local __out_failures=$5

    set +e
    lint_out=`java -jar ${install_dir}/${validator_jar} --syntax ${1}`
    local lint_ok=${?}
    set -e
    if [ ${lint_ok} == "0" ] ; then
        echo "[ $(tput setaf 2)+$(tput sgr0) ] ${1}"
        eval $__out_successes="$((__successes+1))"
    else
        echo "[ $(tput setaf 1)x$(tput sgr0) ] ${1}"
        echo ""
        echo ${lint_out}
        echo ""
        eval ${__out_failures}="$((__failures+1))"
    fi
}

# Checks all schemas
#
# Arguments:
# 1. out_status (out parameter)
function check_schemas() {
    [ "$#" -eq 1 ] || die "1 argument required, $# provided"
    local __out_status=$1

    successes=0
    failures=0
    schemas=`find ${jsonschema_glob} -type f`
    while read schema; do
        check_syntax ${schema} ${successes} ${failures} "successes" "failures"
    done <<< "${schemas}"
    echo ""
    echo "... JSON Schema syntax tests: $(tput setaf 2)${successes}$(tput sgr0) passed; $(tput setaf 1)${failures}$(tput sgr0) failed"
    if (( ${failures} > 0 )); then
        eval ${__out_status}="'1'"
    else
        eval ${__out_status}="'0'"
    fi
}


cd_script_parent

echo "================================"
echo "INSTALLING JSON SCHEMA VALIDATOR"
echo "--------------------------------"

install_validator

echo "==================================="
echo "CHECKING SYNTAX OF ALL JSON SCHEMAS"
echo "-----------------------------------"

check_schemas "check_status"
exit ${check_status}
