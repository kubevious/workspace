#!/bin/bash

export MY_DIR=$(pwd)

echo "*** Kubevious Setup NPM Resolutions..." 
echo "    REPO: ${MY_DIR}" 

unset FORCE_RESOLVE_DEPENDENCIES
source ${MY_DIR}/dependencies.sh

for DEP_NAME in "${FORCE_RESOLVE_DEPENDENCIES[@]}"
do
  echo "  > Force Resolve: ${DEP_NAME}"
  DEP_VERSION=$(jq '.dependencies['\"${DEP_NAME}\"']' package.json)
  echo "  >       Version: ${DEP_VERSION}"

  if [[ "${DEP_VERSION}" != "null" ]]; then
    echo "  >       Setting up resolution: ${DEP_NAME} => ${DEP_VERSION}"
    CONTENTS=$(jq '.resolutions['\"${DEP_NAME}\"']='${DEP_VERSION}'' package.json)
    echo "${CONTENTS}" > package.json
  fi
done

