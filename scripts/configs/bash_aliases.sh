#!/bin/bash
# scripts/configs/00_bash_aliases.sh
# Adiciona aliases personalizados do Eza ao ~/.bashrc

set -e

ALIAS_FILE="$HOME/.bashrc"

echo "Configurando aliases para Eza e comandos do Bash no $ALIAS_FILE..."

cat << 'EOF_ALIASES' >> "$ALIAS_FILE"


# Eza como substituto do 'ls'
# -l: formato longo (detalhes)
# -h: tamanho legível (e.g., 1K, 2M)
# --group-directories-first: agrupa diretórios no topo
# --icons=auto: exibe ícones
alias ls='eza -lh --group-directories-first --icons=auto'

# Inclui arquivos ocultos/ponto (ls -a)
alias lsa='ls -a'

# Visualização em árvore com Eza
alias lt='eza --tree --level=2 --long --icons --git'

# Visualização em árvore com arquivos ocultos (lt -a)
alias lta='lt -a'

# ==========================================================

EOF_ALIASES

echo "Aliases de Eza adicionados ao ~/.bashrc."