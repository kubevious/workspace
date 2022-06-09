#!/bin/bash
THIS_SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
THIS_SCRIPT_DIR="$(dirname $THIS_SCRIPT_PATH)"

echo "*** Kubevious Node.js Project Deps Fetcher" 
echo "    REPO: ${MY_DIR}" 

cd ${THIS_SCRIPT_DIR}/..

${THIS_SCRIPT_DIR}/tools/nodejs-project-deps-fetcher/run-dev.sh output-matrix