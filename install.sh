#!/bin/bash
# install.sh
# Script principal para orquestrar a instalação

set -e

GUM_VERSION="0.17.0"
TEMP_FILE="gum.deb"
DOWNLOAD_URL="https://github.com/charmbracelet/gum/releases/download/v${GUM_VERSION}/gum_${GUM_VERSION}_amd64.deb"

echo "Instalando Gum (versão $GUM_VERSION) para scripts interativos..."
sudo apt update
sudo apt install -y wget
echo "Baixando pacote .deb do Gum..."
wget -qO "$TEMP_FILE" "$DOWNLOAD_URL"
sudo apt install -y --allow-downgrades "./$TEMP_FILE"
echo "Removendo arquivo temporário..."
rm "$TEMP_FILE"

echo "🚀 Iniciando a instalação do Developer Setup..."

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
FONTS_DIR="$PROJECT_DIR/fonts"
SCRIPTS_DIR="$PROJECT_DIR/scripts"
SYSTEM_DIR="$PROJECT_DIR/system"

# ==========================================================
# 0. Instalação de Fontes
# ==========================================================
echo "🎨 Instalando fontes (Nerd Fonts)..."
for script in "$FONTS_DIR"/*.sh; do
    echo "  -> Executando $(basename "$script")..."
    bash "$script"
done

# ==========================================================
# 1. Instalação de Ferramentas Comuns
# ==========================================================
echo "⚙️  Executando instalações essenciais (Git, ASDF, Docker, etc)..."
for script in "$SCRIPTS_DIR"/common/*.sh; do
    echo "  -> Executando $(basename "$script")..."
    bash "$script"
done

# ==========================================================
# 2. Configurações de Aplicativos
# ==========================================================
echo "🔧 Aplicando configurações (Aliases, Temas do VSCode)..."
for script in "$SCRIPTS_DIR"/configs/*.sh; do
    echo "  -> Executando $(basename "$script")..."
    bash "$script"
done

# ==========================================================
# 3. Modificações de Sistema
# ==========================================================
echo ""
echo "=========================================================="
echo "❓❓ CONFIGURAÇÃO DA INTERFACE DO USUÁRIO (GNOME/Sistema) ❓❓"
echo "----------------------------------------------------------"
read -r -p "Deseja aplicar as modificações de UI do sistema (Ex: Tema Escuro, Dock, Atalhos)? (s/N): " CONFIRM_UI

if [[ "$CONFIRM_UI" =~ ^[Ss]$ ]]; then
    echo "Ajustes de UI serão aplicados. Verificando scripts em /system..."
    
    
    for script in "$SYSTEM_DIR"/*.sh; do
        if [ -f "$script" ]; then
            echo "  -> Executando $(basename "$script")..."
            bash "$script"
        fi
    done
    echo "Configurações de UI concluídas."
else
    echo "Modificações de UI ignoradas."
fi

echo ""
echo "✅ Instalação concluída com sucesso!"