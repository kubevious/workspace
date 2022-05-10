#!/bin/bash
MY_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
MY_DIR="$(dirname $MY_PATH)"

source ${MY_DIR}/dialogs.sh

WORKSPACE_DIR=$PWD
if [[ "$(uname -s)" == CYGWIN* ]]; then
    WORKSPACE_DIR=`cygpath -w $WORKSPACE_DIR`
fi
echo "Workspace Dir: ${WORKSPACE_DIR}"

confirmProceed

cd ${WORKSPACE_DIR}

printf "%s\n" "${REPOSITORIES[@]}" > ${WORKSPACE_DIR}/.kubevious-repos

for REPO_NAME in "${REPOSITORIES[@]}"
do

    echo " "
    echo "Setting up ${REPO_NAME}..."
    REPO_PATH=${WORKSPACE_DIR}/${REPO_NAME}.git
    echo "    Path: ${REPO_PATH}"

    if [[ ! -d ${REPO_PATH} ]]
    then
        echo "Cloning ${REPO_NAME}..."
        git clone https://github.com/kubevious/${REPO_NAME}.git ${REPO_PATH}
        RESULT=$?
        if [ $RESULT -ne 0 ]; then
            echo ">>> FAILED to Git clone https://github.com/kubevious/${REPO_NAME}.git"
            exit 1;
        fi
    else
        echo "Already present: ${REPO_NAME}."
    fi

done




