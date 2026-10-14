#!/usr/bin/env bash
source "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../lib" && pwd)/platform.sh"
require_user

echo "Instalando Visual Studio Code..."
if [[ "$DISTRO" == ubuntu ]]; then
    install_packages curl gpg
    temp_dir=$(mktemp -d)
    trap 'rm -rf "$temp_dir"' EXIT
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc -o "$temp_dir/microsoft.asc"
    gpg --batch --dearmor -o "$temp_dir/microsoft.gpg" "$temp_dir/microsoft.asc"
    sudo install -D -m 644 "$temp_dir/microsoft.gpg" /etc/apt/keyrings/packages.microsoft.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
else
    install_packages curl
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo tee /etc/yum.repos.d/vscode.repo >/dev/null <<'EOF'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
fi
install_packages code
echo "Visual Studio Code instalado."
