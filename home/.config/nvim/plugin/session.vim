"if vim is passed file argument, the session isn't managed except there isn't session file.
"elseif there is project file, the session is managed as project.
"else, the session is managed.


let s:default_session = expand("$XDG_DATA_HOME/nvim/session.vim")
let s:project_session = '.project.vim'

function! s:init()
	let g:session#is_managed = v:false
	let g:session#is_project = v:false

	if argc() != 0
		let g:session#is_managed = !filereadable(expand(s:default_session))
		return
	endif
	
	if !s:is_buffer_empty()
		return
	endif

	let g:session#is_managed = v:true
	call s:restore_session()
endfunction

function! s:terminate()
	if g:session#is_managed
		call s:save_session()
	endif
endfunction

function! s:save_session()
	if g:session#is_project
		"assert_true(exists("session#project_dir"))
		if isdirectory(g:session#project_dir)
			execute 'cd' expand(g:session#project_dir)
			execute 'mksession!' s:project_session
		endif
	else
		execute 'mksession!' s:default_session
	endif
endfunction

function! s:restore_session()
	if filereadable(expand(s:project_session))
		execute 'source' s:project_session
		call s:set_project()
	elseif filereadable(expand(s:default_session))
		execute 'source' s:default_session
	endif
endfunction

function! session#make_project()
	execute 'mksession!' s:project_session
	call s:set_project()
endfunction

function! s:set_project()
	let g:session#is_project = v:true
	let g:session#project_dir = getcwd()
endfunction

function! s:is_buffer_empty()
	return bufname('%') == ''
endfunction

augroup session
	autocmd!
	autocmd VimEnter * nested call s:init()
	autocmd VimLeave * call s:terminate()
augroup END
