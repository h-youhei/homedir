noremap <Space> <Nop>
noremap <CR> <Nop>
augroup my
	au BufReadPost quickfix noremap <buffer> <CR> <CR>
augroup END

"buffer by denite.vim
"<Space>b

"close
nnoremap <Space>c :<C-u>tabclose<CR>
nnoremap <Space>C :<C-u>tabs<CR>:tabclose<Space>

"diff
nnoremap <Space>d :<C-u>windo diffthis<CR>
nnoremap <Space>D :<C-u>windo diffoff<CR>

"edit by denite.vim
"<Space>e from cwd(current working directory)
"<Space>E from mru(most recently used)

"open the file whose name is under the cursor
nnoremap <Space>f gF

"help
nnoremap <Space>h :<C-u>call system('urxvtc -e nvim "-c help" "-c only"')<CR>

"mimic
nnoremap <Space>m :<C-u>split<CR>

"next
noremap <Space>n <C-w>w
noremap <Space>N <C-w>W

"open
nnoremap <Space>n :<C-u>enew<CR>

"print
nnoremap <Space>pc :<C-u>changes<CR>
nnoremap <Space>pm :<C-u>marks<CR>
nnoremap <Space>pr :<C-u>registers<CR>
nnoremap <Space>pj :<C-u>jumps<CR>
nnoremap <Space>pt :<C-u>tags<CR>

"reopen
"This is useful after recovering from swap file
noremap <silent> <Space>r :<C-u>edit<CR>

"by openbrowser
"<Space>s

"terminal
nnoremap <Space>t :<C-u>call system('urxvtc')<CR>

"unload
nnoremap <Space>u :<C-u>bdelete<CR>
"by denite
"<CR>U

"vim
nnoremap <Space>v :<C-u>call system('urxvtc -e  nvim')<CR>

"update then quit
nnoremap <Space>x :<C-u>update<CR>:bdelete<CR>
nnoremap <Space>X :<C-u>xit<CR>

"REPL
nnoremap <Space>: gQ

"adjust window size
nnoremap <Space>= <C-w>=

"open
nnoremap <CR>v :<C-u>vertical split<CR>
nnoremap <CR>h :<C-u>split<CR>
nnoremap <CR>t :<C-u>tabnew<CR>

"2pain
nnoremap <CR>V :<C-u>vertical ball 2<CR>
nnoremap <CR>H :<C-u>ball 2<CR>
