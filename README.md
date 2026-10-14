# General Omakase

Setup modular para **Ubuntu e Fedora**, com detecção automática por `/etc/os-release` e instalação via APT ou DNF. Outras distribuições são rejeitadas antes de alterar o sistema. Use uma versão mantida da distribuição com os pacotes disponíveis nos seus repositórios.

Execute como seu usuário normal; os módulos usam `sudo` para instalar pacotes. Não execute `sudo bash install.sh`, pois as configurações pertencem ao seu usuário.

```bash
bash install.sh
```

O instalador prepara o Gum quando necessário e oferece seleção individual de fontes, ferramentas, configurações e ajustes de sistema. Use Espaço para selecionar e Enter para confirmar; Ctrl+C cancela. Nenhum módulo é obrigatório.

Para listar ou executar somente o que desejar, sem instalar Gum:

```bash
bash install.sh --list
bash install.sh scripts/common/05_vscode.sh
bash install.sh scripts/common/01_git.sh scripts/common/04_docker.sh
bash install.sh fonts/nerd_font.sh system/starship.sh
```

Os módulos também podem ser executados diretamente, de qualquer diretório:

```bash
bash /caminho/general_omakase/scripts/common/05_vscode.sh
```

| Módulo | Ação |
| --- | --- |
| `fonts/nerd_font.sh` | FiraCode Nerd Font no usuário |
| `scripts/common/01_git.sh` | Git |
| `scripts/common/02_asdf.sh` | ASDF v0.14.0 e dependências de compilação; inicialização no Bash |
| `scripts/common/03_alacritty.sh` | Alacritty e configuração de fonte/cores |
| `scripts/common/04_docker.sh` | Docker Engine, plugins Compose/Buildx e Lazydocker |
| `scripts/common/05_vscode.sh` | Apenas instalação do VS Code, sem extensões ou configurações |
| `scripts/common/06_eza.sh` | Eza |
| `scripts/configs/bash_aliases.sh` | Aliases para Eza no Bash; instale Eza antes |
| `system/starship.sh` | Starship e inicialização no Bash |
| `system/gnome.sh` | Tema escuro e dock, se Dash to Dock estiver disponível |
| `system/custom_shortcuts.sh` | Atalhos de espaços de trabalho e terminais |

O Fedora usa pacotes nativos para as ferramentas comuns e os repositórios oficiais RPM da Microsoft e Docker. O Ubuntu usa os repositórios APT correspondentes. Downloads do Gum e Lazydocker contemplam x86_64 e aarch64. O ASDF mantém a versão do setup Ubuntu original.

Ajustes de interface exigem uma sessão GNOME. No Fedora, a ausência de Dash to Dock apenas pula os ajustes da dock; nenhuma extensão é instalada automaticamente. Os atalhos usam `gnome-terminal` (Ctrl+Enter) e `alacritty` (Super+Enter); instale os terminais que pretende usar. O módulo de atalhos substitui a lista de atalhos personalizados e o Alacritty sobrescreve seu arquivo de configuração.

Docker é habilitado e iniciado; o usuário entra no grupo `docker`. A configuração de limites de logs é criada somente quando não existe `daemon.json`. Conflitos com pacotes Docker/Podman já instalados precisam ser resolvidos antes de instalar Docker CE. Saia e entre novamente para aplicar a associação ao grupo.

Abra um novo terminal para carregar ASDF, aliases e Starship. A remoção do módulo de configuração do VS Code não desfaz personalizações aplicadas por execuções antigas.

Referências: [Docker no Fedora](https://docs.docker.com/engine/install/fedora/) e [VS Code no Linux](https://code.visualstudio.com/docs/setup/linux).
