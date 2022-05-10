#!/bin/bash

export MY_DIR=$(pwd)

echo "*** Kubevious NPM Nested Dependencies..." 
echo "    REPO: ${MY_DIR}" 

if [[ ! -d node_modules ]]; then
  echo "ERROR: no node_modules found" 
  exit 1;
fi;

for module in node_modules/@kubevious/*; do
  echo "| ${module}"
  for nested in ${module}/node_modules/*; do
    if [[ -d ${nested} ]]; then
      echo "|--- ${nested}"
    fi
  done
  for nested in ${module}/node_modules/@kubevious/*; do
    if [[ -d ${nested} ]]; then
      echo "|--- ${nested}"
    fi
  done
  echo ""
done
