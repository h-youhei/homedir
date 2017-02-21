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
	let l:state = system('fcitx-remote')
	return l:state == 2 ? 1 : 0
endfunction

function! s:inactivate_with_state()
	let b:was_fcitx_on = fcitx#is_on()
	call fcitx#inactivate()
endfunction

function! s:restore_state()
	if b:was_fcitx_on
		call fcitx#activate()
	else
		call fcitx#inactivate()
	endif
endfunction

augroup fcitx
	autocmd!
	autocmd BufEnter,CmdwinEnter * let b:was_fcitx_on = 0
	autocmd InsertLeave * call s:inactivate_with_state()
	autocmd InsertEnter * call s:restore_state()
augroup END
