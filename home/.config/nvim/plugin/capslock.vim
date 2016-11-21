"TODO windows mac

function! capslock#toggle()
	call system('xdotool key Caps_Lock')
endfunction

function! capslock#is_on()
	return system("xset q | grep LED | rev | cut -c1")
endfunction

function! capslock#inactivate()
	if capslock#is_on()
		call capslock#toggle()
	endif
endfunction

function! capslock#activate()
	if !capslock#is_on()
		call capslock#toggle()
	endif
endfunction

function! s:inactivate_with_state()
	let b:was_capslock_on = capslock#is_on()
	call capslock#inactivate()
endfunction

function! s:restore_state()
	if b:was_capslock_on
		call capslock#activate()
	else
		call capslock#inactivate()
	endif
endfunction

augroup capslock
	autocmd!
	autocmd BufEnter,CmdwinEnter * let b:was_capslock_on = 0
	autocmd InsertLeave * call s:inactivate_with_state()
	autocmd InsertEnter * call s:restore_state()
augroup END
