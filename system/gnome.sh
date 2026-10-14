#!/bin/bash
source "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../scripts/lib" && pwd)/platform.sh"
require_user
require_gnome
# system/00_gnome.sh
# Aplica configurações de UI e atalhos específicos para o ambiente GNOME.

set -euo pipefail

echo "Aplicando configurações de UI e usabilidade do GNOME..."

# --- 1. Configurações de Aparência (Tema Escuro) ---
echo "1. Configurando tema escuro (Dark Mode)..."
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

echo "Tema escuro aplicado."


# --- 2. Configurações da Dock (Ubuntu/Dash to Dock) ---
echo "2. Configurando a Dock (posicao inferior e redução de tamanho)..."

if gsettings list-schemas | grep -qx org.gnome.shell.extensions.dash-to-dock; then
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
    gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
    gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
    gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
else
    echo "Dash to Dock ausente; ajustes da dock ignorados."
fi
