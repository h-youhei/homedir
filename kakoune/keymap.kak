### my keybord layout is not qwerty ###
map global normal t j # 'move cursor downward'
map global normal T J # 'expand cursor downward'
map global normal '<a-t>' C # 'copy the current selection downward'
map global normal e k # 'move cursor upward'
map global normal E K # 'expand cursor upward'
map global normal '<a-e>' '<a-C>' # 'copy the current selection upward'
map global normal g h # 'move cursor to left'
map global normal G H # 'expand cursor to left'
map global normal '<a-g>' '<c-o>' # 'jump backward'
map global normal u l  # 'move cursor to right'
map global normal U L  # 'expand cursor to right'
map global normal '<a-u>' '<c-i>' # 'jump forward'
map global normal j g # 'Jump'
map global normal J G # 'Jump'
map global normal l e # 'select to Last char of the word'
map global normal L '<a-e>' # 'select to Last char of the WORD'
map global normal '<a-l>' E # 'expand to Last char af the word'
map global normal '<a-L>' '<a-E>' # 'expand to Last char af the WORD'
map global normal h u # 'backward to History (Undo)'
map global normal H U # 'forward in History (Redo)'
map global normal '<a-h>' '<a-u>' # 'backward to History (Undo)'
map global normal '<a-H>' '<a-U>' # 'forward in History (Redo)'
map global normal k t # 'select on to a entered character forward (Knock)'
map global normal K '<a-t>' # 'select to before a entered charcter backward (Knock)'
map global normal '<a-k>' T # 'expand to a entered charcter forward (Knock)'
map global normal '<a-K>' '<a-T>' # 'expand to a entered char backward (Knock)'
#unmap global goto g
#unmap global goto k
map global goto '<down>' j -docstring 'buffer bottom'
map global goto '<up>' k -docstring 'buffer top'
map global goto '<left>' h -docstring 'line begin'
map global goto '<right>' l -docstring 'line end'
map global goto j g -docstring 'buffer top'
map global goto J b -docstring 'buffer bottom'
map global goto s k -docstring 'buffer start'
#unmap global view h
#unmap global view j
#unmap global view k
#unmap global view l
map global view '<down>' j -docstring 'scroll down'
map global view '<up>' k -docstring 'scroll up'
map global view '<left>' h -docstring 'scroll left'
map global view '<right>' l -docstring 'scroll right'

### use alt for expand
map global normal W '<a-w>' # 'select to the next WORD'
map global normal '<a-w>' W # 'expand to the next word'
map global normal B '<a-b>' # 'select to the prev WORD (Back)'
map global normal '<a-b>' B # 'expand to the prev word (Back)'
map global normal '"' '<a-\'>' # 'select previous selection'
map global normal '<a-\'>' '<a-">' # 'exchange selections'
map global normal '<a-">' '"' # 'choose register'
map global normal F '<a-f>' # 'Find a char backward'
map global normal '<a-f>' F # 'expand to a char'
map global normal ? '<a-/>' # 'search backward'
map global normal '<a-/>' ? # 'expand with search'
map global normal N '<a-n>' # '
map global normal '<a-n>' N # '

### comment ###
map global normal '#' :comment-line<ret> -docstring 'comment line'
map global normal '<a-#>' :comment-block<ret> -docstring 'comment block'

### selection ###
map global normal '<a-x>' '<a-K>' -docstring 'eXclude matched selects'
map global normal '<a-X>' '<a-k>' -docstring 'keep matched selects'
map global normal '<esc>' '<backspace><space>;' -docstring 'deselect'
#map global normal \; '<a-;>' -docstring 'flip the selections direction'
#map global normal '<a-;>' \' -docstring 'reduce selections to their cursor'

define-command -hidden split-with-char %{ on-key %{ execute-keys %sh{
	case $kak_key in
	'<ret>') pattern='\n' ;;
	'<tab>') pattern='\t' ;;
	'<space>') pattern='\s+' ;;
	*) pattern='\Q'$kak_key'\E' ;;
	esac
	echo "S$pattern<ret>"
}}}
map global normal S ':split-with-char<ret>' # 'split selection with the next entered character'
map global normal '<a-S>' S # 'split selection with regex'

### character-wise ###
map global normal '<del>' \;d # 'delete a char'
map global normal '<backspace>' hd # 'delete a char bockward'
map global normal '<c-c>' '<backspace>' # 'cansel count'
map global normal r \;r # 'replace a char with the next entered one'
map global normal '<a-r>' r # 'replace each character with the next entered one'
map global normal '<a-`>' ';<a-`>' # 'swap case a char'
source "%val{config}/plugin/multiple-insert.kak"
map global normal i ':start-insert-before-cursor<ret>'
map global normal a ':start-insert-after-cursor<ret>'
map global normal ( i # 'start insert before selection'
map global normal ) a # 'start insert after selection'

