# space at the end accepts aliases for following command
alias s='sudo ' sudo='sudo '
alias se='sudoedit'

alias _grep-option='command grep --extended-regexp --color=auto --line-number'
alias grep='_grep-option --recursive'

### clipboard selection ###
alias xsel='xsel -l /dev/null'
alias xcl='xsel --clipboard' xsl='xsel --primary'
#alias xcl='xclip -selection clipboard' xsl='xclip -selection primary'
#yank
#alias ycl='xclip --selection clipboard -i' ysl='xclip --selection primary -i'
alias ycl='xcl -i <' ysl='xsl -i <'
#paste
alias pcl='xcl -o' psl='xsl -o'

alias c='cd' pd='cd -' cg='c `git rev-parse --show-toplevel 2> /dev/null`'

#Normal, Dir, eXe, Secure, SecureDir
alias cm='chmod' cmn='cm 644' cmd='cm 755' cmx='cm 744' cms='cm 600' cmsd='cm 700'

alias df='df -h'
#Edit, EditDirectory
alias ed='vidir'
#workaround to use differnt color between console and X
e() {
	if [ $TERM = linux ]
	then ; kak $@
	else ; kak-git $@
	fi
}
alias f='fd'
#Help
alias h='man'
alias ls='ls -F --color=auto --group-directories-first' l='ls' ll='ls -l -h' la='ls -A' lal='ll -A'
alias m='mv'
alias mkdir='mkdir -p' md='mkdir'
#MakeFile
alias mf='touch'
mdc() {
	mkdir -p "$@" && cd "$_"
}
alias p='cp'
alias py='python'
alias q='exit'
alias rmd='rmdir'
alias rnm='rename'
alias sa='ssh-add'
alias sysc='systemctl'
alias sln='ln -s'
alias t='mlterm &; disown %mlterm'
#Bzip Gzip Xz
alias tarb='tar cvf --bzip2' targ='tar cvf --gzip' tarx='tar cvf --xz' untar='tar xvf'

### git ###
alias g='git'
alias ga='g add'
alias gc='g commit' gca='gc --amend'
alias gg='tig grep'
alias gco='g checkout'
alias gcl='pcl | xargs git clone'
alias gd='g diff'
alias gl='g log --graph'
alias gm='g mv'
alias gra='pcl | xargs git remote add' grau='pcl | xargs git remote add upstream'
alias grb='g rebase -i' grbc='g rebase --continue'
alias grm='g rm'
alias grs='g reset' grsh='grs --hard'
alias grv='g revert'
alias gs='g status'
alias gh='hub' ghb='gh browse'

# no param: show branch list
# with param: create branch
gb() {
	if test "$#" -gt 0
	then
		command git checkout -b $@
		return
	fi

	command git branch
}

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config 
if [ -d $XDG_CONFIG_HOME/sh-common/alias.d ] ; then
	for f in $XDG_CONFIG_HOME/sh-common/alias.d/?*.sh ; do
		[ -f $f ] && source $f
	done
	unset f
fi
