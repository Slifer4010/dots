# Fix the Java Problem
export _JAVA_AWT_WM_NONREPARENTING=1

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up the prompt
autoload -Uz promptinit
promptinit
prompt fade
setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Custom PATH
export PATH="$PATH:$HOME/.local/bin"

# Fix the ssh problem
export TERM=xterm-256color

# uv autocompletion
if [[ $EUID -ne 0 ]]; then
  eval "$(uv generate-shell-completion zsh)"
fi

# Manual aliases
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias cat='batcat'
alias icat='kitty +kitten icat'
alias update='sudo apt update && sudo apt upgrade'
alias ..='cd ..'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Plugins
source "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "/usr/share/zsh-sudo/sudo.plugin.zsh"

# Functions
# fzf improvement
function fzf-lovely(){

  if [ "$1" = "h" ]; then
    fzf -m --reverse --preview-window down:20 --preview '[[ $(file --mime {}) =~ binary ]] &&
 	                echo {} is a binary file ||
	                 (bat --style=numbers --color=always {} ||
	                  highlight -O ansi -l {} ||
	                  coderay {} ||
	                  rougify {} ||
    cat {}) 2> /dev/null | head -500'

  else
    fzf -m --preview '[[ $(file --mime {}) =~ binary ]] &&
	                         echo {} is a binary file ||
	                         (bat --style=numbers --color=always {} ||
	                          highlight -O ansi -l {} ||
	                          coderay {} ||
	                          rougify {} ||
    cat {}) 2> /dev/null | head -500'
  fi
}

# Project explorer
function explorar() {
  CURRENT_DIR="$HOME/Projects"

  while true; do
    clear

    SELECCION=$(ls -A "$CURRENT_DIR" | fzf \
      --height=70% \
      --layout=reverse \
      --border=rounded \
      --info=inline \
      --prompt="Explorador > " \
      --preview "bat --style=numbers --color=always --line-range=:100 $CURRENT_DIR/{} 2>/dev/null || ls -l $CURRENT_DIR/{}" \
      --preview-window=right:50%:wrap)

    if [[ -z "$SELECCION" ]]; then
      break
    fi

    SELECCION_PATH="$CURRENT_DIR/$SELECCION"

    if [ -d "$SELECCION_PATH" ]; then
      CURRENT_DIR="$SELECCION_PATH"
    elif [ -f "$SELECCION_PATH" ]; then
      nvim "$SELECCION_PATH"
      cd "$(dirname "$SELECCION_PATH")" || return
      return
    fi
  done
}

#Bindkey
bindkey -s "^P" "explorar\n"
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# Finalize Powerlevel10k instant prompt. Should stay at the bottom of ~/.zshrc.
(( ! ${+functions[p10k-instant-prompt-finalize]} )) || p10k-instant-prompt-finalize

source ~/powerlevel10k/powerlevel10k.zsh-theme
