#!/bin/bash
# scripts/common/03_docker.sh

set -e

# 1. Instalação do Docker Engine e Docker Compose (via repositório oficial Docker)
echo "Instalando Docker Engine e Docker Compose CLI (repositório oficial)..."

# Instala pacotes necessários para configurar o repositório
sudo apt update
sudo apt install -y ca-certificates curl gnupg

# Adiciona a chave GPG oficial do Docker
sudo install -y -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Docker Engine e Docker Compose instalados."

# 2. Configuração de Grupo para não usar 'sudo'
echo "Configurando grupo 'docker' para não precisar de sudo..."
USERNAME=$(whoami)
sudo usermod -aG docker "$USERNAME"


# # 3. Instalação do Lazydocker
# echo "Instalando Lazydocker (via binário)..."
# LAZYDOCKER_VERSION="0.23.0"
# LAZYDOCKER_URL="https://github.com/jesseduffield/lazydocker/releases/download/v${LAZYDOCKER_VERSION}/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz"
# INSTALL_PATH="/usr/local/bin"

# mkdir -p /tmp/lazydocker_install
# wget -qO- "$LAZYDOCKER_URL" | tar xz -C /tmp/lazydocker_install
# sudo mv /tmp/lazydocker_install/lazydocker "$INSTALL_PATH"
# rm -rf /tmp/lazydocker_install

# echo "Lazydocker instalado. Use o comando 'lazydocker'."