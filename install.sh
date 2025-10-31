#!/bin/bash
# install.sh
# Script principal para orquestrar a instalação

set -e

# ==========================================================
# 0. Instalação do GUM (Mantido no início para uso imediato)
# ==========================================================
GUM_VERSION="0.17.0"
TEMP_FILE="gum.deb"
DOWNLOAD_URL="https://github.com/charmbracelet/gum/releases/download/v${GUM_VERSION}/gum_${GUM_VERSION}_amd64.deb"

gum style \
    --foreground 212 \
    --border-foreground 212 \
    --border rounded \
    --padding "1 2" \
    "Instalando Gum (versão $GUM_VERSION) para scripts interativos."

sudo apt update
sudo apt install -y wget
gum log --level info "Baixando pacote .deb do Gum..."
wget -qO "$TEMP_FILE" "$DOWNLOAD_URL"
sudo apt install -y --allow-downgrades "./$TEMP_FILE"
gum log --level info "Removendo arquivo temporário..."
rm "$TEMP_FILE"

gum style \
    --foreground 8 \
    --border-foreground 8 \
    --border double \
    --padding "1 2" \
    "🚀 Iniciando a instalação completa do Developer Setup (Omakub Clone)."

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
FONTS_DIR="$PROJECT_DIR/fonts"
SCRIPTS_DIR="$PROJECT_DIR/scripts"
SYSTEM_DIR="$PROJECT_DIR/system"

# ==========================================================
# 0. Instalação de Fontes
# ==========================================================
gum style \
    --bold --foreground 10 "🎨ETAPA 0: Instalação de Fontes"

gum spin --title "Executando scripts de fontes em $FONTS_DIR..." -- \
    bash -c "
        for script in \"$FONTS_DIR\"/*.sh; do
            bash \"\$script\";
        done
    "

# ==========================================================
# 1. Instalação de Ferramentas Comuns
# ==========================================================
gum style \
    --bold --foreground 12 "⚙️ETAPA 1: Instalações Essenciais (Git, ASDF, Docker, etc)"

gum spin --title "Executando scripts de ferramentas em $SCRIPTS_DIR/common/..." -- \
    bash -c "
        for script in \"$SCRIPTS_DIR\"/common/*.sh; do
            bash \"\$script\";
        done
    "

# ==========================================================
# 2. Configurações de Aplicativos
# ==========================================================
gum style \
    --bold --foreground 14 "🔧ETAPA 2: Configurações de Aplicativos (Aliases, VSCode)"

gum spin --title "Executando scripts de configuração em $SCRIPTS_DIR/configs/..." -- \
    bash -c "
        for script in \"$SCRIPTS_DIR\"/configs/*.sh; do
            bash \"\$script\";
        done
    "

# ==========================================================
# 3. Modificações de Sistema (Opcional)
# ==========================================================
gum style \
    --bold --foreground 5 "✨ ETAPA 3: Modificações Opcionais de Sistema (UI)"

# Usando GUM para a confirmação
if gum confirm \
    --selected.foreground 10 \
    --unselected.foreground 8 \
    --prompt.foreground 15 \
    "Deseja aplicar as modificações de UI do sistema (Tema Escuro, Dock, Atalhos)?"; 
then
    gum log --level warn "Ajustes de UI serão aplicados. Verificando scripts em /system..."
    
    gum spin --title "Aplicando modificações de sistema em $SYSTEM_DIR/..." -- \
        bash -c "
            for script in \"$SYSTEM_DIR\"/*.sh; do
                if [ -f \"\$script\" ]; then
                    bash \"\$script\";
                fi
            done
        "
    gum log --level info "Configurações de UI concluídas."
else
    gum log --level info "Modificações de UI ignoradas."
fi

# ==========================================================
# FIM
# ==========================================================

gum style \
    --bold --foreground 2 \
    --border-foreground 2 \
    --border double \
    --padding "1 2" \
    "🎉 Instalação Concluída com Sucesso!"

gum log --level warn "⚠️ Ações Pós-Instalação Necessárias:"
gum log --level info "1. Saia e entre novamente (ou use 'newgrp docker') para ativar as permissões do Docker."
gum log --level info "2. Execute 'source ~/.bashrc' para carregar os novos aliases e o Starship."
gum log --level info "3. Algumas mudanças de UI do GNOME podem exigir Logout/Login para entrar em vigor."