#!/bin/bash

echo "*** Copy Tools..." 
if [[ ! -z "${FORCE_RESOLVE_DEPENDENCIES}" ]]; then
  echo "   | - Has FORCE_RESOLVE_DEPENDENCIES. Setting up cleanup script"
  mkdir -p tools
  cp -rf ${THIS_SCRIPT_DIR}/kubevious-npm-validate-nested-dependencies.sh ./tools/
fi

echo "*** Update Dependencies..." 
DEPS_UPDATE_ARGS=""
for DEP_NAME in "${REPO_DEPENDENCIES[@]}"; do
  echo "    > Depends on: ${DEP_NAME}"
  DEPS_UPDATE_ARGS="${DEPS_UPDATE_ARGS} ${DEP_NAME}"
done
npm-check-updates -u ${DEPS_UPDATE_ARGS}
RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo ">>> NPM-CHECK-UPDATES FAILED."
  exit 1;
fi

${THIS_SCRIPT_DIR}/kubevious-npm-setup-resolutions.sh
RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo ">>> Setup NPM Resolutions FAILED."
  exit 1;
fi
