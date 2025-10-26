#!/bin/bash
# system/00_gnome.sh
# Aplica configurações de UI e atalhos específicos para o ambiente GNOME.

set -e

echo "Aplicando configurações de UI e usabilidade do GNOME..."

# --- 1. Configurações de Aparência (Tema Escuro) ---
echo "1. Configurando tema escuro (Dark Mode)..."
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

echo "Tema escuro aplicado."


# --- 2. Configurações da Dock (Ubuntu/Dash to Dock) ---
echo "2. Configurando a Dock (posicao inferior e redução de tamanho)..."

gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock autohide true

echo "Configurações de Dock aplicadas."


# --- 3. Criar Atalho Personalizado
echo "3. Criando atalho Ctrl+Enter para abrir o Alacritty..."

ALACRITTY_COMMAND="alacritty"

SHORTCUT_NAME="custom-alacritty-terminal"

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$SHORTCUT_NAME/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$SHORTCUT_NAME/ name 'Open Alacritty'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$SHORTCUT_NAME/ command "$ALACRITTY_COMMAND"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$SHORTCUT_NAME/ binding '<Super>Return' # <Control>Return é o equivalente a Ctrl+Enter

echo "✅ Atalho Super+Enter para Alacritty criado."