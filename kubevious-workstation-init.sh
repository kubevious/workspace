#!/bin/bash

echo "*** Install NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

echo "*** Setup Node.js version"
nvm install 14
nvm alias default 14
nvm use default
node -v

echo "*** Install YARN..."
npm install -g yarn

echo "*** Install NPM-CHECK-UPDATES..."
npm install -g npm-check-updates

echo "*** Install TTAB..."
npm install -g ttab