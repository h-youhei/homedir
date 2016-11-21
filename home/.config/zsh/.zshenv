XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"
XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME XDG_CACHE_HOME XDG_DATA_HOME

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

typeset -U path fpath
path=(
	~/bin(N-/)
	$path
)
fpath=(
	$ZDOTDIR/functions(N-/)
	$ZDOTDIR/completions(N-/)
	$fpath
)

export EDITOR='nvim'
export DIFFPROG='nvim -d'

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
