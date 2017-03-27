export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

typeset -U path fpath
path=(
	~/bin(N-/)
	~/.cargo/bin(N-/)
	$GOPATH/bin(N-/)
	$path
)
fpath=(
	$ZDOTDIR/functions(N-/)
	$ZDOTDIR/completions(N-/)
	$fpath
)

export EDITOR='nvim'
export DIFFPROG='nvim -d'

export PAGER='less'
export MANPAGER='nvim -R -c "set ft=man" -'
export LESS='-iMR'

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
