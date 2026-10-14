#!/usr/bin/env bash
set -euo pipefail
PROJECT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

usage() {
    cat <<'HELP'
Uso: bash install.sh [--list | --help | CAMINHO_SCRIPT ...]
Sem argumentos: seleção interativa de fontes, ferramentas, configurações e sistema.
--list: lista os módulos disponíveis, sem instalar nada.
CAMINHO_SCRIPT: executa apenas os módulos informados (relativos ao repositório).
Exemplo: bash install.sh scripts/common/05_vscode.sh
HELP
}
list_scripts() {
    (cd "$PROJECT_DIR" && find fonts scripts/common scripts/configs system -maxdepth 1 -type f -name '*.sh' | sort)
}
case "${1:-}" in
    --help|-h) usage; exit 0 ;;
    --list) list_scripts; exit 0 ;;
esac
source "$PROJECT_DIR/scripts/lib/platform.sh"
require_user

run_script() {
    echo "Executando $1 ($DISTRO)..."
    bash "$PROJECT_DIR/$1"
}
if (( $# > 0 )); then
    # Valida todos os módulos antes de executar qualquer instalação.
    available=$(list_scripts)
    for script in "$@"; do
        if ! grep -Fxq -- "$script" <<< "$available"; then
            echo "Módulo inválido: $script. Consulte --list." >&2
            exit 1
        fi
    done
    for script in "$@"; do run_script "$script"; done
    exit 0
fi

if [[ ! -t 0 || ! -t 1 ]]; then
    echo "Use um terminal para o menu, ou informe os módulos. Consulte --help." >&2
    exit 1
fi
if ! command -v gum >/dev/null; then
    echo "Instalando Gum para o menu interativo..."
    install_packages curl
    GUM_VERSION=0.17.0
    case "$(uname -m)" in
        x86_64) deb_arch=amd64; rpm_arch=x86_64 ;;
        aarch64) deb_arch=arm64; rpm_arch=aarch64 ;;
        *) echo "Arquitetura não suportada pelo bootstrap do Gum." >&2; exit 1 ;;
    esac
    temp_dir=$(mktemp -d)
    trap 'rm -rf "$temp_dir"' EXIT
    if [[ "$DISTRO" == ubuntu ]]; then
        asset="gum_${GUM_VERSION}_${deb_arch}.deb"
    else
        asset="gum-${GUM_VERSION}-1.${rpm_arch}.rpm"
    fi
    package="$temp_dir/$asset"
    curl -fsSL "https://github.com/charmbracelet/gum/releases/download/v${GUM_VERSION}/${asset}" -o "$package"
    install_packages "$package"
fi

gum style --bold "Developer Setup — $DISTRO"
for directory in fonts scripts/common scripts/configs system; do
    available=$(list_scripts | grep "^$directory/" || true)
    [[ -n "$available" ]] || continue
    selected=$(gum choose --no-limit --header "Selecione módulos de $directory (Espaço / Enter; Ctrl+C cancela)" <<< "$available") || exit 130
    while IFS= read -r script; do
        [[ -n "$script" ]] && run_script "$script"
    done <<< "$selected"
done
echo "Concluído. Abra um novo terminal para carregar configurações de shell."
echo "Se instalou Docker, saia e entre novamente para aplicar o grupo docker."
