#TODO: doesn't work correctly under multiple selection + count

define-command  -docstring 'Start insert mode before cursor.
If count is given, multiple inserted text count times.' \
start-insert-before-cursor %{
	execute-keys \;
	evaluate-commands %sh{
		if [ $kak_count -gt 1 ]; then
			echo _multiple-insert
		else
			echo execute-keys -with-hooks i
		fi
	}
}

define-command -docstring 'Start insert mode after cursor.
If count is given, multiple inserted text count times.' \
start-insert-after-cursor %{
	execute-keys \;
	evaluate-commands %sh{
		if [ $kak_count -gt 1 ]; then
			echo _multiple-append
		else
			echo execute-keys -with-hooks a
		fi
	}
}

define-command -hidden _multiple-insert %{
	execute-keys "y%val{count}p%val{count}Ls.<ret><a-space>c"
}

define-command -hidden _multiple-append %{
	#whether to start insert at beginning of next line or eol
	#try %{
		#throw on eol
		#execute-keys -draft 's[^\n]<ret>'
		execute-keys "y%val{count}p%val{count}Ls.<ret>)<a-space>c"
	#} catch %{
	#	_multiple-insert
	#}
}

#define-command -docstring 'Start insert mode before selection.
#If count is given, multiple inserted text count times.' \
#start-insert-before-selection %{
	#execute-keys '<a-:><a-;>'
	#start-insert-before-cursor
#}

#define-command -docstring 'Start insert mode after selection.
#If count is given, multiple inserted text count times.' \
#start-insert-after-selection %{
	#execute-keys  '<a-:>'
	#start-insert-after-cursor
#}

define-command -docstring 'Inject next typed char before cursor.
If count is given, multiple typed char count times.' \
inject-char-before-cursor %{
	execute-keys \;
	info -title 'insert next char' 'enter char to inject before cursor'
	_impl-inject-char i
}

define-command -docstring 'Inject next typed char after cursor.
If count is given, multiple typed char count times.' \
inject-char-after-cursor %{
	execute-keys \;
	info -title 'append next char' 'enter char to inject after cursor'
	_impl-inject-char a
}

define-command -hidden -params 1 _impl-inject-char %{
	on-key %{ evaluate-commands %sh{
		if [ $kak_count -eq 0 ] ; then
			echo "execute-keys $1$kak_key<esc>"
		else
			i=0
			accum=
			while [ $i -lt $kak_count ] ; do
				accum=$kak_key$accum
				i=$(($i+1))
			done
			echo "execute-keys $1$accum<esc>"
		fi
	}}
}
