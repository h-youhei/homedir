":help 'option_name'

set wildmode=list:longest,full

set diffopt& dip+=vertical

set clipboard=unnamed

"fold
set foldmethod=marker
set foldcolumn=1
"set foldopen

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

"always shown
set laststatus=2
set showtabline=2

"If last line is wrapped, it's shown as much as possible.
set display=lastline

set matchpairs& mps+=<:>,「:」,『:』,（:）,〈:〉,《:》,【:】

"only one key escape seaquence
set notimeout
set ttimeout
set ttimeoutlen=10

"show invisible charcters
set list
set listchars=tab:>_,trail:$,extends:<,precedes:>

"set history
set shada=!,%,'10,h,s1
set history=20
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

"auto real line break
set textwidth=0

"Allowed left/right keys to move prev/next line at start/end of the line
set whichwrap=

set complete=k,i,t

augroup my
	au FileType * setlocal formatoptions& fo+=rnmM fo-=tc
augroup END
