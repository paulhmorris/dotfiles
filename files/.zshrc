

# zsh Performance optimizations
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

# Automatically cd into dirs
setopt AUTO_CD

# zsh plugin settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=238"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_STRATEGY=(
    history
    completion
)

# Optimized Completions (Only rebuild cache once a day)
autoload -Uz compinit
setopt EXTENDED_GLOB
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit -d ${ZDOTDIR:-$HOME}/.zcompdump
else
  compinit -C
fi
unsetopt EXTENDED_GLOB

# Initialize zsh plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Initialize aliases
source ~/.aliases

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[[0A' history-search-backward
bindkey '^[[0B' history-search-backward

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

_set_tab_title() {
  echo -ne "\033]0;${PWD##*/}\033\\"
}
precmd_functions+=(_set_tab_title)

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Homebrew
export PATH=/opt/homebrew/bin:$PATH
export HOMEBREW_NO_ENV_HINTS=1

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# npm
export DISABLE_OPENCOLLECTIVE=1
export ADBLOCK=1

# Starship
eval "$(starship init zsh)"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/paul/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"
export PATH="$HOME/.local/bin:$PATH"
