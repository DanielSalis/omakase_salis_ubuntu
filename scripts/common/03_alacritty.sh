#!/bin/bash
# scripts/common/02_alacritty.sh

set -e

FONT_NAME="FiraCode Nerd Font Mono"

# 1. Instalação do Alacritty
echo "Instalando Alacritty..."
sudo apt update
sudo apt install -y alacritty

# 2. Configuração do Alacritty
echo "Copiando configuração básica para ~/.config/alacritty/alacritty.toml"
CONFIG_DIR="$HOME/.config/alacritty"
mkdir -p "$CONFIG_DIR"

ALACRITTY_CONFIG="$CONFIG_DIR/alacritty.toml"

# Cria ou sobrescreve o arquivo de configuração no formato TOML.
cat << EOL > "$ALACRITTY_CONFIG"
# Configuração Alacritty Personalizada (TOML)

# Font Configuration
[font]
size = 11.0

[font.normal]
family = "$FONT_NAME"
style = "Regular"

[font.bold]
family = "$FONT_NAME"
style = "Bold"

[font.italic]
family = "$FONT_NAME"
style = "Italic"

# Colors Configuration (Exemplo de cores escuras)
[colors.primary]
background = '0x1e1e2e'
foreground = '0xcdd6f4'

# Opções de Shell
[shell]
program = "/bin/bash" # Pode ser alterado para /bin/zsh se você instalar
args = ["-l"]
EOL

echo "Arquivo de configuração Alacritty criado/atualizado com a fonte '$FONT_NAME' em TOML."