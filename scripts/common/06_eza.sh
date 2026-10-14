#!/bin/bash
source "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../lib" && pwd)/platform.sh"
require_user
# scripts/common/05_eza.sh


echo "Instalando Eza ..."

install_packages eza

echo "Eza instalado com sucesso. Use o comando 'eza'."
