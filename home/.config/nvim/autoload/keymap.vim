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
		if c == "\e"
			redraw
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

function! keymap#abort_popup()
	return pumvisible() ? "\<C-e>" : ''
endfunction

function! keymap#accept_popup()
	return pumvisible() ? "\<C-y>" : ''
endfunction

function! keymap#mark_to_file()
	exe 'redir! >' expand('$HOME/.xmonad/mark')
	echo getcwd()
	redir END
endfunction

function! keymap#insert_a_char()
	let c = nr2char(getchar())
	execute 'normal! i' . repeat(c, v:count1)
endfunction

function! keymap#append_a_char()
	let c = nr2char(getchar())
	execute 'normal! a' . repeat(c, v:count1)
endfunction

function! keymap#insert_a_digraph()
	let c1 = nr2char(getchar())
	let c2 = nr2char(getchar())
	execute 'normal! i' . repeat("\<C-k>" . c1 . c2, v:count1)
endfunction

function! keymap#append_a_digraph()
	let c1 = nr2char(getchar())
	let c2 = nr2char(getchar())
	execute 'normal! a' . repeat("\<C-k>" . c1 . c2, v:count1)
endfunction
