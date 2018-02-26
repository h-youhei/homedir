"To show help for options
"help 'option_name'

set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,cp932,sjis,euc-jp,default,latin1
"set fileformat=
"set fileformats=

set tabstop=4
set shiftwidth=0
set softtabstop=0
set copyindent

set ignorecase
set smartcase
set incsearch
set gdefault

set number
set relativenumber

set showcmd
set shortmess=aoOtTI
"always shown
set showtabline=2
set laststatus=2

set scrolloff=4
set display=lastline

set list
set listchars=tab:>_,trail:$,extends:<,precedes:>

"escape react fast, but escape can't be prefix.
"escape sequence is still able to use.
set notimeout
set ttimeout
set ttimeoutlen=10


set wildmode=list:longest,full

set diffopt& dip+=vertical

set bufhidden=hide

let s:tmp_dir = expand('/tmp/vim/$UID')
exe 'if !isdirectory("' . s:tmp_dir . '")'
	exe 'call mkdir("' . s:tmp_dir . '/undo", "p")'
	"exe 'call mkdir("' . s:tmp_dir . '/backup")'
endif

"buffer, mark, register, input, size, nohlsearch
exe "set viminfo=%,'10,@0,s1,h,n" . s:tmp_dir . '/viminfo'
set history=20
set undofile
exe 'set undodir=' . s:tmp_dir . '/undo'
set sessionoptions=blank,buffers,curdir,folds,localoptions,help,tabpages,winpos,winsize
"set backup
"exe 'set backupdir=' . s:tmp_dir . '/backup'

set mousefocus

set nrformats=alpha,hex

"cursor key
set whichwrap=<,>,[,]

"current file, dictionary, included definition, tag
set complete=.,k,d,t

":help fo-table
set formatoptions& fo+=rnjM fo-=t
set nowrap

set autochdir
