function! util#match_count(line,pattern)
	"because incrementing count happen even not match
	let counter = -1
	let i = 0
	while i != -1
		let i = matchend(a:line, a:pattern, i)
		let counter += 1
	endwhile
	return counter
endfunction
