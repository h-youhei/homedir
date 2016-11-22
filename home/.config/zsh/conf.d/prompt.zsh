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
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '!'
zstyle ':vcs_info:*' unstagedstr '+'
zstyle ':vcs_info:*' formats '%c%u(%b) '
zstyle ':vcs_info:*' actionformats '%u%c(%b|%a) '

#this is called before showing prompt
precmd() {
	vcs_info
}

PROMPT='
${vcs_info_msg_0_}[%~]
%n$host%#'
# while, for, etc...
PROMPT2='%_>'
# right
RPROMPT='[%?]'
# correct
SPROMPT='correct to %r? [y,n,(a)bort,(e)dit]'
