#!/bin/bash
# scripts/common/00_asdf.sh
# Instala e configura o gerenciador de versões asdf (via Git).

set -e

# Versão do ASDF para instalar (recomendado usar uma tag estável)
ASDF_VERSION="v0.14.0" # Atualize conforme a necessidade

echo "Instalando ASDF Version Manager..."

# 1. Instalação
sudo apt update
sudo apt install -y curl git build-essential libssl-dev zlib1g-dev \
    libreadline-dev libsqlite3-dev libbz2-dev

# 2. Clona o repositório do ASDF
ASDF_DIR="$HOME/.asdf"
if [ ! -d "$ASDF_DIR" ]; then
    echo "Clonando asdf versão $ASDF_VERSION..."
    git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR" --branch "$ASDF_VERSION"
else
    echo "Diretório do asdf já existe. Pulando clone."
fi

# 3. Configuração do Shell (Adiciona ao ~/.bashrc)
if ! grep -q "# ASDF configuration" "$HOME/.bashrc"; then
    echo "Adicionando configuração do asdf ao ~/.bashrc..."

    cat << 'EOF' >> "$HOME/.bashrc"

# ASDF configuration
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"
EOF
else
    echo "Configuração do asdf já existe no ~/.bashrc. Pulando."
fi

echo "ASDF instalado em $ASDF_DIR."