#!/bin/bash
MY_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
MY_DIR="$(dirname $MY_PATH)"

source ${MY_DIR}/scripts/dialogs.sh

cd ${MY_DIR}

WORKSPACE_DIR=$(dirname $MY_DIR)
if [[ "$(uname -s)" == CYGWIN* ]]; then
    WORKSPACE_DIR=`cygpath -w $WORKSPACE_DIR`
fi
echo "Workspace Dir: ${WORKSPACE_DIR}"

confirmProceed

declare -a REPOSITORIES
let i=0
while IFS=$'\n' read -r line_data; do
    REPOSITORIES[i]="${line_data}"
    ((++i))
done < ${WORKSPACE_DIR}/.kubevious-repos

for REPO_NAME in "${REPOSITORIES[@]}"
do
    echo "Refreshing ${REPO_NAME}..."

    REPO_PATH=${WORKSPACE_DIR}/${REPO_NAME}.git
    echo "    Path: ${REPO_PATH}"
    echo " "

    if [[ -d ${REPO_PATH} ]]
    then
        echo "Pulling ${REPO_NAME}..."
        cd ${REPO_PATH}
        git pull
    else
        echo "Missing ${REPO_NAME}. Skipped."
    fi
done

