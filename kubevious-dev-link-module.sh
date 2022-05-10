#!/bin/bash
MY_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
MY_DIR="$(dirname $MY_PATH)"

echo "*** Kubevious Dev Link Module..." 

export DEST_ROOT="$(pwd)"
echo "    DEST_ROOT: ${DEST_ROOT}" 

export PACKAGE_REPO=$1
if [[ -z "${PACKAGE_REPO}" ]]; then
    echo "ERROR: PACKAGE_REPO in not set. Exiting."
    echo "Usage: kubevious-dev-link-module.sh [name-of-the-repo]" 
    exit 2;
fi
echo "    PACKAGE_REPO: ${PACKAGE_REPO}" 

export SOURCE_DIR="${DEST_ROOT}/../${PACKAGE_REPO}.git"
echo "    SOURCE_DIR: ${SOURCE_DIR}" 
if [[ ! -d "${SOURCE_DIR}" ]] ; then
    echo "ERROR: Directory ${SOURCE_DIR} is not there, aborting."
    exit 2
fi

export PACKAGE_JSON_PATH="${SOURCE_DIR}/package.json"
echo "    PACKAGE_JSON_PATH: ${PACKAGE_JSON_PATH}" 
if [[ ! -f "${PACKAGE_JSON_PATH}" ]] ; then
    echo "ERROR: File ${PACKAGE_JSON_PATH} is not there, aborting."
    exit 2
fi

export PACKAGE_NAME=$(jq -r ".name" "${PACKAGE_JSON_PATH}")
echo "    PACKAGE_NAME: ${PACKAGE_NAME}" 
if [[ -z "${PACKAGE_NAME}" ]]; then
    echo "Error: \$PACKAGE_NAME in not set. Exiting."
    exit 2;
fi

export DEST_NODE_MODULES_DIR="${DEST_ROOT}/node_modules"
echo "    DEST_NODE_MODULES_DIR: ${DEST_NODE_MODULES_DIR}" 
if [[ ! -d "${DEST_NODE_MODULES_DIR}" ]] ; then
    echo "ERROR: Directory ${DEST_NODE_MODULES_DIR} is not there, aborting."
    exit 2
fi

export DEST_DIR="${DEST_NODE_MODULES_DIR}/${PACKAGE_NAME}"
echo "    DEST_DIR: ${DEST_DIR}" 


echo "** BUILDING ${SOURCE_DIR}..."
cd ${SOURCE_DIR}
./build.sh
RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "** BUILD FAILED"
  exit 1;
fi

echo "** CLEANING UP ${DEST_ROOT}..."
cd ${DEST_ROOT}
rm -rf ${DEST_DIR}/dist
rm -rf ${DEST_DIR}/node_modules
if [[ -d "${SOURCE_DIR}/public" ]] ; then
  rm -rf ${DEST_DIR}/public
fi


function copyToDest()
{
  echo "** COPYING TO $1 to $2"
  cp -rf $1 $2
}

copyToDest "${SOURCE_DIR}/package.json" "${DEST_DIR}/package.json"

copyToDest "${SOURCE_DIR}/dist" "${DEST_DIR}/dist"

if [[ -d "${SOURCE_DIR}/public" ]] ; then
  copyToDest "${SOURCE_DIR}/public" "${DEST_DIR}/public"
fi

if [[ -d "${SOURCE_DIR}/node_modules" ]] ; then
  copyToDest "${SOURCE_DIR}/node_modules" "${DEST_DIR}/node_modules"
fi



export TRACKER_FILE_NAME=$(echo "${PACKAGE_NAME}" | sed 's/@//g')
export TRACKER_FILE_PATH="${DEST_ROOT}/dev-package-links/${TRACKER_FILE_NAME}"

mkdir -p $(dirname "${TRACKER_FILE_PATH}")
touch "${TRACKER_FILE_PATH}"

echo "** DONE"

# echo "** RUNNING REACT APP..."
# cd ${MY_DIR}
# ./run-dev.sh
