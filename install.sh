#!/bin/bash
# install.sh

set -e

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
curl -sL "$DOWNLOAD_URL" -o "$TEMP_FILE" 
sudo apt install -y --allow-downgrades "./$TEMP_FILE"
gum log --level info "Removendo arquivo temporário..."
rm "$TEMP_FILE"

gum style \
    --foreground 8 \
    --border-foreground 8 \
    --border double \
    --padding "1 2" \
    "🚀 Iniciando a instalação completa do DeveSetup"

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
FONTS_DIR="$PROJECT_DIR/fonts"
SCRIPTS_DIR="$PROJECT_DIR/scripts"
SYSTEM_DIR="$PROJECT_DIR/system"


run_interactive_selection() {
    local TITLE="$1"
    local SCRIPT_DIR="$2"
    
    AVAILABLE_SCRIPTS=$(find "$SCRIPT_DIR" -maxdepth 1 -name "*.sh" -printf "%f\n" | sort)
    
    if [ -z "$AVAILABLE_SCRIPTS" ]; then
        gum log --level warn "Nenhum script encontrado em $SCRIPT_DIR. Pulando etapa."
        return 0
    fi

    gum log --level info "Selecione as ferramentas em $SCRIPT_DIR..."
    SELECTED_SCRIPTS=$(
        gum filter \
            --placeholder "Filtre ou selecione com Espaço..." \
            --height 15 \
            --header "$TITLE" \
            --limit 10 \
            <<< "$AVAILABLE_SCRIPTS"
    )

    echo $SELECTED_SCRIPTS
    
    if [ -z "$SELECTED_SCRIPTS" ]; then
        gum log --level info "Nenhuma ferramenta selecionada. Pulando."
        return 0
    fi

    echo "Sucesso"
    
    echo "$SELECTED_SCRIPTS" | while IFS= read -r script_name; do
            local script_path="$SCRIPT_DIR/$script_name"
            
            ( gum log --level info "  -> Executando $script_name..." )
            
            gum spin --spinner dot -- bash "$script_path"
            
            ( gum log --level info "  -> $script_name concluído." )
        done
}

# ----------------------------------------------------------------------
# EXECUÇÃO DAS ETAPAS
# ----------------------------------------------------------------------

# ==========================================================
# 0. Instalação de Fontes
# ==========================================================
gum style \
    --bold --foreground 10 "🎨 ETAPA 0: Instalação de Fontes"
    
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
    --bold --foreground 12 "⚙️ ETAPA 1: Instalações Essenciais"
    
run_interactive_selection "Selecione as ferramentas para instalar (Etapa 1: scripts/common/)" "$SCRIPTS_DIR/common"

# ==========================================================
# 2. Configurações de Aplicativos
# ==========================================================
gum style \
    --bold --foreground 14 "🔧 ETAPA 2: Configurações de Aplicativos"
    
run_interactive_selection "Selecione as configurações para aplicar (Etapa 2: scripts/configs/)" "$SCRIPTS_DIR/configs"

# ==========================================================
# 3. Modificações de Sistema
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

gum style \
    --bold --foreground 2 \
    --border-foreground 2 \
    --border double \
    --padding "1 2" \
    "🎉 Instalação Concluída com Sucesso!"

gum log --level warn "⚠️ Logar novamente"