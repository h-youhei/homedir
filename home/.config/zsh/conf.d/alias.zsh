# accept aliases for sudo
alias s='sudo ' sudo='sudo '

alias ls='ls -F' l='ls' ll='ls -l -h' la='ls -A' lla='ll -A'
alias cm='chmod' cmx='chmod 755'
alias rnm='rename'
alias p='cp'
alias rmd='rmdir'
alias targz='tar zvcf' untar='tar xvf'
alias mkdir='mkdir -p' md='mkdir'
alias m='mv'
alias v='nvim' vi='v -u NONE' cv='cvim'
alias q='exit'
alias h='man'
alias sln='ln -s'
alias f='find'
alias pm='pacman' pmi='pm -S' pms='pm -Ss' pmr='pm -Rsn' pmu='pm -Syu' pmq='pm -Qe'
alias pd='pacdiff'
alias pma='aura' pmai='pma -A' pmas='pma -Aas' pmar='pma -Rsn' pmau='pma -Au' pmau='pm -Qem' pmad='pma -Aw'
alias sa='ssh-add'
alias g='git'
alias gh='hub'
alias xclip='xclip -selection clipboard' xp='xclip -o'

alias c='cd'
# when to be given no argument
# in git project, cd git-root
# in git root, cd $HOME
# the other, builtin
cd() {
	if test "$#" -gt 0
	then
		builtin cd $@
		return
	fi

	local gitroot=`git rev-parse --show-toplevel 2> /dev/null`
	if test "$gitroot" && test "$gitroot" != "$PWD"
	then
		builtin cd $gitroot
		return
	fi

	builtin cd
}

# save dir for xmonad
alias x="pwd > $HOME/.xmonad/mark"

alias -g A='| awk'
alias -g C='| cut'
alias -g F='| fzf'
alias -g G='| grep'
alias -g H='| head'
alias -g J='| join'
alias -g L='| less'
alias -g O='| sort'
alias -g P='| paste'
alias -g R='| tr'
alias -g S='| sed'
alias -g T='| tail'
alias -g U='| uniq'
alias -g V='| tac'
alias -g W='| wc'
alias -g X='| xargs'
alias -g X@='| xargs -I @@'
alias -g Y='| xclip'
