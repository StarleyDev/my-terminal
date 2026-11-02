# *********************************************
# * ~/.bashrc Personalizado                   *
# * Systems: Linux Mint 22.3 Cinnamon (Debian)*
# *          CachyOS KDE Plasma (Arch)        *
# * local: /home/user/.bashrc                 *
# *                                           *
# * Author: Starley Cazorla                   *
# * E-Mail: starlleycom@gmail.com             *
# * Date:  02/11/2026                         *
# *********************************************
# ======================================================================
# Readaptado do original de Thiago Nalli Valentim
# Email - thiago.nalli@gmail.com
# ======================================================================
#-----------------------------------------------
# Configurações Gerais
#-----------------------------------------------

# Se não estiver rodando interativamente, não fazer nada
[ -z "$PS1" ] && return

# Não armazenar as linhas duplicadas ou linhas que começam com espaço no historico
HISTCONTROL=ignoreboth

# Adicionar ao Historico e não substitui-lo
shopt -s histappend

# Definições do comprimento e tamnho do historico.
HISTSIZE=1000
HISTFILESIZE=2000

#===========================================
# Distro detection (Debian family vs Arch family)
#===========================================
# Reads ID and ID_LIKE from /etc/os-release in a subshell to avoid leaking its variables.
# Mint -> "linuxmint ubuntu debian" | CachyOS -> "cachyos arch"
DISTRO_FAMILY="unknown"
if [ -r /etc/os-release ]; then
    OS_TAGS=" $(. /etc/os-release && echo "$ID $ID_LIKE") "
    case "$OS_TAGS" in
        *" arch "*) DISTRO_FAMILY="arch" ;;
        *" debian "* | *" ubuntu "*) DISTRO_FAMILY="debian" ;;
    esac
    unset OS_TAGS
fi

# Returns the first existing directory among the arguments
first_existing_dir() {
    local candidate
    for candidate in "$@"; do
        [ -d "$candidate" ] && echo "$candidate" && return 0
    done
    return 1
}

#===========================================
# Váriavies com as Cores
#===========================================
NONE="\[\033[0m\]" # Eliminar as Cores, deixar padrão)

## Cores de Fonte
K="\[\033[0;30m\]" # Black (Preto)
R="\[\033[0;31m\]" # Red (Vermelho)
G="\[\033[0;32m\]" # Green (Verde)
Y="\[\033[0;33m\]" # Yellow (Amarelo)
B="\[\033[0;34m\]" # Blue (Azul)
M="\[\033[0;35m\]" # Magenta (Vermelho Claro)
C="\[\033[0;36m\]" # Cyan (Ciano - Azul Claro)
W="\[\033[0;37m\]" # White (Branco)

## Efeito Negrito (bold) e cores
BK="\[\033[1;30m\]" # Bold+Black (Negrito+Preto)
BR="\[\033[1;31m\]" # Bold+Red (Negrito+Vermelho)
BG="\[\033[1;32m\]" # Bold+Green (Negrito+Verde)
BY="\[\033[1;33m\]" # Bold+Yellow (Negrito+Amarelo)
BB="\[\033[1;34m\]" # Bold+Blue (Negrito+Azul)
BM="\[\033[1;35m\]" # Bold+Magenta (Negrito+Vermelho Claro)
BC="\[\033[1;36m\]" # Bold+Cyan (Negrito+Ciano - Azul Claro)
BW="\[\033[1;37m\]" # Bold+White (Negrito+Branco)

## Cores de fundo (backgroud)
BGK="\[\033[40m\]" # Black (Preto)
BGR="\[\033[41m\]" # Red (Vermelho)
BGG="\[\033[42m\]" # Green (Verde)
BGY="\[\033[43m\]" # Yellow (Amarelo)
BGB="\[\033[44m\]" # Blue (Azul)
BGM="\[\033[45m\]" # Magenta (Vermelho Claro)
BGC="\[\033[46m\]" # Cyan (Ciano - Azul Claro)
BGW="\[\033[47m\]" # White (Branco)

#=============================================
# Configurações referentes ao usuário
#=============================================

