#!/bin/bash
# scripts/configs/vscode_config.sh

set -e

KANAGAWA_THEME="Kanagawa"
KANAGAWA_EXTENSION="qufiwefefwoyn.kanagawa"
FONT_NAME="FiraCode Nerd Font Mono"
SETTINGS_FILE="$HOME/.config/Code/User/settings.json"

if ! command -v code &> /dev/null
then
    echo "⚠️ O VS Code não parece estar instalado. Pulando a instalação/configuração."
    exit 0
fi

echo "Instalando extensões e aplicando configurações de tema/fonte do VS Code..."

# 2. Instalação do Tema Kanagawa
echo "Instalando tema Kanagawa..."
code --install-extension "$KANAGAWA_EXTENSION"

# 3. Instalação de outras extensões
echo "Instalando extensão oficial do Docker..."
code --install-extension ms-azuretools.vscode-docker

# 4. Aplicando o Tema e a Fonte via settings.json
echo "Aplicando o tema '$KANAGAWA_THEME' e configurando a fonte do terminal..."

# Cria o arquivo settings.json se ele não existir
mkdir -p "$(dirname "$SETTINGS_FILE")"
if [ ! -f "$SETTINGS_FILE" ]; then
    echo "{}" > "$SETTINGS_FILE"
fi

# Define todas as configurações chave-valor necessárias
THEME_SETTING="\"workbench.colorTheme\": \"$KANAGAWA_THEME\""
FONT_SETTING="\"terminal.integrated.fontFamily\": \"$FONT_NAME\""
FONT_SIZE_SETTING="\"terminal.integrated.fontSize\": 12"
PROFILE_SETTING="\"terminal.integrated.defaultProfile.linux\": \"bash\""

# Lista de configurações (para usar em 'jq')
declare -A SETTINGS
SETTINGS["workbench.colorTheme"]="$KANAGAWA_THEME"
SETTINGS["terminal.integrated.fontFamily"]="$FONT_NAME"
SETTINGS["terminal.integrated.fontSize"]=12
SETTINGS["terminal.integrated.defaultProfile.linux"]="bash"

# Abordagem robusta com 'jq'
if command -v jq &> /dev/null; then
    echo "Usando 'jq' para aplicar todas as configurações com segurança."
    
    # Constrói o objeto de configurações para o jq
    JQ_FILTER='.'
    for key in "${!SETTINGS[@]}"; do
        # Trata números e strings corretamente no jq
        if [[ "${SETTINGS[$key]}" =~ ^[0-9]+$ ]]; then
            # Valor é um número
            JQ_FILTER+=" + {\"$key\": ${SETTINGS[$key]}}"
        else
            # Valor é uma string
            JQ_FILTER+=" + {\"$key\": \"${SETTINGS[$key]}\"}"
        fi
    done

    jq "$JQ_FILTER" "$SETTINGS_FILE" > "$SETTINGS_FILE.tmp" && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"
fi

echo "Configurações de tema e fonte do terminal concluídas. Serão aplicadas ao iniciar o VS Code."