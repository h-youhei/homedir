#http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
setopt prompt_subst

if test "$SSH_CONNECTION"
then
	local host='@%m'
else
	local host=''
fi

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '(%b) '
zstyle ':vcs_info:*' actionformats '(%b|%a) '

#this is called before showing prompt
precmd() {
	vcs_info
}

_git_state() {
	local state=`git status --porcelain -uall 2> /dev/null`
	if test "$state"
	then
		echo "*"
	else
		echo ""
	fi
}

PROMPT='
$(_git_state)${vcs_info_msg_0_}[%~]
%n$host%#'
# while, for, etc...
PROMPT2='%_>'
# right
RPROMPT='[%?]'
# correct
SPROMPT='correct to %r? [y,n,(a)bort,(e)dit]'
