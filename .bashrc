# *********************************************
# * ~/.bashrc Personalizado para Ubuntu       *
# * System: Linux Mint 21.2 Uma Cinnamon      *
# * local: /home/user/.bashrc                 *
# *                                           *
# * Author: Starley Cazorla                   *
# * E-Mail: starlleycom@gmail.com             *
# * Date:  18/06/2026                         *
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

# Otimização dinâmica: Recalcula o IP e a Data a cada execução de comando
IP='$(hostname -I | awk "{print \$1}")'
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
# SOME CONFIGS
#==========================

alias terminalUpdate='sudo cp ~/.bashrc /root/.bashrc'

## Instalação de outros ## sudo apt install android-tools-adb android-tools-fastboot
alias installRemmina='toInstall remmina'

## NGrok - Localhost na Web

# Modificando torrent Download
alias torrentStremio='xdg-mime default smartcode-stremio.desktop x-scheme-handler/magnet'
alias torrentQbit='xdg-mime default qbittorrent.desktop x-scheme-handler/magnet'

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

# Listar todos os arquivos
alias ll='ls -la'

# Abrir Gsmartcontrol
alias statushd='sudo gsmartcontrol'

# Get list of java
alias getJavaList='update-java-alternatives -l'

# Alterar versao java
alias changeJava='sudo update-alternatives --config java'

# Alterar versao javac
alias changeJavac='sudo update-alternatives --config javac'

# Altera JAVA_HOME
alias setJavaHome='source selectJavaHome.sh'

# Show pwd current wifi
alias showPwdWifi='nmcli device wifi show-password'

# Backup timeshift
alias bk-sys='sudo timeshift-autosnap-apt'

#==========================
# RUN MACOS - Hakintosh
#==========================

alias runMac='cd /media/starley/ThisIsTheWay/MyDriver/S.O/MAC_Ventura/OSX-KVM/ && sudo ./OpenCore-Boot.sh'

#==========================
# CREATE CERT NGINX
#==========================

# Add your email and -d your site
alias newCertbotNginx='sudo certbot --nginx --agree-tos --redirect --hsts --staple-ocsp --email'

#alias renewCertbotAutNginx='echo "0 0 * * *  root  certbot renew --quiet --no-self-upgrade --post-hook 'systemctl reload nginx'" | 'sudo tee -a /etc/cron.d/renew_certbot''

# Add your email and -d your site
alias newCertbotApache='certbot certonly --apache --noninteractive --agree-tos --email'

#alias renewCertbotAutApache='echo "0 0 * * *  root  certbot renew --quiet --no-self-upgrade --post-hook 'systemctl reload apache2'" | 'sudo tee -a /etc/cron.d/renew_certbot''

#==========================
# INSTALAÇÕES
#==========================

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

## Instalação do Ionic Cordova
alias installIonicCordova='npm i -g @ionic/cli cordova'

## Instalação do samba e compartilhamento
alias sambaInstall='toInstall gnome-user-share -y && toInstall samba nautilus-share -y && sudo gpasswd -a $USER sambashare'

#==========================
# CORREÇOES DO LINUX
#==========================

alias reloadWifi='sudo systemctl restart network-manager.service && sudo systemctl restart networking.service'

alias fixNpmPermissions='sudo chown -R `whoami` /usr/local'

#==========================
# REDIS - SERVER
#==========================

alias redisStop='sudo service redis-server stop'
alias redisStart='redis-server'

alias sharedPython='python3 -m http.server'

#==============================================
# Aliases para uso Ionic
#==============================================

# Apaga e adiciona o app ao celular
alias irun='ionic cordova run android'

# Cria a versao de teste Cordova
alias icreate='ionic cordova build android'

# Cria a versao de teste Capacitor
alias icapacitorRun='ionic capacitor copy android && cd android && ./gradlew assembleDebug && ./gradlew installDebug && cd ..'

# Cria a versao de teste Capacitor
alias icaprun='npm run build && npx cap copy android && npx cap open android '

# Cria a versao de distribuição
alias ibuild='ionic cordova build android --prod --release'

# Inicia via web
alias iserve='ionic serve --host=0.0.0.0'

# Gerando keytool
alias keytool='keytool -genkey -v -keystore'
alias keytool1='-keyalg RSA -keysize 2048 -validity 100000 -alias'

# Assinado App
alias assinandoapp='jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore'

# Gerando App
alias zipandoapp='zipalign -v 4'

#==============================================
# Aliases para gerenciar instalacao tools Android
#==============================================

# Instalando versao 29 caso de atualização modificar essa linha // Atualizado 10/03/2020
alias sdkinstall29='sdkmanager --sdk_root=/home/starley/Android "platform-tools" "platforms;android-29" "build-tools;29.0.3" "extras;android;m2repository"'
alias sdkinstall30='sdkmanager --sdk_root=/home/starley/Android "platform-tools" "platforms;android-30" "build-tools;30.0.3" "extras;android;m2repository"'
alias sdkinstall33='sdkmanager --sdk_root=/home/starley/Android "platform-tools" "platforms;android-33" "build-tools;33.0.2" "extras;android;m2repository"'
alias sdkinstall34='sdkmanager --sdk_root=/home/starley/Android "platform-tools" "platforms;android-34" "build-tools;34.0.0" "extras;android;m2repository"'

# Gradle Java Heap
alias gradleHeapJavaFix='mkdir -p ~/.gradle && echo "org.gradle.daemon=false" >> ~/.gradle/gradle.properties'

#==============================================
# Variaveis de ambiente desenvolvimento android
#==============================================
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export ANDROID_HOME="$HOME/Android"
export ANDROID_SDK_ROOT="$HOME/Android"
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/cmdline-tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/33.0.2:$ANDROID_HOME/gradle/bin

export CAPACITOR_ANDROID_STUDIO_PATH="$HOME/android-studio/bin/studio.sh"

export EXE4J_JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/bin

export PATH=$PATH:/usr/local/bin/toSnode
export PATH=$PATH:/usr/local/bin/toServer

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

PATH=~/.console-ninja/.bin:$PATH

# Created by `pipx` on 2025-11-16 01:04:17
export PATH="$PATH:/home/starley/.local/bin"
export EDITOR=gedit
#export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
