function! vimrc#restore_cursor()
	"Is saved line is file range?
	if line("'\"") > 1 && line("'\"") <= line("$")
		normal! g`"
	endif
endfunction

function! vimrc#startinsert_if_first_line_is_empty()
	if getline(1) == ""
		startinsert
	endif
endfunction
