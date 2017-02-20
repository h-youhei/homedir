execute 'source ' . expand('$HOME/.vim') . '/init.vim'

set shada=!,%,'100,:0,<50,@0,h,s10

augroup init
	autocmd TermClose * call feedkeys("\<CR>")
augroup END
