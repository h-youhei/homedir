# accept aliases for sudo
alias s='sudo ' sudo='sudo '

alias ls='ls -F' l='ls' la='ls -A' ll='ls -l -h' lal='ll -A'
alias cm='chmod' cmx='chmod 755'
alias rn='rename'
alias p='cp -d' pr='p -r'
alias rmr='rm -r'
alias rd='rmdir'
alias targz='tar zvcf' untar='tar xvf'
alias md='mkdir -p'
alias m='mv'
alias v='nvim' vi='nvim -u NONE'
alias q='exit'
alias h='man'
alias sln='ln -s'
alias f='find'
alias pm='pacman -S' pms='pacman -Ss' pmr='pacman -Rsn' pmu='pacman -Syu'
alias pma='aura -A' pmas='aura -As' pmau='aura -Au'
alias g='git'

alias c='cd' c.='cd ..'
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
alias -g E='| sed'
alias -g G='| grep'
alias -g H='| head'
alias -g J='| join'
alias -g L='| less'
alias -g P='| paste'
alias -g R='| tr'
alias -g S='| sort'
alias -g T='| tail'
alias -g U='| uniq'
alias -g V='| tac'
alias -g W='| wc'
alias -g X='| xargs'
