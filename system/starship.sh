#!/bin/bash
source "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../scripts/lib" && pwd)/platform.sh"
require_user

set -euo pipefail

echo "Instalando e configurando o Starship prompt..."

install_packages curl

echo "Baixando e executando o script de instalação do Starship..."
curl -fsSL https://starship.rs/install.sh | sh -s -- -y

# 2. Configuração no Bash
echo "Configurando o Starship para ser carregado no ~/.bashrc..."
STARSHIP_INIT_LINE='eval "$(starship init bash)"'

if ! grep -q "starship init bash" "$HOME/.bashrc"; then
    echo "Adicionando inicialização do Starship ao ~/.bashrc..."
    
    cat << EOF_STARSHIP >> "$HOME/.bashrc"

# ==========================================================
# STARSHIP PROMPT
# Inicializa o prompt minimalista e rápido.
# Requer: Nerd Font
$STARSHIP_INIT_LINE
# ==========================================================
EOF_STARSHIP
else
    echo "Configuração do Starship já existe no ~/.bashrc"
fi

# 3. Aviso Importante
echo "✅ Starship instalado"
