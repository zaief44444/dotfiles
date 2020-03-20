export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/binutils/bin:$PATH"
alias ctags="`brew --prefix`/bin/ctags"
# zpl
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "BurntSushi/ripgrep", as:command, from:gh-r, rename-to:rg
zplug mafredri/zsh-async, from:github
zplug  sindresorhus/pure, use:pure.zsh, from:github, as:theme
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi
# Then, source plugins and add commands to $PATH
zplug load


export PATH="/usr/local/opt/ncurses/bin:$PATH"
export PATH="Library/Tex/Texbin:$PATH"
