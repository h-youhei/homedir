if test -n "$SSH_CONNECTION"
then
	local host='@%m'
else
	local host=''
fi

PROMPT="
[%~]
%n$host%#"
# while, for, etc...
PROMPT2='%_>'
# right
RPROMPT='[%?]'
# correct
SPROMPT='correct to %r? [y,n,(a)bort,(e)dit]'
