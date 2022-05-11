# Kubevious Workspace Tools

## Cloning Repositories
```sh
mkdir kubevious-oss
cd kubevious-oss
git clone https://github.com/kubevious/workspace workspace.git
workspace.git/kubevious-oss-workspace-init.sh
```

## Pulling Recent Changes
```sh
cd kubevious-oss
workspace.git/kubevious-workspace-pull.sh
```

## Install Global Tools
Run full install script:
```sh
workspace.git/kubevious-workstation-init.sh
```

**Install Node.js v14**
Install NVM
```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```

Install and activate Node.js v14
```sh
nvm install 14
nvm alias default 14
nvm use default
node -v
```

**Install YARN**
```sh
npm install -g yarn
```

**Install NPM-CHECK-UPDATES**
```sh
npm install -g npm-check-updates
```
**Install Caddy Web Server**
Follow instructions: https://caddyserver.com/docs/install