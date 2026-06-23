# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# IMPORTANTE: Desativa o tema padrão do Oh My Zsh para não sobrepor o seu prompt personalizado
ZSH_THEME=""

plugins=(git)

source $ZSH/oh-my-zsh.sh

# *********************************************
# * ~/.zsh Personalizado para MAC             *
# * System: MacOs Sonoma 14.3                 *
# * local: /home/user/.zshrc                  *
# * *
# * Author: Starley Cazorla                   *
# * E-Mail: starlleycom@gmail.com             *
# * Date:  23/06/2026                         *
# *********************************************
#-----------------------------------------------
# Configurações Gerais e Prompt Dinâmico
#-----------------------------------------------

# Habilita a reavaliação dinâmica de variáveis no prompt do Zsh
setopt PROMPT_SUBST

# Reset color e efeitos
NONE="%f%k%b"

## Cores de Fonte
K="%F{black}"
R="%F{red}"
G="%F{green}"
Y="%F{yellow}"
B="%F{blue}"
M="%F{magenta}"
C="%F{cyan}"
W="%F{white}"

## Efeito Negrito (bold) e cores
BK="%B%F{black}"
BR="%B%F{red}"
BG="%B%F{green}"
BY="%B%F{yellow}"
BB="%B%F{blue}"
BM="%B%F{magenta}"
BC="%B%F{cyan}"
BW="%B%F{white}"

## Cores de fundo (background)
BGK="%K{black}"
BGR="%K{red}"
BGG="%K{green}"
BGY="%K{yellow}"
BGB="%K{blue}"
BGM="%K{magenta}"
BGC="%K{cyan}"
BGW="%K{white}"

# Função nativa para recalcular o IP e data a cada execução de comando no Zsh
update_prompt_elements() {
    # Coleta o IP local com segurança no macOS (en0)
    IP=$(ipconfig getifaddr en0 2>/dev/null)
    [ -z "$IP" ] && IP="127.0.0.1"

    DATE_TIME=$(date "+%d/%m/%Y %H:%M:%S")

    # Tratamento dinâmico de Containers e Usuário
    if [ -n "$CONTAINER_ID" ]; then
        [ "$CONTAINER_ID" = "herolink" ] && IDENTIFIER="${BG}[herolink]" || IDENTIFIER="${BC}[$CONTAINER_ID]"
        ICON="🟡${IDENTIFIER}🟡${NONE}"
        USER_ICON="🐳"
    else
        ICON="🚧"
        [ "$UID" -eq 0 ] && USER_ICON="😎" || USER_ICON="🤓"
    fi
}

# Registra o gancho de execução no ciclo de vida do Zsh
autoload -Uz add-zsh-hook
add-zsh-hook precmd update_prompt_elements

# Estrutura do Prompt (%n = usuário, %m = host, %~ = diretório com ~)
PROMPT_HEADER='${NONE}╭─╼ ${ICON}${G}[${BR}%n${G}]${BY}${USER_ICON}${G}[${BY}%m${G}]${NONE}[${W}%~${NONE}]'
PROMPT_FOOTER='${NONE}┊─╼ ${G}[${C}${IP}${G}]-${G}[${M}${DATE_TIME}${G}]'

# Atribuição multiline direta para correta renderização das quebras de linha
PROMPT="${PROMPT_HEADER}
${PROMPT_FOOTER}
${NONE}╰─╼ "

# Suporte a cores no ls para macOS / BSD Linux alternativo
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34:cd=34:su=30:sg=30:tw=34:ow=34'
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Listar todos os arquivos
alias ll='ls -la'

alias sharedPython='python3 -m http.server'
