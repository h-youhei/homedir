define-command  insert-here-with-count %{
	execute-keys \;
	%sh{
		if [ $kak_count = 0 -o $kak_count = 1 ]; then
			echo execute-keys i
		else
			echo _fold-insert
		fi
	}
}

define-command append-here-with-count %{
	execute-keys \;
	%sh{
		if [ $kak_count = 0 -o $kak_count = 1 ]; then
			echo execute-keys a
		else
			echo _fold-append
		fi
	}
}

define-command -hidden _fold-insert %{
	try %{
		execute-keys -draft 's[^\n]<ret>'
		execute-keys "y%val{count}p%val{count}Ls.<ret><a-space>c"
	} catch %{
		_fold-insert-on-eol
	}
}

define-command -hidden _fold-append %{
	try %{
		execute-keys -draft 's[^\n]<ret>'
		execute-keys "y%val{count}p%val{count}Ls.<ret>'<a-space>c"
	} catch %{
		_fold-insert-on-eol
	}
}

define-command  -hidden _fold-insert-on-eol %{ %sh{
	decremented=$(($kak_count - 1))
	echo "execute-keys \"i.<esc>y${decremented}P${decremented}Hs.<ret>c\""
}}
