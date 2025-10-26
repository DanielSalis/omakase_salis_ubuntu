#!/bin/bash
# install.sh

set -e
echo " 🚀 Iniciando a instalação do RD Setup..."

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPTS_DIR="$PROJECT_DIR/scripts"
FONTS_DIR="$PROJECT_DIR/fonts"

echo "🎨 Instalando fontes (Nerd Fonts)..."
for script in "$FONTS_DIR"/*.sh; do
    echo "  -> Executando $(basename "$script")..."
    bash "$script"
done

echo "⚙️  Executando instalações essenciais..."
for script in "$SCRIPTS_DIR"/common/*.sh; do 
    echo " -> Executando $(basename "$script")..."
    bash "$script"  
done


echo "🎨 Aplicando configurações..."
for script in "$SCRIPTS_DIR"/configs/*.sh; do 
    echo " -> Executando $(basename "$script")..."
    bash "$script"  
done

echo "✅ Instalação concluída com sucesso!"
echo "Necessario fazer logout para aplicar todas as alteracoes"