# Primary LAN IP (source address of the default route).
# Portable replacement for `hostname -I`, which Arch's inetutils hostname does not support.
local_ip() {
    ip -4 route get 1.1.1.1 2>/dev/null | awk '{for (i = 1; i < NF; i++) if ($i == "src") { print $(i + 1); exit }}'
}

# Otimização dinâmica: Recalcula o IP e a Data a cada execução de comando
IP='$(local_ip)'
DATE_TIME='$(date "+%d/%m/%Y %H:%M:%S")'

# Aplicação do princípio DRY para isolar a lógica de variáveis do esqueleto do PS1
if [ -n "$CONTAINER_ID" ]; then
    [ "$CONTAINER_ID" = "herolink" ] && IDENTIFIER="${BG}[herolink]" || IDENTIFIER="${BC}[$CONTAINER_ID]"
    ICON="🟡${IDENTIFIER}🟡"
    USER_ICON="🐳"
else
    ICON="🚧"
    [ $UID -eq 0 ] && USER_ICON="😎" || USER_ICON="🤓"
fi

# Estrutura unificada avaliada dinamicamente por linha de comando
PROMPT_HEADER="$NONE╭─╼ ${ICON}$G[$BR\u$G]$BY${USER_ICON}$G[$BY\h$G]$NONE[$W\w$NONE]"
PROMPT_FOOTER="$NONE┊─╼ $G[$C${IP}$G]-$G[$M${DATE_TIME}$G]\n$NONE╰─╼ "

PS1="${PROMPT_HEADER}\n${PROMPT_FOOTER}"

#==========================
# DIVERSOS
#==========================

## Habilitando suporte a cores para o ls e outros aliases
## Vê se o arquivo existe
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

  LS_COLORS=di=34:ln=35:so=32:pi=33:ex=31:bd=34:cd=34:su=30:sg=30:tw=34:ow=34
  ## Aliases (apelidos) para comandos
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi # Fim do if do dircolor

## Aliases (apelidos) diversos

#==========================
# SOME CONFIGS (shared)
#==========================

alias terminalUpdate='sudo cp ~/.bashrc /root/.bashrc'

# Listar todos os arquivos
alias ll='ls -lhat'

# Abrir Gsmartcontrol
alias statushd='sudo gsmartcontrol'

# Altera JAVA_HOME
alias setJavaHome='source selectJavaHome.sh'

# Show pwd current wifi
alias showPwdWifi='nmcli device wifi show-password'

alias sharedPython='python3 -m http.server'

#==========================
# DEBIAN FAMILY (Mint / Ubuntu)
#==========================
if [ "$DISTRO_FAMILY" = "debian" ]; then

    # Editar sources.list
    alias editSourcelist='sudo nano /etc/apt/sources.list'

    # atualizar o apt
    alias systemUpdate='sudo apt update && sudo apt upgrade -y'

    # instalar aplicacoes
    alias toInstall='sudo apt install'

    # desinstalar aplicacoes
    alias toRemove='sudo apt remove'

    # remover tudo
    alias toRemoveAll='sudo apt remove --purge'

    # Remover Lixo
    alias toTrash='sudo apt autoremove'

    # Reparar o apt
    alias aptRepair='sudo apt -f install'

    # Reparar o dpkg
    alias dpkgRepair='sudo dpkg --configure -a'

    # Instalar Repositorios
    alias addRepo='sudo add-apt-repository'

    # Get list of java
    alias getJavaList='update-java-alternatives -l'

    # Alterar versao java
    alias changeJava='sudo update-alternatives --config java'

    # Alterar versao javac
    alias changeJavac='sudo update-alternatives --config javac'

    # Backup timeshift
    alias bk-sys='sudo timeshift-autosnap-apt'

    # Corrige instalação Stremio
    alias fixStremio='wget http://archive.ubuntu.com/ubuntu/pool/universe/x/x264/libx264-152_0.152.2854+gite9a5903-2_amd64.deb && sudo dpkg -i libx264-152_0.152.2854+gite9a5903-2_amd64.deb'

    ## Instalação de AndroidTools ##
    alias adbToolsInstall='toInstall android-tools-adb android-tools-fastboot'

    ## Instalação do OBS Studio
    alias obsInstall='toInstall ffmpeg -y && sudo add-apt-repository ppa:obsproject/obs-studio -y && updateSystem && toInstall obs-studio'

    ## Instalação do SNAP
    alias snapInstall='sudo rm /etc/apt/preferences.d/nosnap.pref && updateSystem && toInstall snapd'

    ## Instalação do FlameShot
    alias installFlameshot='sudo snapd install flameshot'

    ## Instalação do WoeUsb
    alias woeusbInstall='toInstall git p7zip-full python3-pip python3-wxgtk4.0 -y && sudo pip3 install woeusb-ng'

    ## Instalação MySql Comunity
    alias installMysql='sudo apt-get install mysql-server and mysql-community-server'

    ## Instalação do samba e compartilhamento
    alias sambaInstall='toInstall gnome-user-share -y && toInstall samba nautilus-share -y && sudo gpasswd -a $USER sambashare'

    alias reloadWifi='sudo systemctl restart network-manager.service && sudo systemctl restart networking.service'

    alias fixNpmPermissions='sudo chown -R `whoami` /usr/local'

    alias redisStop='sudo service redis-server stop'
    alias redisStart='redis-server'

