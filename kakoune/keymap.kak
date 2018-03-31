### readline ###
map global prompt '<a-f>' '<c-w>' #Forward word
map global prompt '<a-F>' '<c-a-w>' #Forward WORD
map global prompt '<a-b>' '<c-b>' #Backward word
map global prompt '<a-B>' '<c-a-b>' #Backward WORD
map global prompt '<a-w>' '<c-b><c-k>' #delete Word
map global prompt '<a-e>' '<c-k>' #delete to End
map global prompt '<a-h>' '<c-u>' #delete to Home
map global prompt '<a-l>' '<home><c-k>' #delete Line
map global prompt '<c-q>' '<c-v>' #insert literal

### cursor ###
map global normal ^ '<home>' # 'move cursor line begin'
map global normal '<home>' ';Gi' # 'move cursor indent'
map global normal '<left>' H # 'expand cursor to left'
map global normal '<right>' L # 'expand cursor to right'

### goto ###
map global goto '<down>' j -docstring 'buffer bottom'
map global goto '<up>' k -docstring 'buffer top'
map global goto '<left>' h -docstring 'line begin'
map global goto '<right>' l -docstring 'line end'
#unmap global goto h
#unmap global goto j
#unmap global goto k
#unmap global goto l

map global normal '<a-g>' '<c-o>' # 'jump backward'
map global normal '<a-G>' '<tab>' # 'jump forward'

### view ###
# don't escape view mode with cursor keys
# escape view mode immediately with other keys
map global normal v V
map global view v 'v<esc>' -docstring 'cursor center (vertically)'
map global view c 'c<esc>' -docstring 'cursor center (vertically)'
map global view m 'm<esc>' -docstring 'cursor center (horizontally)'
map global view t 't<esc>' -docstring 'cursor on top'
map global view b 'b<esc>' -docstring 'cursor on buttom'
map global view '<left>' h -docstring 'scroll left'
map global view '<down>' j -docstring 'scroll down'
map global view '<up>' k -docstring 'scroll up'
map global view '<right>' l -docstring 'scroll right'
#unmap global view h
#unmap global view j
#unmap global view k
#unmap global view l

### use alt for expand
map global normal W '<a-w>' # 'select to the next WORD'
map global normal '<a-w>' W # 'expand to the next word'
map global normal B '<a-b>' # 'select to the prev WORD (Back)'
map global normal '<a-b>' B # 'expand to the prev word (Back)'
map global normal E '<a-e>' # 'select to Last char of the WORD'
map global normal '<a-e>' E # 'expand to Last char of the word'
map global normal F '<a-f>' # 'Find a char backward'
map global normal '<a-f>' F # 'expand to a char'
map global normal T '<a-t>' # 'select to before a entered charcter backward'
map global normal '<a-t>' T # 'expand to a entered charcter forward'
map global normal ? '<a-/>' # 'search backward'
map global normal '<a-/>' ? # 'expand with search'
map global normal N '<a-n>' # 'select prev search'
map global normal '<a-n>' N # 'add a new selection with next match'
map global normal '<a-[>' { # 'expand text object backward'
map global normal '<a-]>' } # 'expand text object forward'

### comment ###
map global normal '#' :comment-line<ret> -docstring 'comment line'
map global normal '<a-#>' :comment-block<ret> -docstring 'comment block'

### search ###
#put cursor on beginning of selection
#TODO:
#	incremental #1958
#	initial string -init doesn't erase automatically
#define-command -hidden search-forward %{
	#prompt 'search:' %{
		#execute-keys "/%val{text}<ret><a-;>"
	#}
#}
#nothing happens
#define-command -hidden swap-anchor-and-cursor-after-prompt%{
	#hook -group search global ModeChange prompt:normal %{
		#execute-keys '<a-;>'
		#remove-hooks global search
	#}
#}
#map global normal / ':search-forward<ret>'
#map global normal n 'n<a-:><a-;>'
#map global normal N '<a-n><a-:><a-;>'
#map global normal '<a-n>' 'N<a-:><a-;>'
#map global normal '<a-N>' '<a-N><a-:><a-;>'

### selection ###
map global normal k '<a-k>' # 'Keep matched selects'
map global normal K '<a-K>' # 'drop matched selects'
plug each-line-selection
map global normal '<a-k>' ':keep-selection-each-line<ret>'
map global normal '<a-K>' ':drop-selection-each-line<ret>'
# use execute-keys to get rid of count
map global normal '<esc>' ":execute-keys '<space>;'<ret>" # 'deselect all'
#map global normal '<space>' '<a-space>' # 'remove current selection'
#map global normal '<a-space>' '<space>' # 'select only current selection'

map global normal * '%' # 'select whole buffer'
map global normal '%' m # 'select to matching character'
map global normal '<a-%>' M # 'extend selection to matching character'
map global normal $ * # 'put current selection on search register'
map global normal '<a-|>' $ # 'pipe each selection. then keep selections the command return 0'

define-command -hidden split-with-char %{
	info -title 'split with next char' 'enter char to split selection'
	on-key %{ %sh{
		case $kak_key in
		#use execute-keys to close infomation area
		"<esc>" | "<backspace>") echo "execute-keys :nop<ret>" ;;
		'<ret>') echo "execute-keys $kak_count<a-s>" ;;
		'<tab>') echo "execute-keys S\t<ret>" ;;
		'<space>') echo "execute-keys S\s+<ret>" ;;
		*) echo "execute-keys S\Q$kak_key\E<ret>" ;;
		esac
	}}
}
map global normal S ':split-with-char<ret>' # 'split selection with the next entered character'
map global normal '<a-S>' S # 'split selection with regex'

