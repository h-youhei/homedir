function! statusline#make_statusline()
	let l:cur_dir = s:make_cwd()
	let l:filetype = '%y'
	let l:format = '[%{&fileformat}]'
	let l:encoding = '[%{&fileencoding}]'
	let l:codepoint = '0x%B'
	let l:position = '(%lL,%cC)'
	let l:lines = '%LL(%p%%)'

	return l:cur_dir . '    ' . '%=' . l:filetype . l:encoding . '  ' . l:codepoint . ' ' . l:position . ' ' . l:lines
endfunction

function! s:make_cwd()
	let l:cwd = substitute(getcwd(), '^/home/[^/]*/', '~/', '')
	let l:cwd = substitute(l:cwd, '\~/workspace/', 'WS/', '')
	return l:cwd
endfunction


set statusline=%!statusline#make_statusline()
