#!/bin/bash

set -e

echo "Instalando e configurando o Starship prompt..."

echo "Baixando e executando o script de instalação do Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

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
