define-command -hidden -params 1 _select-surround %{ execute-keys "<a-a>%arg{1}<a-S>" }
define-command -hidden -params 2 _impl-surround %! %sh@
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

define-command -hidden _surrounding-object-info %{
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

define-command -hidden _surround-info %{ info -title 'select surrounder' \
'() [] {} <> surround with the pair
characters surround with the charactr
' }

define-command -hidden delete-surround %{
	_surrounding-object-info
	on-key %{
		_select-surround %val{key}
		execute-keys 'd<space>'
}}

define-command -hidden -params 2 _change-surround %{ execute-keys "r%arg{1}<space>r%arg{2}<space>;" } 
define-command -hidden change-surround %{
	_surrounding-object-info
	on-key %{
	_select-surround %val{key}
	_surround-info
	on-key %{ _impl-surround "_change-surround" %val{key} }
}}

define-command -hidden -params 2 _surround %{ execute-keys "i%arg{1}<esc>a%arg{2}<esc>" }
define-command -hidden surround %{
	_surround-info
	on-key %{ _impl-surround "_surround" %val{key} } }
