#!/bin/bash
MY_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
MY_DIR="$(dirname $MY_PATH)"

REPOS_DIR="${MY_DIR}/.."

echo -en "\033]0;KUBEVIOUS-OSS\007"
echo -en "\033]1;KUBEVIOUS-OSS\007"
cd ${REPOS_DIR}

ttab -t "BACKEND" -d "${REPOS_DIR}/backend.git" echo -e "\n**** KUBEVIOUS BACKEND ****\n1) ./prepare.sh\n2a) ./run-dev-k8s.sh\n\n2b) ./run-dev.sh"

ttab -t "COLLECTOR" -d "${REPOS_DIR}/collector.git" echo -e "\n**** KUBEVIOUS COLLECTOR ****\n1) ./prepare.sh\n2a) ./run-dev-short-delay.sh\n2b) ./run-dev.sh\n"

ttab -t "PARSER" -d "${REPOS_DIR}/parser.git" echo -e "\n**** KUBEVIOUS PARSER ****\n1) ./prepare.sh\n2a) ./run-dev-mock.sh\n2b) ./run-dev-k8s.sh\n"

ttab -t "GUARD" -d "${REPOS_DIR}/guard.git" echo -e "\n**** KUBEVIOUS GUARD ****\n1) ./prepare.sh\n2a) ./run-dev-mock.sh\n2b) ./run-dev.sh\n"

ttab -t "GUARD-VALIDATE" -d "${REPOS_DIR}/guard.git/sample" echo -e "\n**** KUBEVIOUS GUARD VALIDATOR RUNNER ****\n1a) ./validate-simple.sh\n1b) ./validate-helm.sh\n"

ttab -t "UI" -d "${REPOS_DIR}/ui.git" echo -e "\n**** KUBEVIOUS UI ****\n1) ./prepare.sh\n2) ./run-dev.sh\n"

ttab -t "DEPENDENCIES" -d "${REPOS_DIR}/dependencies.git" echo -e "\n**** KUBEVIOUS DEPENDENCIES ****\n1) ./run-dependencies.sh\n"



source ../dependencies.git/k8s/configuration.sh
export KUBECONFIG=${K8S_CONFIG_PATH}