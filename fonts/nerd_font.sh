#!/bin/bash

set -e

FONT_NAME="FiraCode"
FONT_DIR="$HOME/.local/share/fonts"
TEMP_DIR="/tmp/nerd-font-install"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip"
ZIP_FILE="$TEMP_DIR/$FONT_NAME.zip"

echo "Instalando $FONT_NAME Nerd Font..."

# 1. Instala utilitários necessários
sudo apt update
sudo apt install -y wget unzip

# 2. Cria diretórios temporário e de destino
mkdir -p "$TEMP_DIR"
mkdir -p "$FONT_DIR"

# 3. Baixa a fonte
echo "Baixando fonte de $FONT_URL..."
wget -q "$FONT_URL" -O "$ZIP_FILE"

# 4. Descompacta e move os arquivos
echo "Descompactando e instalando em $FONT_DIR..."
unzip -q -o "$ZIP_FILE" -d "$TEMP_DIR" 

# Move apenas os arquivos TTF/OTF
find "$TEMP_DIR" -name "*.[ot]tf" -exec mv -t "$FONT_DIR" {} +

# 5. Limpa os arquivos temporários
rm -rf "$TEMP_DIR"

# 6. Atualiza o cache de fontes do sistema
echo "Atualizando o cache de fontes..."
fc-cache -fv

echo "✅ $FONT_NAME Nerd Font instalada"