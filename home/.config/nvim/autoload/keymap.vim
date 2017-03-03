function! keymap#set_mark()
	marks
	let c = nr2char(getchar())
	redraw
	execute 'normal! m' . c
endfunction

function! keymap#goto_mark()
	marks
	let c = nr2char(getchar())
	redraw
	execute 'normal! `' . c
endfunction

function! keymap#select_register()
	registers
	let c = nr2char(getchar())
	redraw
	execute 'normal! "' . c
endfunction

let keymap#in_macro = v:false
function! keymap#set_macro()
	if g:keymap#in_macro
		let g:keymap#in_macro = v:false
		execute 'normal! q'
	else
		registers
		let c = nr2char(getchar())
		if c == '^['
			return
		endif
		let g:keymap#in_macro = v:true
		redraw
		execute 'normal! q' . c
	endif
endfunction

function! keymap#evoke_macro()
	registers
	let c = nr2char(getchar())
	redraw
	execute 'normal! @' . c
endfunction

function keymap#abort_popup()
	return pumvisible() ? "\<C-e>" : ''
endfunction

function keymap#accept_popup()
	return pumvisible() ? "\<C-y>" : ''
endfunction
