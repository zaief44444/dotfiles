# Created by newuser for 5.8
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit load zdharma-continuum/history-search-multi-word
case ${OSTYPE} in 
  darwin*)
    source /usr/local/etc/profile.d/z.sh
    ;;
  linux*)
    source /usr/share/z/z.sh
    ;;
esac

case ${OSTYPE} in 
  darwin*)
    export PATH=/usr/local/opt/llvm/bin:$PATH
    export GOPATH=$HOME/go
    export GOBIN=$GOPATH/bin
    export PATH=$GOBIN:$PATH
    GO111MODULE=on
    ;;
  linux*)
    export PATH=$HOME/.local/bin:$PATH
    export GOPATH=/usr/local/gocode/
    export GOBIN=$GOPATH/bin
    export PATH=$PATH:$GOBIN
    ;;
esac

export CPATH=$CPATH:$HOME/include
export LIBRARY_PATH=$LIBRARY_PATH:$HOME/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/lib

alias ll="ls -al"
setopt autocd

function osx-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
function unix-history-selection() {
    BUFFER=`history -n 1 | tail  | awk '!a[$0]++' | fzf`
    CURSOR=$#BUFFER
    zle reset-prompt
}


case ${OSTYPE} in 
  darwin*)
    zle -N osx-history-selection
    bindkey '^R' osx-history-selection
    ;;
  linux*)
    zle -N unix-history-selection
    bindkey '^R' unix-history-selection
    ;;
esac


function gadd() {
    local selected
    selected=$(unbuffer git status -s | fzf -m --ansi --preview="echo {} | awk '{print \$2}' | xargs git diff --color" | awk '{print $2}')
    if [[ -n "$selected" ]]; then
        #selected=$(tr '\n' ' ' <<< "$selected" | sed -e 's/[[:space:]]*$/\'$'\n/')
        selected=$(tr '\n' ' ' <<< "$selected" | sed -e 's/[[:space:]]*$//') 
        git add $selected
        echo "Completed: git add $selected"
    fi
}

# cd by history
function cdd() {
  local res=$(z | sort -rn | cut -c 12- | fzf)
  if [ -n "$res" ]; then
    cd $res
  else
    return 1
  fi
}



function fancy-ctrl-z() {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# go get needs this GIT_TERMINAL_PROMPT=1
export GIT_TERMINAL_PROMPT=1
