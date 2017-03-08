augroup my
	au FileType gitcommit call autocmd#startinsert_if_firstline_empty()
	au FileType css setlocal omnifunc=csscomplete#CompleteCSS
	"share shada file
	au CursorHold * rshada | wshada
augroup END
