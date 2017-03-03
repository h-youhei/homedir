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

function! capslock#inactivate_with_state()
	let b:was_capslock_on = capslock#is_on()
	call capslock#inactivate()
endfunction

function! capslock#restore_state()
	if b:was_capslock_on
		call capslock#activate()
	else
		call capslock#inactivate()
	endif
endfunction
