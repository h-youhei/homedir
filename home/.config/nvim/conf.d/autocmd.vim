augroup my
	au VimEnter * nested call autocmd#restore_buffer()
	au FileType gitcommit call autocmd#startinsert_if_firstline_empty()
augroup END
