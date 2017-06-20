let g:ibus#layout = 'xkb:us::eng'
let g:ibus#engine = 'replace-with-kanji-python'

let s:dein_dir = expand('$XDG_CACHE_HOME/dein')
let s:dein_runtime = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let s:conf_dir = init#conf_dir . '/plugin'

if !isdirectory(s:dein_runtime)
	exe 'call system("git clone https://github.com/Shougo/dein.vim ' . s:dein_runtime . '")'
endif

exe 'set runtimepath& rtp+=' . s:dein_runtime
if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	call dein#load_toml(s:conf_dir . '/main.toml')

	call dein#load_toml(s:conf_dir . '/sandwich.toml')
	call dein#load_toml(s:conf_dir . '/denite.toml')
	call dein#load_toml(s:conf_dir . '/open-browser.toml')
	call dein#load_toml(s:conf_dir . '/deoplete.toml')
	call dein#load_toml(s:conf_dir . '/neosnippet.toml')

	call dein#local(expand('$HOME/workspace/vim-plugins/enable'))

	call dein#end()
	call dein#save_state()
endif

if dein#check_install()
	call dein#install()
endif
