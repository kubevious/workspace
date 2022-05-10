#!/bin/bash

echo "*** Yarn Install..." 
yarn

echo "*** Processing Local Dev Links..." 
for MODULE_NAME in "${LOCAL_DEV_LINK_DEPENDENCIES[@]}"; do
  echo "    |- ${MODULE_NAME}"
  ${THIS_SCRIPT_DIR}/kubevious-dev-link-module.sh "${MODULE_NAME}"
  RESULT=$?
  if [ $RESULT -ne 0 ]; then
    echo ">>> Dev Link Module FAILED."
    exit 1;
  fi
done

echo "*** Processing Local Cleanup..." 
${THIS_SCRIPT_DIR}/kubevious-npm-force-cleanup-nested-dependencies.sh
RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo ">>> Local Cleanup FAILED."
  exit 1;
fi

if [[ -f ${MY_DIR}/post_install.sh ]]; then
  echo "*** Running Post Install Script..." 
  ${MY_DIR}/post_install.sh
  RESULT=$?
  if [ $RESULT -ne 0 ]; then
    echo ">>> Post Install Script FAILED."
    exit 1;
  fi
fi