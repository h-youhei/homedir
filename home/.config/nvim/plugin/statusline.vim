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
	return substitute(getcwd(), '/home/[^/]*/', '~/', '')
endfunction

"/i/i/i/iiii/iiii/iiii
"function! (path)
"	l:levels = count('/', a:path)
	"l:n_truncates = l:levels - 3


set statusline=%!statusline#make_statusline()
