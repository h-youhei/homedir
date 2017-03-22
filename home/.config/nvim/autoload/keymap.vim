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

function! keymap#capitalize_word()
	let pos = getpos('.')
	norm! guiwgUl
	call setpos('.', pos)
	return ''
endfunction

function! keymap#capitalize_line()
	let pos = getpos('.')
	norm! ^gUl
	call setpos('.', pos)
	return ''
endfunction

function! keymap#downcase_word()
	let pos = getpos('.')
	norm! guiw
	call setpos('.', pos)
	return ''
endfunction

function! keymap#downcase_line()
	let pos = getpos('.')
	norm! gu^
	call setpos('.', pos)
	return ''
endfunction

function! keymap#upcase_word()
	let pos = getpos('.')
	norm! gUiw
	call setpos('.', pos)
	return ''
endfunction

function! keymap#upcase_line()
	let pos = getpos('.')
	norm! gU^
	call setpos('.', pos)
	return ''
endfunction

"TODO: start with WORD char
function! keymap#get_above_word()
	let n_line = line('.')
	let n_col = col('.')
	if n_line == 1
		return ''
	endif
	let cur_line = strpart(getline(n_line), 0, n_col)
	let prev_line = getline(n_line - 1)
	let word_count = util#match_count(cur_line, '\v<\S*') + 1
	return matchstr(prev_line, '\v<\S*', 0, word_count)
endfunction

function! keymap#get_below_word()
	let n_line = line('.')
	let n_col = col('.')
	if n_line == line('$')
		return ''
	endif
	let cur_line = strpart(getline(n_line), 0, n_col)
	let next_line = getline(n_line + 1)
	let word_count = util#match_count(cur_line, '\v<\S*') + 1
	return matchstr(next_line, '\v<\S*', 0, word_count)
endfunction
