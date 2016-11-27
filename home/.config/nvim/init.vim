if has('vim_starting')
	set encoding=utf-8
endif

scriptencoding utf-8

augroup init
	autocmd!
augroup END

let init#conf_dir = expand('$XDG_CONFIG_HOME/nvim/conf.d')

"plugin manager(dein)
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

	function! init#plugin_update()
		if dein#check_update()
			call dein#update()
		endif
	endfunction
endif

filetype plugin indent on
syntax on

":help 'option_name'

set wildmode=list:longest,full

set diffopt& dip+=vertical

set clipboard=unnamed

"fold
"set foldmarker
"set foldmethod
"set foldopen
"set thesaurus=

"set helpheight
"set highlight

"soft linebreak
"set linebreak
" set breakat& brk+= (default SpaceTab!@*-+;:,./?)
set breakindent

set fileencoding=utf-8
"LF, CR or both depend on OS
set fileformat=unix
"detection priority
set fileencodings=ucs-bom,utf-8,iso-2022-jp,cp932,sjis,euc-jp,default,latin1
set fileformats=unix,dos,mac

" set noautoindent (default on)
" set smartindent
set shiftwidth=4
set softtabstop=4
set tabstop=4
set copyindent

"Search
set ignorecase
set smartcase
set incsearch
set nohlsearch

"global substitution
set gdefault

"line number
set number
set relativenumber

"show be typing
set showcmd

set statusline=%{getcwd()}\ \ \ %=%t%m%r%h%w\ %y[%{&fileformat}][%{&fileencoding}]\ \ 0x%B\ (%lL,%cC)\ %LL(%p%%)

set matchpairs& mps+=<:>

"only one key escape seaquence
set notimeout
set ttimeout
set ttimeoutlen=10

"show invisible charcters
set list
set listchars=tab:>_,trail:$,extends:<,precedes:>

"set history
set shada=!,%,'100,:0,<50,@0,h,s10
set viewoptions=cursor,folds,localoptions
set sessionoptions=blank,buffers,curdir,folds,localoptions,help,tabpages,winpos
set undofile

set shortmess=aoOtTI


"同じウィンドウで新しいファイルを開いた時、元のバッファを隠す
set bufhidden=hide

"increment
set nrformats=alpha,bin,hex

"set imcomdline
set iminsert=0
set imsearch=0

"when to move pointer
set mousefocus


"r  改行時にコメント開始文字列を自動挿入
"n  テキスト整形時、formatlistpatで指定されたリストを認識する
"mM 改行、連結時の日本語サポート
"auto real line break
set textwidth=0
set formatoptions& fo+=nmM

"Allowed keys to move left/right at line head/end
set whichwrap=b,s,h,l,<,>,[,]

"全角記号を全角幅で表示
set ambiwidth=double


set complete=k,d,t

set spelllang=en_us,cjk

augroup init
"restore cursor position
	autocmd BufReadPost * normal! g`"
	autocmd BufNewFile * startinsert
	autocmd FileType gitcommit startinsert
	autocmd TermClose * call feedkeys("\<CR>")
augroup END


execute 'source ' . init#conf_dir . '/keymap.vim'
