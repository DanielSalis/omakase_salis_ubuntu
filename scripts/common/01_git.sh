#!/bin/bash
source "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../lib" && pwd)/platform.sh"
require_user
# scripts/common/01_git.sh

echo "Instalando Git..."
install_packages git
echo "Git instalado."