# Kubevious Workspace Tools

## Initial Workstation Setup
```sh
mkdir kubevious-oss
cd kubevious-oss
git clone https://github.com/kubevious/workspace workspace.git
workspace.git/kubevious-oss-workspace-init.sh
workspace.git/kubevious-workstation-init.sh
```

## Pulling Changes
```sh
cd kubevious-oss
workspace.git/kubevious-workspace-pull.sh
```

## kubevious-workstation-init.sh Contents
### Install NVM
```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```

### Setup Node.js Version
```sh
nvm install 14
nvm alias default 14
nvm use default
node -v
```

### Install YARN
```sh
npm install -g yarn
```

### Install NPM-CHECK-UPDATES
```sh
npm install -g npm-check-updates
```