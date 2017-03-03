function! path#home_to_tilde(path)
	return substitute(a:path, '^/home/[^/]*/', '~/', '')
endfunction

function! path#shorten(path, n)
	if a:n < 1
		throw 'too low'
	endif
	let path = split(a:path, '/', v:true)
	let init = path[0:-2]
	let last = path[-1]
	let init = map(path, 'v:val[0:a:n-1]')
	let path = add(init, last)
	return join(path, '/')
endfunction
