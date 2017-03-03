function! fcitx#inactivate()
	call system('fcitx-remote -c')
endfunction

function! fcitx#activate()
	call system('fcitx-remote -o')
endfunction

function! fcitx#toggle()
	call system('fcitx-remote -t')
endfunction

function! fcitx#is_on()
	return system('fcitx-remote') == 2 ? v:true : v:false
endfunction

function! fcitx#inactivate_with_state()
	let b:was_fcitx_on = fcitx#is_on()
	call fcitx#inactivate()
endfunction

function! fcitx#restore_state()
	if b:was_fcitx_on
		call fcitx#activate()
	else
		call fcitx#inactivate()
	endif
endfunction
