let g:ibus#layout = 'xkb:us::eng'
let g:ibus#engine = 'mozc-jp'

augroup ibus
	autocmd!
"	au VimEnter * call ibus#inactivate()
"	au VimLeave * call ibus#activate()
	au InsertEnter * call ibus#activate()
	au InsertLeave * call ibus#inactivate()
augroup END
