#!/bin/bash

confirmProceed() {
    while true; do
        read -p "Do you want to proceed? (Y/n)" yn
        case $yn in
            [Yy]* ) break;;
            [Nn]* ) exit 1; break;;
            * ) break;;
        esac
    done
}