### line-wise ###
map global normal '<minus>' 'X<a-x>' # 'expand line downward'
map global normal _ 'K<a-x>' # 'expand line upward'
map global normal D '<a-x>d'  # 'delete line'
map global normal C '<a-s>gi<a-l>c' # 'change line'
map global normal Y '<a-x>y' # 'yank line'

### text object ###
map global object a u -docstring 'argument'
#unmap global object u
map global object l 'c(?<lt>=\n)\h*,\n<ret>' -docstring 'line'
map global object t 'c<lt>[^<gt>]+<gt>\s*,\s*<lt>/[^<gt>]+<gt><ret>' -docstring 'ml tag'
map global object / 'c\s|/,<a-:>\s|/<ret>' -docstring 'path hierarchy'
map global object . 'c\s|\.,\s|\.<ret>' -docstring 'dot (member etc)'
map global object : 'c\s|:+,\s|:+<ret>' -docstring 'colon (namespace etc)'
map global object q c -docstring 'query for custom object'
map global object _ 'c_|\W,_|\W<ret>' -docstring 'snake_case'
# this doesn't work
# map global object A 'c\W|[a-z](?=[A-Z]),\W|[A-Z] -docstring 'camelCase'
#unmap global object b
#unmap global object Q
#unmap global object g
#unmap global object c
map global normal [ [p # 'select paragraph backward'
map global normal ] ]p # 'select paragroph forward'
map global normal '<a-[>' {p # 'expand paragroph backward'
map global normal '<a-]>' }p # 'expand paragraph forward'
map global normal { [ # 'select text object backward'
map global normal } ] # 'select text object forward'
map global normal '<a-{>' { # 'expand text object backward'
map global normal '<a-}>' } # 'expand text object forward'
map global normal '<a-m>' m # 'move cursor to matched paren'
add-highlighter global show_matching

### mark ###
map global normal m z # 'restore Mark'
map global normal M Z # 'save Mark'

# acceptable argument: <a-z> <a-Z>
define-command -hidden -params 1 _fold-mark-delegate %{ execute-keys  -save-regs '' %sh{
	if [ $kak_reg_caret ]; then
		echo "$1"a
	else
		echo $1
	fi
}}
define-command -hidden fold-mark-then-restore %{ evaluate-commands -save-regs ''  %{ _fold-mark-delegate <a-z> } }
define-command -hidden fold-mark-then-save %{ evaluate-commands -save-regs '' %{ _fold-mark-delegate <a-Z> } }
map global normal z ':fold-mark-then-restore<ret>'
map global normal Z ':fold-mark-then-save<ret>'

### macro ###
map global normal x q # 'eXecute macro'
map global normal X Q # 'start or stop recording macro'

### client ###
map global normal q ':quit<ret>' # 'Quit client'

### buffer ###
map global normal '<c-b>' ':buffer<space>' # 'switch Buffer'
map global normal Q ':delete-buffer<ret>' # 'Quit buffer'
map global normal '<plus>' ':write<ret>' # 'save buffer'

### file system ###
map global normal '<c-f>' ':edit<space>' # 'edit new File'
map global normal '<c-d>' ':cd<space>' # 'change Directory'
# map global normal '<c-r>' # 'edit Recent file'
# map global normal '<c-t>' # 'open new terminal'

### project ###
# map global normal '<c-p>' # 'fzf in project'
# map global normal '<c->' # 'open terminal in project root'

### leader ###
map global normal '<space>' , # 'user mode'
map global normal ',' '<a-space>' # 'remove current selection'
map global normal '<a-,>' '<space>' # 'keep only current selection'
#unmap global normal '<a-space>'

### clipboard ###
declare-option str clipboard 'xsel --clipboard -n -l /dev/null'
map global user p "<a-!>%opt{clipboard} -o<ret>" -docstring 'Paste after current selection from clipboard'
map global user P "!%opt{clipboard} -o<ret>" -docstring 'Paste before current selection from clipboard'
map global user R "|%opt{clipboard} -o<ret>" -docstring 'Replace current selection with clipboard'
map global user y "<a-|>%opt{clipboard} -i<ret>:echo 'copied selection to clipboard'<ret>" -docstring 'Yank selection to clipboard'
map global user Y "<a-x><a-|>%opt{clipboard} -i<ret>:echo 'copied line to clipboard'<ret>" -docstring 'Yank line to clipboard'

### surround ###
source "%val{config}/plugin/surround.kak"
map global normal '<a-s>' ':surround<ret>' # 'surround selection'
map global normal '<a-d>' ':delete-surround<ret>' # 'delete surround'
map global normal '<a-c>' ':change-surround<ret>' # 'change surround'

### overwrite ###
#source "%val{config}/overwrite.kak"
#map global normal '<insert>' ':overwrite<ret>' -docstring 'overwrite mode'

### completion ###
hook global InsertCompletionShow .* %{
	map window insert <tab> <c-n>
	map window insert <backtab> <c-p>
}
hook global InsertCompletionHide .* %{
	unmap window insert <tab> <c-n>
	unmap window insert <backtab> <c-p>
}

### reset indent ###
#map global insert '' '<ret><esc>i'
#s^\s+d

