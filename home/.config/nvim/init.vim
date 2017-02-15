if has('vim_starting')
	set encoding=utf-8
endif

"avoid duplicate autocmd
augroup init
	autocmd!
augroup END

let init#conf_dir = expand('$XDG_CONFIG_HOME/nvim/conf.d')

execute 'source ' . init#conf_dir . '/plugin.vim'

filetype plugin indent on
syntax on

"for more information, run this command
":help 'option_name'

set wildmode=list,full

set diffopt& dip+=vertical

set clipboard=unnamed

"fold
"set foldmethod
"set foldopen
"set thesaurus=

"set helpheight
"set highlight

"file
set fileencoding=utf-8
"LF, CR or both depend on OS
set fileformat=unix
"detection priority
set fileencodings=ucs-bom,utf-8,iso-2022-jp,cp932,sjis,euc-jp,default,latin1
set fileformats=unix,dos,mac

"indent
set copyindent
set shiftwidth=4
set softtabstop=4
set tabstop=4

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

"show the command that is being typed
set showcmd

"always
set showtabline=2

"set matchpairs& mps+=<:>

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

"when to open new buffer in same window
set bufhidden=hide

"increment
set nrformats=alpha,bin,hex

"set imcomdline
set iminsert=0
set imsearch=0

"when to move pointer
set mousefocus

"auto real line break
set textwidth=0

"Allowed left/right keys to move prev/next line at start/end of the line
set whichwrap=

"make non ascii sign full-width
set ambiwidth=double

set complete=k,d,t

set spelllang=en_us,cjk

augroup init
"restore cursor position
	autocmd BufReadPost * call init#restore_cursor()
	autocmd BufNewFile * startinsert
	autocmd FileType gitcommit startinsert
	autocmd FileType * setlocal formatoptions& fo+=rnmM fo-=tc
	autocmd TermClose * call feedkeys("\<CR>")
augroup END

function! init#restore_cursor()
	if line("'\"") > 1 && line("'\"") <= line("$")
		normal! g`"
	endif
endfunction

execute 'source ' . init#conf_dir . '/keymap.vim'
