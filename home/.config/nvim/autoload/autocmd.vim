function! autocmd#restore_cursor()
	"is saved line in file range?
	if line("'\"") > 1 && line("'\"") <= line("$")
		normal! g`"
	endif
endfunction

function! autocmd#restore_buffer()
	if argc() == 0 && bufname('%') == ''
		bdelete
	endif
endfunction

function! autocmd#startinsert_if_firstline_empty()
	if getline(1) == ""
		startinsert
	endif
endfunction
