#!/usr/bin/env bash
# Biblioteca compartilhada; não executar diretamente.
if [[ -z ${OMAKASE_PLATFORM_LOADED:-} ]]; then
    set -euo pipefail
    source /etc/os-release
    case "$ID" in
        ubuntu|fedora) DISTRO="$ID" ;;
        *) echo "Distribuição não suportada: $ID. Use Ubuntu ou Fedora." >&2; exit 1 ;;
    esac
    readonly DISTRO
    OMAKASE_PLATFORM_LOADED=1
fi

install_packages() {
    if [[ "$DISTRO" == ubuntu ]]; then
        sudo apt-get update
        sudo apt-get install -y "$@"
    else
        sudo dnf install -y "$@"
    fi
}

require_user() {
    if [[ "$EUID" == 0 ]]; then
        echo "Execute como usuário normal, sem sudo; os scripts usam sudo quando necessário." >&2
        exit 1
    fi
}

require_gnome() {
    if ! command -v gsettings >/dev/null || [[ "${XDG_CURRENT_DESKTOP:-}" != *GNOME* && "${XDG_CURRENT_DESKTOP:-}" != *gnome* ]]; then
        echo "Ajustes ignorados: execute dentro de uma sessão GNOME."
        exit 0
    fi
}
