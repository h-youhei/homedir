"return '' is for map <expr>

function! ibus#inactivate()
	exe "call system('ibus engine " . g:ibus#layout . "')"
	return ''
endfunction

function! ibus#activate()
	exe "call system('ibus engine " . g:ibus#engine . "')"
	return ''
endfunction

function! ibus#toggle()
	if ibus#is_on()
		return ibus#inactivate()
	else
		return ibus#activate()
	endif
endfunction

function! ibus#is_on()
	return system('ibus engine') == g:ibus#engine ? v:true : v:false
endfunction
