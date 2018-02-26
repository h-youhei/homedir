alias_file=$XDG_CONFIG_HOME/sh-common/alias.sh
[ -e $alias_file ] && emulate sh -c ". $alias_file"
unset alias_file

alias -g A='| awk'
alias -g C='| cut'
alias -g F='| fzf'
alias -g G='| grep'
alias -g H='| head'
alias -g J='| join'
alias -g L='| less'
alias -g LF='| less +F'
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
