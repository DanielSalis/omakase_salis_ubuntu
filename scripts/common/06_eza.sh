#!/bin/bash
# scripts/common/05_eza.sh

set -e

echo "Instalando Eza (via repositório de terceiros)..."

sudo apt update
sudo apt install -y eza

echo "Eza instalado com sucesso. Use o comando 'eza'."
