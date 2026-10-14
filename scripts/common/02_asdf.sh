#!/bin/bash
source "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../lib" && pwd)/platform.sh"
require_user
# scripts/common/00_asdf.sh
# Instala e configura o gerenciador de versões asdf (via Git).


# Versão do ASDF para instalar (recomendado usar uma tag estável)
ASDF_VERSION="v0.14.0" # Atualize conforme a necessidade

echo "Instalando ASDF Version Manager..."

# 1. Instalação
if [[ "$DISTRO" == ubuntu ]]; then
    install_packages curl git build-essential libssl-dev zlib1g-dev libreadline-dev libsqlite3-dev libbz2-dev
else
    install_packages curl git gcc gcc-c++ make openssl-devel zlib-devel readline-devel sqlite-devel bzip2-devel
fi

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