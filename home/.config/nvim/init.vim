augroup my
	au!
augroup END

let g:loaded_2html_plugin = 1
let g:loaded_gzip = 1
let g:loaded_zip_plugin = 1
let g:loaded_matchit = 1
"let g:loaded_matchparen = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwSetting = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_rrhelper = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_ruby_provider = 1
let g:loaded_python_provider = 1
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1

let init#conf_dir = expand('$XDG_CONFIG_HOME/nvim/conf.d')

exe 'source' init#conf_dir . '/plugin.vim'

filetype plugin indent on
syntax on

exe 'source' init#conf_dir . '/option.vim'
exe 'source' init#conf_dir . '/autocmd.vim'
exe 'source' init#conf_dir . '/keymap.vim'
exe 'source' init#conf_dir . '/bar.vim'

if has('gui_running')
	exe 'source' init#conf_dir . '/gui.vim'
endif

colorscheme youhei
