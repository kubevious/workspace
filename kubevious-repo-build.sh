#!/bin/bash

echo "*** Kubevious Repo Build..." 

echo '*************************************'
echo '*************************************'
echo '*************************************'

echo "*** Cleanup..." 
rm -rf dist/

echo "*** Building..." 
npm run build
RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "Build failed"
  exit 1;
fi

echo "*** Linting..." 
npm run lint
RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "Lint failed"
  exit 1;
fi
