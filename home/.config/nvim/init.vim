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
	execute 'set runtimepath^=' . s:dein_runtime
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

"ファイルタイプの自動判別とそれに関連する機能
filetype plugin indent on
"シンタックスハイライト
syntax on

"TODO
"wild
set wildmode=list,full
"set diffopt=
"set fold
"set pastetoggle
"set path=.,
"set thesaurus=
" エディタ外でのファイルが変更されたとき、読み込みなおす
" set autoread(default on)

" 表示するバッファを変えたときなどに自動で保存(保存する場面については:help 'autowrite')
" set autowrite(default off)
" set autowriteall(default off)
"set cindent
"set cinkeys
"set cinoptions
"set cinwords
"cscope
"set helpheight
"set highlight
"set switchbuf
set clipboard& clipboard^=unnamed
"set history

" 自動改行
" set breakat (default \" ^I!@*-+;:,./?\")
" set breakindent (default off)
" set breakindentopt (min:, shift:, sbr)
" set linebreak

"バックアップ
"set backup
"バックアップファイルの保存先
"set backupdir=$HOME/.backup/vim
"TODO END


"オプション
"新規ファイルのエンコード
set fileencoding=utf-8
"エンコード自動認識で当てはまるエンコードが複数ある時の優先順位
set fileencodings=ucs-bom,utf-8,iso-2022-jp,cp932,sjis,euc-jp,default,latin1
"新規ファイルの改行コード
set fileformat=unix
"改行コード自動認識の判定順
set fileformats=unix,dos,mac

"インデント
"インデント維持
" set autoindent (default on)
"タブ幅、全て同じ数値にすることでシンプルなタブになる
set shiftwidth=4
set softtabstop=4
set tabstop=4

"検索
"小文字のみの場合、大文字と小文字を区別しない
set ignorecase
set smartcase

"インクリメンタルサーチ
set incsearch
set nohlsearch

"該当する文字列全てを置換
set gdefault

"UI
"現在行と相対的な行番号を表示
set number
set relativenumber
"行頭、行末での端に残す行
"set scrolloff=0
"タイプ中のコマンドを表示する
set showcmd
"ステータスバー
"ファイル名、属性、カーソル文字の16進数、ファイルタイプ、ルーラ
set laststatus=2
set statusline=\ %{getcwd()}%=%t%m%r%h%w\ \ 0x%B\ \ %y[%{&fileformat}][%{&fileencoding}]\ \ %lL,%cC\ \ %LL(%p%%)\ 
set matchpairs& matchpairs^=<:>

"挿入モードなどでEscから始まるマッピングを無効化
"set noesckeys
set notimeout
set ttimeout
set ttimeoutlen=10

":set listで可視化する文字の表示方法
set list
set listchars=tab:>_,trail:$,extends:<,precedes:>,nbsp:%

"ビューファイルを作るときの設定
set viewoptions=cursor,folds,options,slash,unix

"shadaファイルの設定
"! 大文字のみで構成される環境変数の保存
"% バッファの保存
"' マークを記憶するファイル数
"< レジスタで保存される行数
"s 保存されるアイテムの最大サイズ(kB)
"n 保存場所
set shada=!,%,'100,s100

"set sessionoptions=

"メッセージの表示を簡略化または無効化
"s  検索
"tT 表示領域が足りない場合に一部のみ表示
"I  スタートページ
set shortmess=aoOtTI

set undofile

"同じウィンドウで新しいファイルを開いた時、元のバッファを隠す
set bufhidden=hide

"インクリメントとデクリメント
"alpha アルファベットに対しても行う
"bin   0bから始まる数を2進数として扱う
"hex   0xから始まる数を16進数として扱う
set nrformats=alpha,bin,hex

"挿入モードと検索モードに初めて入った時にIMEをオフにする
"set imcomdline
set iminsert=0
set imsearch=0

"自動改行された行を一部でも表示する
set display=lastline

"tc テキスト、コメントでtextwidthに設定された数に達すると自動で改行する(本当に改行される)
"   >機能させるにはtextwidthに自然数を設定する
"r  改行時にコメント開始文字列を自動挿入
"q  gqでコメントを整形する
"n  テキスト整形時、formatlistpatで指定されたリストを認識する
"mM 改行、連結時の日本語サポート
"j  コメントの連結をスマートに
set textwidth=0
set formatoptions=tcqnmMj

"行頭、行末で横にカーソルを移動した時、行を移動できない
set whichwrap=

"全角記号を全角幅で表示
set ambiwidth=double


"補完
set complete=k,.,i,w,b,u,t

set spelllang=en_us,cjk

augroup init
"restore cursor position
	autocmd BufReadPost * normal! g`"
	autocmd BufNewFile * startinsert
	autocmd TermClose * call feedkeys("\<CR>")
augroup END

"外部ファイル
execute 'source ' . init#conf_dir . '/keymap.vim'
