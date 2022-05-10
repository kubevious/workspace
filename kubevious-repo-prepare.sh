#!/bin/bash
THIS_SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
THIS_SCRIPT_DIR="$(dirname $THIS_SCRIPT_PATH)"

echo "*** Kubevious Repo Prepare..." 
echo "    REPO: ${MY_DIR}" 

cd ${MY_DIR}

source ${THIS_SCRIPT_DIR}/scripts/cleanup-repo.sh

source ${THIS_SCRIPT_DIR}/scripts/dependencies.sh

source ${THIS_SCRIPT_DIR}/scripts/upgrade-repo-dependencies.sh

source ${THIS_SCRIPT_DIR}/scripts/install-repo-dependencies.sh

echo "*** Build..." 
${MY_DIR}/build.sh
RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "BUILD FAILED."
  exit 1;
fi