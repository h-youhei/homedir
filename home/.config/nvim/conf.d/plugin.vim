let s:dein_dir = expand('$XDG_CACHE_HOME/dein')
let s:dein_runtime = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if isdirectory(s:dein_runtime)
	execute 'set runtimepath& rtp+=' . s:dein_runtime
	call dein#begin(s:dein_dir)

	call dein#load_toml(init#conf_dir . '/dein.toml', {'lazy':0})
	call dein#load_toml(init#conf_dir . '/dein_lazy.toml', {'lazy':1})

	if dein#check_install()
		call dein#install()
	endif

	function! plugin#plugin_update()
		if dein#check_update()
			call dein#update()
		endif
	endfunction
endif
