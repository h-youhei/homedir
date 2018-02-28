define-command _select-surround -hidden -params 1 %{ execute-keys "<a-a>%arg{1}<a-S>" }
define-command _delegate-surround -hidden -params 2 %! %sh@
	command=$1
	case $2 in
	'('|')') open='('; close=')' ;;
	'['|']') open='['; close=']' ;;
	'{'|'}') open='{'; close='}' ;;
	'<lt>'|'<gt>') open='<lt>'; close='<gt>' ;;
	\') open="<'>"; close="<'>" ;;
	\") open='<">'; close='<">' ;;
	*) open=$2; close=$2 ;;
	esac
	echo "$command $open $close"
@!

define-command _surrounding-object-info -hidden %{
	info -title 'select surrounding object' \
'() [] {} <> \' " ` surrounded by the pair
w word
W WORD
s sentense
p paragraph
<space> whitespaces
i indent
a argument
t markup tag
l line
q custom object
/ path hierarchy
_ . : separated by the char or whitespace
' }

define-command _surround-info -hidden %{ info -title 'select surrounder' \
'() [] {} <> surround with the pair
characters surround with the charactr
' }

define-command delete-surround -hidden %{
	_surrounding-object-info
	on-key %{
		_select-surround %val{key}
		execute-keys 'd<space>'
}}

define-command _change-surround -hidden -params 2 %{ execute-keys "r%arg{1}<space>r%arg{2}<space>;" } 
define-command change-surround -hidden %{
	_surrounding-object-info
	on-key %{
	_select-surround %val{key}
	_surround-info
	on-key %{ _delegate-surround "_change-surround" %val{key} }
}}

define-command _surround -hidden -params 2 %{ execute-keys "i%arg{1}<esc>a%arg{2}<esc>" }
define-command surround -hidden %{
	_surround-info
	on-key %{ _delegate-surround "_surround" %val{key} } }
