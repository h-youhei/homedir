#TODO: doesn/t work correctly under multiple selection + count

define-command  -docstring 'Start insert mode before cursor.
If count is given, imultiple inserted text count times.' \
start-insert-before-cursor %{
	execute-keys \;
	%sh{
		if [ $kak_count -gt 1 ]; then
			echo _multiple-insert
		else
			echo execute-keys i
		fi
	}
}

define-command -docstring 'Start insert mode after cursor.
If count is given, multiple inserted text count times.' \
start-insert-after-cursor %{
	execute-keys \;
	%sh{
		if [ $kak_count -gt 1 ]; then
			echo _multiple-append
		else
			echo execute-keys a
		fi
	}
}

define-command -docstring 'Start insert mode before selection.
If count is given, multiple inserted text count times.' \
start-insert-before-selection %{
	execute-keys '<a-:><a-;>'
	start-insert-before-cursor
}

define-command -docstring 'Start insert mode after selection.
If count is given, multiple inserted text count times.' \
start-insert-after-selection %{
	execute-keys  '<a-:>'
	start-insert-after-cursor
}
	

define-command -hidden _multiple-insert %{
	try %{
		execute-keys -draft 's[^\n]<ret>'
		execute-keys "y%val{count}p%val{count}Ls.<ret><a-space>c"
	} catch %{
		_multiple-insert-on-eol
	}
}

define-command -hidden _multiple-append %{
	try %{
		execute-keys -draft 's[^\n]<ret>'
		execute-keys "y%val{count}p%val{count}Ls.<ret>'<a-space>c"
	} catch %{
		_multiple-insert-on-eol
	}
}

define-command  -hidden _multiple-insert-on-eol %{ %sh{
	decremented=$(($kak_count - 1))
	echo "execute-keys \"i.<esc>y${decremented}P${decremented}Hs.<ret>c\""
}}
