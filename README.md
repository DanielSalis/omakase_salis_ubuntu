🚀 Developer Setup
Este projeto oferece um conjunto de scripts modulares e interativos projetados para automatizar e personalizar seu ambiente de desenvolvimento em distribuições Linux baseadas em Debian (como Ubuntu). A meta é configurar um ambiente moderno, com ferramentas essenciais e um visual agradável, com o mínimo de esforço manual.

✨ Recursos Principais
Instalação Interativa: Utiliza a ferramenta gum para criar menus de seleção (multiselect) para que você escolha quais ferramentas e configurações deseja instalar ou aplicar.

Estilização e UX: Uso de spinners e logs coloridos para fornecer feedback claro durante a execução dos scripts.

Ferramentas Essenciais: Configuração de utilitários cruciais para o desenvolvimento moderno (Git, Docker, ASDF, etc.).

Terminal Otimizado: Instalação de fontes Nerd Fonts e configuração do prompt Starship para um terminal minimalista e rápido.

Configurações de UI (Opcional): Modificações na interface gráfica (GNOME) como tema escuro, dock otimizada (posição e auto-hide), e atalhos de teclado personalizados (Ex: Super+Return para abrir o terminal).

📂 Estrutura do Projeto
A lógica de automação está dividida em diretórios claros para facilitar a manutenção e a modularidade:

.
├── fonts/
│   └── nerd_font.sh          # Instala fontes (Obrigatório, essencial para o terminal).
├── install.sh                # Script principal de orquestração e interação (usa gum).
├── README.md                 # Este arquivo.
├── scripts/
│   ├── common/               # Ferramentas de desenvolvimento (Selecionável).
│   │   ├── 01_git.sh         # Instala e configura o Git.
│   │   ├── 02_asdf.sh        # Instala ASDF (gerenciador de versões).
│   │   ├── 03_alacritty.sh   # Instala e configura o Alacritty.
│   │   ├── 04_docker.sh      # Instala Docker.
│   │   ├── 05_vscode.sh      # Instala o VS Code.
│   │   └── 06_eza.sh         # Instala Eza (alternativa ao ls).
│   └── configs/              # Configurações de aplicações (Selecionável).
│       ├── bash_aliases.sh   # Configura aliases de Bash.
│       └── vscode_config.sh  # Configurações de tema e fonte para o VS Code.
└── system/                   # Configurações de UI e Shell (Opcional).
    ├── gnome.sh              # Aplica configurações do GNOME (Dock, Atalhos, Tema).
    └── starship.sh           # Instala e configura o Starship prompt.
🛠️ Guia de Uso
1. Clonar o Repositório
Abra seu terminal e clone o projeto (substitua pelo seu caminho real):

Bash

git clone SEU_LINK_DO_REPOSITÓRIO
cd SEU_PROJETO
2. Executar o Instalador
O script install.sh gerencia automaticamente a instalação do gum (necessário para a interface interativa) e inicia o fluxo de configuração.

É crucial executar com bash:

Bash
`sudo chmod +x install.sh`
`bash install.sh`

3. Interação
O script guiará você por três etapas principais:

Etapa 1: Instalações Essenciais (scripts/common/)

Você será apresentado a um menu interativo onde pode selecionar quais ferramentas deseja instalar (ex: Docker, Alacritty). Use ESPAÇO para selecionar/desselecionar e ENTER para confirmar.

Etapa 2: Configurações de Aplicativos (scripts/configs/)

Outro menu interativo para selecionar quais configurações deseja aplicar (ex: Aliases do Bash, Configurações do VS Code).

Etapa 3: Modificações de Sistema (system/)

Uma confirmação interativa perguntará se você deseja aplicar as modificações de UI do sistema (GNOME).

📝 Ações Pós-Instalação
Após a conclusão bem-sucedida do script, algumas ações manuais podem ser necessárias para que todas as mudanças entrem em vigor:

Novas Permissões (Docker): Saia e entre novamente (ou use newgrp docker) para aplicar as permissões de usuário do Docker.

Configurações do Shell: Execute source ~/.bashrc em um novo terminal para carregar imediatamente os novos aliases e o prompt Starship.

GNOME UI: Para que todas as modificações de tema, dock e atalhos do GNOME entrem em vigor, um logout e login podem ser necessários.