fi

#==========================
# ARCH FAMILY (CachyOS / Arch)
#==========================
if [ "$DISTRO_FAMILY" = "arch" ]; then

    # Same alias names as the Debian block, mapped to pacman
    alias editSourcelist='sudo nano /etc/pacman.d/mirrorlist'
    alias editPacmanConf='sudo nano /etc/pacman.conf'

    alias systemUpdate='sudo pacman -Syu'
    alias toInstall='sudo pacman -S --needed'
    alias toRemove='sudo pacman -R'
    alias toRemoveAll='sudo pacman -Rns'

    # Removes orphan packages; pacman -Qtdq exits non-zero when there are none.
    # The `function` keyword prevents alias expansion of the name at parse time.
    unalias toTrash 2>/dev/null
    function toTrash() {
        local orphans
        orphans=$(pacman -Qtdq) || { echo "No orphan packages."; return 0; }
        sudo pacman -Rns $orphans
    }

    # Clears the package cache, keeping the 2 latest versions (requires pacman-contrib)
    alias cacheClean='sudo paccache -rk2'

    # Java (archlinux-java switches java and javac together)
    alias getJavaList='archlinux-java status'
    alias changeJava='sudo archlinux-java set'
    alias changeJavac='sudo archlinux-java set'

    # Manual Timeshift snapshot
    alias bk-sys='sudo timeshift --create --comments "manual"'

    alias adbToolsInstall='toInstall android-tools'
    alias obsInstall='toInstall obs-studio'
    alias installFlameshot='toInstall flameshot'
    alias sambaInstall='toInstall samba'

    alias reloadWifi='sudo systemctl restart NetworkManager.service'

    # Arch ships Valkey (Redis-compatible) in the official repos
    alias redisStop='sudo systemctl stop valkey'
    alias redisStart='sudo systemctl start valkey'

fi

#==============================================
# Variaveis de ambiente desenvolvimento android
#==============================================
# Debian names JVM dirs with an arch suffix (-amd64); Arch does not
JAVA_HOME_CANDIDATE=$(first_existing_dir /usr/lib/jvm/java-21-openjdk-amd64 /usr/lib/jvm/java-21-openjdk) && export JAVA_HOME="$JAVA_HOME_CANDIDATE"
EXE4J_CANDIDATE=$(first_existing_dir /usr/lib/jvm/java-17-openjdk-amd64 /usr/lib/jvm/java-17-openjdk) && export EXE4J_JAVA_HOME="$EXE4J_CANDIDATE/bin"
unset JAVA_HOME_CANDIDATE EXE4J_CANDIDATE

export ANDROID_HOME="$HOME/Android"
export ANDROID_SDK_ROOT="$HOME/Android"
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/cmdline-tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/33.0.2:$ANDROID_HOME/gradle/bin

export CAPACITOR_ANDROID_STUDIO_PATH="$HOME/android-studio/bin/studio.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

PATH=~/.console-ninja/.bin:$PATH

export OLLAMA_HOST=0.0.0.0:11434
