alias_file=$XDG_CONFIG_HOME/sh-common/alias.sh
[ -f $alias_file ] && emulate sh -c ". $alias_file"
unset alias_file

alias -g A='| awk'
#backward
alias -g B='| tac'
alias -g C='| cut'
alias -g E='| sed'
alias -g F='| fzf'
#grep
alias -g G='| _grep-option'
alias -g H='| head'
alias -g J='| join'
alias -g L='| less'
#math
alias -g M='| bc'
alias -g P='| paste'
#replace
alias -g R='| tr'
alias -g S='| sort'
alias -g T='| tail'
alias -g U='| uniq'
alias -g V='| vipe |'
#watch
alias -g W='| less +F'
alias -g X='| xargs '
alias -g X@='| xargs -I @@ '
#yank
alias -g Y='| xcl -i'
