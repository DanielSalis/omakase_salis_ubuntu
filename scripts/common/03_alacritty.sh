#!/bin/bash
# scripts/common/02_alacritty.sh

set -e

# 1. Instalação do Alacritty
echo "Instalando Alacritty via APT..."
sudo apt update
sudo apt install -y alacritty

# 2. Configuração básica do Alacritty
echo "Copiando configuração básica para ~/.config/alacritty/alacritty.yml"
CONFIG_DIR="$HOME/.config/alacritty"
mkdir -p "$CONFIG_DIR"

ALACRITTY_CONFIG="$CONFIG_DIR/alacritty.yml"
if [ ! -f "$ALACRITTY_CONFIG" ]; then
cat <<EOL > "$ALACRITTY_CONFIG"
# Configuração Alacritty Básica
font:
  normal:
    family: Monospace
    style: Regular
  size: 11.0
colors:
  primary:
    background: '0x16161D'
    foreground: '0xc8c093'
EOL
echo "Arquivo de configuração padrão criado."
else
    echo "Arquivo de configuração já existe. Pulando cópia."
fi