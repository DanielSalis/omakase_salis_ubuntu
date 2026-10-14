#!/usr/bin/env bash
source "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../lib" && pwd)/platform.sh"
require_user

install_packages curl
if [[ "$DISTRO" == ubuntu ]]; then
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc >/dev/null
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $VERSION_CODENAME stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
else
    # Arquivo .repo funciona com DNF 4 e DNF 5.
    curl -fsSL https://download.docker.com/linux/fedora/docker-ce.repo | sudo tee /etc/yum.repos.d/docker-ce.repo >/dev/null
fi
install_packages docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
sudo usermod -aG docker "$(id -un)"
sudo mkdir -p /etc/docker
if [[ ! -e /etc/docker/daemon.json ]]; then
    echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json >/dev/null
fi
sudo systemctl enable --now docker

temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT
case "$(uname -m)" in
    x86_64) arch=x86_64 ;;
    aarch64) arch=arm64 ;;
    *) echo "Lazydocker: arquitetura não suportada." >&2; exit 1 ;;
esac
install_packages python3
version=$(curl -fsSL https://api.github.com/repos/jesseduffield/lazydocker/releases/latest | python3 -c 'import json,sys; print(json.load(sys.stdin)["tag_name"].removeprefix("v"))')
curl -fsSL "https://github.com/jesseduffield/lazydocker/releases/download/v${version}/lazydocker_${version}_Linux_${arch}.tar.gz" -o "$temp_dir/lazydocker.tar.gz"
tar -xzf "$temp_dir/lazydocker.tar.gz" -C "$temp_dir" lazydocker
sudo install -m 755 "$temp_dir/lazydocker" /usr/local/bin/lazydocker
