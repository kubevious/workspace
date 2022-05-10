#!/bin/bash
MY_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
MY_DIR="$(dirname $MY_PATH)"

cd ${MY_DIR}/..

helper-data-store.git/stop-dependencies.sh 
helper-mongodb.git/stop-dependencies.sh 
helper-mysql.git/stop-dependencies.sh 
helper-rabbitmq.git/stop-dependencies.sh 
helper-redis.git/stop-dependencies.sh 
helpers.git/stop-dependencies.sh 

docker container prune -f