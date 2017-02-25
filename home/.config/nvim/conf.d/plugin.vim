let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_ruby_provider = 1
let g:loaded_python_provider = 1
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1

let s:dein_dir = expand('$XDG_CACHE_HOME/dein')
let s:dein_runtime = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if isdirectory(s:dein_runtime)
	execute 'set runtimepath& rtp+=' . s:dein_runtime
	if dein#load_state(s:dein_dir)
		call dein#begin(s:dein_dir)

		call dein#load_toml(init#conf_dir . '/dein.toml', {'lazy':0})
		call dein#load_toml(init#conf_dir . '/dein_lazy.toml', {'lazy':1})

		call dein#local(expand('$HOME/workspace/vim-plugins'))

		call dein#end()
		call dein#save_state()
	endif

	if dein#check_install()
		call dein#install()
	endif

	function! plugin#update()
		if dein#check_update()
			call dein#update()
		endif
	endfunction
endif
