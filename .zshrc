
############################################################################
# ZSH
############################################################################

plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
)
plugins+=(zsh-vi-mode)


source $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh


fpath+=${ZDOTDIR:-~}/.zsh_functions

zstyle ':omz:update' mode disabled


############################################################################
# Export PATH and envs
############################################################################

[ -f "$HOME/.envs" ] && source $HOME/.envs


############################################################################
# CLI tools
############################################################################

# Terminal history (atuin)
eval "$(atuin init zsh)"

# Terminal cd
eval "$(zoxide init zsh)"


############################################################################
# Functions
############################################################################

[ -f "$HOME/.functions" ] && source $HOME/.functions

############################################################################
# Aliases
############################################################################

[ -f "$HOME/.aliases" ] && source $HOME/.aliases

############################################################################
# Load Secrets
############################################################################

[ -f "$HOME/.secrets" ] && source "$HOME/.secrets"


eval "$(starship init zsh)"


# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# bun completions
[ -s "/home/rjouhameau/.bun/_bun" ] && source "/home/rjouhameau/.bun/_bun"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
