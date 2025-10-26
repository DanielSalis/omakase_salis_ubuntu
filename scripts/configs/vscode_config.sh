#!/bin/bash
# scripts/configs/vscode_config.sh

set -e

KANAGAWA_THEME="Kanagawa"
KANAGAWA_EXTENSION="qufiwefefwoyn.kanagawa"
SETTINGS_FILE="$HOME/.config/Code/User/settings.json"

if ! command -v code &> /dev/null
then
    echo "⚠️ O VS Code não parece estar instalado. Pulando a instalação/configuração."
    exit 0
fi

echo "Instalando extensões e temas do VS Code..."

# 2. Instalação do Tema Kanagawa
echo "Instalando tema Kanagawa..."
code --install-extension "$KANAGAWA_EXTENSION"

# 3. Instalação de outras extensões
echo "Instalando extensão oficial do Docker..."
code --install-extension ms-azuretools.vscode-docker

# 4. Aplicando o Tema Kanagawa via settings.json
echo "Aplicando o tema '$KANAGAWA_THEME' como padrão..."

# Cria o arquivo settings.json se ele não existir
mkdir -p "$(dirname "$SETTINGS_FILE")"
if [ ! -f "$SETTINGS_FILE" ]; then
    echo "{}" > "$SETTINGS_FILE"
fi

SETTING_LINE="\"workbench.colorTheme\": \"$KANAGAWA_THEME\""

if grep -q "workbench.colorTheme" "$SETTINGS_FILE"; then
    sed -i "/workbench.colorTheme/c\    $SETTING_LINE," "$SETTINGS_FILE"
elif [ "$(cat "$SETTINGS_FILE" | wc -l)" -eq 2 ] && [ "$(head -n 1 "$SETTINGS_FILE")" = "{" ] && [ "$(tail -n 1 "$SETTINGS_FILE")" = "}" ]; then
    sed -i '$i\    '"$SETTING_LINE"'' "$SETTINGS_FILE"
else
    if command -v jq &> /dev/null; then
        echo "Usando 'jq' para garantir a sintaxe correta."
        jq --arg theme "$KANAGAWA_THEME" '. + {"workbench.colorTheme": $theme}' "$SETTINGS_FILE" > "$SETTINGS_FILE.tmp" && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"
    else
        echo "⚠️ Atenção: Precisa de edicao manual"
    fi
fi

echo "Configuração de tema concluída."