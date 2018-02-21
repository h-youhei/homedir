let g:ibus#layout = 'xkb:us::eng'
let g:ibus#engine = 'mozc-jp'

let s:dein_dir = expand('$XDG_CACHE_HOME/dein')
let s:dein_runtime = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_runtime)
	exe 'call system("git clone https://github.com/Shougo/dein.vim ' . s:dein_runtime . '")'
endif

exe 'set runtimepath& rtp+=' . s:dein_runtime
if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	call dein#load_toml(init#conf_dir . '/plugin.toml')

	call dein#local(expand('$HOME/workspace/vim-plugins/enable'))
	call dein#end()

	call dein#save_state()
endif

if dein#check_install()
	call dein#install()
endif

command! Recache call dein#recache_runtimepath()
command! Update call dein#update()
command! RPlug call dein#remote_plugins()
