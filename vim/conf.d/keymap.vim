"Remove dangerous mapping
noremap ZZ <Nop>
noremap ZQ <Nop>

"To use as prefix key
noremap <Space> <Nop>
onoremap <nowait> <Space> <Space>

nnoremap <Space>c ciw
nnoremap <Space>C ciW
nnoremap C cc

nnoremap <Space>d daw
nnoremap <Space>D daW
nnoremap D dd

nnoremap <Space>y yaw
nnoremap <Space>Y yaW
nnoremap Y yy

noremap <S-Del> s
noremap <BS> "_X

nnoremap U <C-r>

noremap - :s/
nnoremap _ :%s/
nnoremap <silent> > :&&<CR>

noremap , ;
noremap < ,

noremap h <C-o>
noremap H <C-i>

nnoremap q :<C-u>quit<CR>
nnoremap Q :<C-u>xit<CR>

noremap <expr> <Up> (v:count ? 'k' : 'gk')
inoremap <Up> <C-o>gk
noremap <expr> <Down> (v:count ? 'j' : 'gj')
inoremap <Down> <C-o>gj
noremap <Home> ^
inoremap <Home> <C-o>^
noremap <End> $
inoremap <End> <C-o>$

nnoremap = ==
nnoremap <Tab> >>
nnoremap <S-Tab> <<
xnoremap <Tab> >
xnoremap <S-Tab> <
noremap <Space><Tab> :left<CR>
