# space at the end accepts aliases for following command
alias s='sudo ' sudo='sudo '
alias se='sudoedit'

# to use different option by global alias
alias _grep-option='command grep --extended-regexp --color=auto'
alias grep='_grep-option --recursive --line-number'

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
	if [ $TERM = linux ] ; then
		kak $@
	else
		kak-git $@
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
alias sln='ln -s' uln='unlink'
alias t='xterm &'
#Bzip Gzip Xz
alias tarb='tar cvf --bzip2' targ='tar cvf --gzip' tarx='tar cvf --xz' utar='tar xvf'
alias gz='gzip' ugz='gunzip'

### git ###
alias g='git'
alias ga='git add'
alias gbrm='git branch -d'
alias gc='git commit' gca='gc --amend'
alias gg='tig grep'
alias gco='git checkout'
alias gcl='hub clone'
alias pgcl='pcl | xargs git clone'
alias gd='git diff'
alias gl='git log --groph'
alias gm='git merge'
alias gmv='git mv'
alias gp='git push' gpu='gp -u origin master'
alias gra='hub remote add origin' grau='hub remote add upstream'
alias pgra='pcl | xargs git remote add origin' pgrau='pcl | xargs git remote add upstream'
alias grb='git rebase -i' grbc='git rebase --continue'
alias grm='g rm'
alias grs='git reset' grsh='grs --hard'
alias grv='git revert'
alias gs='git status'
alias gsh='git show'
alias gsm='git submodule'
alias gsma='hub submodule add'
alias pgsma='pcl | xargs git submodule add'
alias gsmi='gsm init'
alias gsmu='gsm update'
alias gh='hub' ghb='gh browse'
#sYnc
alias gy='git pull' gyo='gy orgin master' gyu='gy upstream master'

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
ghpr() {
	if test "$#" -ne 1
	then
		echo 'put pull request number'
		return
	fi
	repo=`git config --get remote.origin.url`
	repo=${repo%.git}
	repo=${repo#git@github.com:}
	hub checkout https://github.com/$repo/pull/$1
}

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config
if [ -d $XDG_CONFIG_HOME/sh-common/alias.d ] ; then
	for f in $XDG_CONFIG_HOME/sh-common/alias.d/?*.sh ; do
		[ -f $f ] && source $f
	done
	unset f
fi
