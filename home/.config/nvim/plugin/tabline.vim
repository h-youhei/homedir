function! tabline#make_tabline()
	let l:label = ''
	let l:number_of_tabpage = tabpagenr('$')
	for i in range(l:number_of_tabpage)
		let l:i_tab = i + 1
		let l:style = s:style(l:i_tab)
		let l:index = s:index(l:i_tab)
		let l:name = s:name(l:i_tab)
		let l:modified = s:modified(l:i_tab)
		let l:label .= l:style . ' ' . l:index . l:name . l:modified . ' '
	endfor
	return l:label . '%#TabLineFill#'
endfunction

function! s:style(i)
	let l:current_tabpage = tabpagenr()
	return a:i == l:current_tabpage ? '%#TabLineSel#' : '%#TabLine#'
endfunction

function! s:index(i)
	":help stl
	return '%T' . a:i . ':'
endfunction

function! s:name(i)
	let l:current_window = tabpagewinnr(a:i)
	let l:buffer_list = tabpagebuflist(a:i)
	let l:current_buffer = l:buffer_list[l:current_window - 1]
	let l:name = bufname(l:current_buffer)
	if l:name == ''
		let l:name = &buftype == 'quickfix' ? '[Quickfix]' : '[No Name]'
	else
		let l:name = s:strip_directory(l:name)
	endif
	return l:name
endfunction

function! s:modified(i)
	let l:buffer_list = tabpagebuflist(a:i)
	for l:buffer in l:buffer_list
		if getbufvar(l:buffer, "&modified")
			let l:modified = ' [+]'
			break
		else
			let l:modified = ''
		endif
	endfor
	return l:modified
endfunction

function! s:strip_directory(path)
	return fnamemodify(a:path, ':t')
endfunction

set tabline=%!tabline#make_tabline()
