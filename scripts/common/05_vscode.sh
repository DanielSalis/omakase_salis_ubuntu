#!/bin/bash
# scripts/common/04_vscode.sh

set -e

echo "Instalando Visual Studio Code (via repositório APT oficial)..."

sudo apt update
sudo apt install -y curl gpg


echo "Adicionando chave GPG da Microsoft..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg

echo "Adicionando repositório do VS Code..."
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

rm -f packages.microsoft.gpg
sudo apt update
sudo apt install -y code

echo "Visual Studio Code instalado."