### character-wise ###
map global normal '<del>' \;d # 'delete a char'
map global normal '<backspace>' hd # 'delete a char bockward'
map global normal '<c-c>' '<backspace>' # 'cansel count'
map global normal r \;r # 'replace a char with the next entered one'
map global normal '<a-r>' r # 'replace each character with the next entered one'
map global normal '<a-`>' ';<a-`>' # 'swap case a char'
plug multiple-insert
map global normal i ':start-insert-before-cursor<ret>'
map global normal a ':start-insert-after-cursor<ret>'
map global normal h i # 'start insert before selection'
map global normal H a # 'start insert after selection'
map global normal j ':inject-char-before-cursor<ret>' # 'inJect a character before cursor'
map global normal J ':inject-char-after-cursor<ret>' # 'inJect a character after cursor'

### line-wise ###
map global normal l 'X<a-x>' # 'expand line downward'
map global normal L 'K<a-x>' # 'expand line upward'
map global normal D '<a-x>d'  # 'delete line'
map global normal C '<a-s>gi<a-l>c' # 'change line'
map global normal Y '<a-x>y' # 'yank line'
map global normal '<a-j>' '<a-J>' # 'join line
plug copy-or-shrink
map global normal '<a-l>' ':copy-or-shrink-downward<ret>' # 'copy the current selection downward'
map global normal '<a-L>' ':copy-or-shrink-upward<ret>' # 'copy the current selection upward'

### paragraph ###
map global normal { [p # 'select paragraph backward'
map global normal } ]p # 'select paragroph forward'
map global normal '<a-{>' {p # 'expand paragroph backward'
map global normal '<a-}>' }p # 'expand paragraph forward'

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
#map global object A 'c\W|[a-z](?=[A-Z]),\W|[A-Z]<ret>' -docstring 'camelCase'
#unmap global object b
#unmap global object Q
#unmap global object g
#unmap global object c

### mark ###
map global normal m z # 'restore Mark'
map global normal M Z # 'save Mark'
# If nothing is marked, <a-z> and <a-Z> behave like z and Z.
# So <a-z>a and <a-Z>a start insert mode accidentally.
# These wrappers prevent it.
define-command -hidden fold-mark-restore %{ %sh{
	if [ $kak_reg_caret ] ; then
		echo "execute-keys -save-regs '' <a-z>a"
	else
		echo "fail 'Register ^ does not contain a selection desc'"
	fi
}}
define-command -hidden fold-mark-save %{ execute-keys -save-regs '' %sh{
	if [ $kak_reg_caret ] ; then
		echo "<a-Z>a"
	else
		echo "<a-Z>"
	fi
}}
map global normal z ':fold-mark-restore<ret>'
map global normal Z ':fold-mark-save<ret>'

### macro ###
map global normal x q # 'eXecute macro'
map global normal X Q # 'start or stop recording macro'

### quit ###
map global normal q ':quit<ret>' # 'Quit client'
map global normal Q ':kill<ret>' # 'Quit server'

### buffer ###
map global normal '<c-b>' ':buffer<space>' # 'switch Buffer'
map global normal '<a-q>' ':delete-buffer<ret>' # 'Quit buffer'
map global normal '<plus>' ':write<ret>' # 'save buffer'

### file system ###
map global normal '<c-f>' ':edit<space>' # 'edit new File'
map global normal '<c-d>' ':cd<space>' # 'change Directory'
# map global normal '<c-r>' # 'edit Recent file'
# map global normal '<c-t>' # 'open new terminal'

### project ###
# map global normal '<c-p>' # 'fzf in project'
# map global normal '<c->' # 'open terminal in project root'

### clipboard ###
declare-user-mode clipboard
map global normal '\'' ':enter-user-mode clipboard<ret>'
declare-option str clipboard 'xsel --clipboard -l /dev/null'
#TODO: if last character is \n, treat linewise
map -docstring 'Paste after current selection from clipboard' \
	global clipboard p "<a-!>%opt{clipboard} -o<ret>"
map -docstring 'Paste before current selection from clipboard' \
	global clipboard P "!%opt{clipboard} -o<ret>"
map -docstring 'Replace current selection with clipboard' \
	global clipboard R "|%opt{clipboard} -o<ret>"
map -docstring 'Yank selection to clipboard' \
	global clipboard y "<a-|>%opt{clipboard} -i<ret>:echo 'copied selection to clipboard'<ret>"
map -docstring 'Yank line to clipboard' \
	global clipboard Y "<a-x><a-|>%opt{clipboard} -i<ret>:echo 'copied line to clipboard'<ret>"

### surround ###
plug surround
map global normal '<a-s>' ':surround<ret>' # 'surround selection'
map global normal '<a-d>' ':delete-surround<ret>' # 'delete surround'
map global normal '<a-c>' ':change-surround<ret>' # 'change surround'

### overwrite ###
#plug overwrite
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

### indent ###
map global normal & '<a-:><a-;>&' # 'left alignment'
map global insert '<a-ret>' '<a-;><a-o><down>' # 'newline without indent'
define-command remove-all-indent %{
	try %{
		execute-keys -draft "<a-x>s^\Q%opt{comment_line}\E*\s+<ret>"
		execute-keys "<a-x>s^\Q%opt{comment_line}\E*\s+<ret>"
		execute-keys 's\s+<ret>d'
	}
}
map global normal '<a-lt>' ':remove-all-indent<ret>'

### format ###
declare-user-mode format
map global normal = ':enter-user-mode format<ret>'
map -docstring 'trim trailing spaces' \
	global format $ ':trim-trailing-spaces<ret>'
map -docstring 'replace spaces full-width to half-width' \
	global format f ':replace-spaces-full-to-half<ret>'
