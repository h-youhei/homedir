# accept aliases for sudo
alias s='sudo ' sudo='sudo '

alias ls='ls -F' l='ls' la='ls -A' ll='ls -l -h' lal='ll -A'
alias c='cd' c.='cd ..'
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


# save dir for xmonad
alias x="pwd > $HOME/.xmonad/mark"

#alias audiocd='vlc cdda:///dev/sr0'

#alias mat='cd ~/share/mfiles;FreeMat'

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
