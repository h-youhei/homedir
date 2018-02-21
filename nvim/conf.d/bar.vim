function! bar#make_tabline()
	let cwd = getcwd()
	let cwd = path#home_to_tilde(cwd)
	if strlen(cwd) > &columns
		let cwd = path#shorten(cwd, 5)
		let len = strlen(cwd)
		if len > &columns
			let cwd = '<' . cwd[len - &columns - 1:]
		endif
	endif
	return '%#TabLineFill#' . cwd
endfunction

"help 'statusline'
set statusline=%t%m%r%=\ %<%y[%{&fileencoding}][%{&fileformat}]\ 0x%B\ (%c,%l/%L)
set tabline=%!bar#make_tabline()
