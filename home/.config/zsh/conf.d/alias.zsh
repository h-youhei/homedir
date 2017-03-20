# accept aliases for sudo
alias s='sudo ' sudo='sudo '

alias c='cd' c-='cd -' cg='c `git rev-parse --show-toplevel 2> /dev/null`'
#normal, secure, secure dir
alias cm='chmod' cmn='chmod 644' cms='chmod 600' cmsd='chmod 700' cmx='chmod 755'
alias f='find'

#git
alias g='git'
alias ga='g add'
alias gc='g commit' gca='gc --amend'
alias gco='g checkout'
alias gcl='xp X git clone'
alias gd='g diff'
alias gm='g mv'
alias gra='xp X git remote add' grau='xp X git remote add upstream'
alias grb='g rebase -i'
alias grm='g rm'
alias grs='g reset'
alias gs='g status'
alias gh='hub' ghb='gh browse'

alias h='man'
alias ls='ls -F --group-directories-first' lsl='ls -l -h' l='ls -A' ll='lsl -A'
alias m='mv'
alias mkdir='mkdir -p' md='mkdir'
alias p='cp'
alias pd='pacdiff'
alias pm='pacman' pmi='pm -S' pms='pm -Ss' pmr='pm -Rsn' pmu='pm -Syu' pmq='pm -Qe'
alias pma='aura' pmai='pma -A' pmas='pma -Aas' pmar='pma -Rsn' pmau='pma -Ayu' pmau='pm -Qem' pmad='pma -Aw'
alias py='python'
alias q='exit'
alias rmd='rmdir'
alias rnm='rename'
alias sa='ssh-add'
alias sln='ln -s'
#Gzip
alias targ='tar zvcf' untar='tar xvf'
alias v='nvim' vi='v -u NONE'
# save dir for xmonad
alias x="pwd > $HOME/.xmonad/mark"
alias xclip='xclip -selection clipboard' xprim='xclip -selection primary'
alias xp='xclip -o' xpp='xprim -o'

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

gb() {
	if test "$#" -gt 0
	then
		command git checkout -b $@
		return
	fi

	command git branch
}

#vim external
ve() {
	urxvt -e nvim $@ &
}

#terminal
t() {
	urxvt $@ &
}
