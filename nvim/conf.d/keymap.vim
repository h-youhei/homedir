
"in case make mistake
noremap ZZ <Nop>
noremap ZQ <Nop>

noremap <Space> <Nop>

"note

"prefix key
"map to <Nop> in order to prevent default mapping when type prefix key then <Esc>

"nnoremap <CR>r :<C-u>!ls<CR>:read<Space>

"%s grep
"noremap ` :!grep -F -r<Space>
"noremap ~ :!grep -E -r<Space>

"start insert
noremap <Space>a ea
noremap <Space>A Ea
noremap <Space>i bi
noremap <Space>I Bi
noremap <Space>o gi

"start visual
noremap <Space>v gv

"operator
nnoremap <Space>c ciw
nnoremap <Space>C ciW
nnoremap C cc

nnoremap <Space>d daw
nnoremap <Space>D daW
nnoremap D dd

nnoremap <Space>y yaw
nnoremap <Space>Y yaW
nnoremap Y yy

vnoremap u U
vnoremap U u

"sequencial number
"TODO: only visual block
"TODO: handle count
xnoremap + I0<Esc>gvg<C-a>

"Joint
nnoremap <expr> j (&diff ? ']c' : 'J')
nnoremap <expr> J (&diff ? '[c' : 'i<CR><Esc>')

"delete char
onoremap <Del> <Space>
onoremap <BS> <BS>
"Delete char with no register
nnoremap <Del> "_x
xnoremap <Del> x
nnoremap <S-Del> "_s
xnoremap <S-Del> s
nnoremap <BS> "_X
xnoremap <BS> X
"can't recognize S-BS in terminal
"nnoremap <S-BS> "_Xi
"xnoremap <S-BS> Xi

"Undo
nnoremap U <C-r>

"Mark
noremap m `
noremap M '
noremap @ m

"key macro
nnoremap & q
nnoremap k :<C-u>call keymap#evoke_macro()<CR>
"repeat
nnoremap K @@

"History
"jumplist
noremap h <C-o>
noremap H <C-i>
"changelist
noremap <nowait> z g;
noremap <nowait> Z g,

"search
noremap # *
noremap * #
noremap <expr> / (im#restore_state() . '/\V')
noremap <expr> ? (im#restore_state() . '?\V')
cnoremap <expr> <CR> (im#inactivate_with_state() . '<CR>')
cnoremap <expr> <Esc> (im#inactivate_with_state() . '<End><C-u><BS>')
noremap <Space>n gn
noremap <Space>N gN

"find
noremap , ;
noremap < ,

"Substitute
noremap - :s/\V
nnoremap _ :%s/\V
nnoremap <silent> > :&&<CR>

"motion
noremap ][ ]]
noremap ]] ][

noremap <Space>e ge
noremap <Space>E gE
"paragraph
noremap } })
noremap { {)
noremap <Space>} }<BS>0
noremap <Space>{ {<BS>0

noremap <expr> <Up> (v:count ? 'k' : 'gk')
inoremap <expr> <Up> (keymap#accept_popup() . '<C-o>gk')
noremap <expr> <Down> (v:count ? 'j' : 'gj')
inoremap <expr> <Down> (keymap#accept_popup() . '<C-o>gj')

noremap <Home> ^
noremap <End> $
inoremap <Home> <C-o>^
inoremap <End> <C-o>$

noremap <Space><PageUp> zw
noremap <Space><PageDown> zt
noremap <Space><Space> zz

"jump
noremap <nowait> g gg
noremap <Space><Space> M
"can't recognize
"noremap <S-Space> gm
noremap <Space><Up> H
noremap <Space><Down> L
noremap <Space><Left> g0
noremap <Space><Right> g$

noremap <Space><Home> zs
noremap <Space><End> ze

"git Project root
"nnoremap cp :<C-u>exe 'cd' system('git rev-parse --show-toplevel 2>/dev/null')<CR>

"Diff, paste
nnoremap <expr> o (&diff ? 'do' : 'o')
nnoremap <expr> p (&diff ? 'dp' : ']p')
noremap P [p


"nnoremap kr :read !
"nnoremap ! shell command
xnoremap ! :!
"REPL
nnoremap <Space>: gQ


"Look into
noremap L g<C-]>
nnoremap <A-l> :<C-u>tags<CR>:tag<Space>
nnoremap <A-L> :<C-u>tjump<Space>


"Quit
"for editor on terminal approach
nnoremap q :<C-u>cclose<CR>:quit<CR>
nnoremap <Space>q! :<C-u>cclose<CR>:quit!<CR>
nnoremap <Space>qa :<C-u>qall<CR>
nnoremap Q :<C-u>xit<CR>

"for always in editor approach
"nnoremap q :<C-u>bdelete<CR>
"nnoremap <Space>q! :<C-u>bdelete!<CR>
"nnoremap Q :<C-u>update<CR>:bdelete<CR>

"save
nnoremap + :<C-u>update<CR>

"Find
"f F
noremap <A-f> f<C-k>
noremap <A-F> F<C-k>

"Replace
"r R
noremap <A-r> r<C-k>

"Take
"t T
noremap <A-t> t<C-k>
noremap <A-T> T<C-k>


"setting
"toggle options
nnoremap \ <Nop>
nnoremap \<CR> :<C-u>setl linebreak!<CR>
nnoremap \b :<C-u>setl backup!<CR>
nnoremap \c :<C-u>setl autochdir!<CR>
nnoremap \f :<C-u>setl foldenable!<CR>
nnoremap \h :<C-u>setl hlsearch!<CR>
nnoremap \i :<C-u>setl autoindent!<CR>
nnoremap \l :<C-u>setl list!<CR>
nnoremap \n :<C-u>setl relativenumber!<CR>
nnoremap \p :<C-u>setl paste!<CR>
nnoremap \s :<C-u>setl spell!<CR>
nnoremap \t :<C-u>setl expandtab!<CR>
nnoremap \w :<C-u>setl wrap!<CR>

"reload
nnoremap <Bar>v :<C-u>source $MYVIMRC<CR>

"Register
"* + 0 a-z A-Z % # / :
noremap ' "+
noremap <Space>' "0

"nnoremap ` flip boolean

"adjust
nnoremap = ==

"quickfix
" nnoremap <A-\> :<C-u>copen<CR>
" nnoremap <A-Bar> :<C-u>cclose<CR>
"noremap <A-)> :cnext<CR>
"noremap <A-(> :cNext<CR>
" augroup my
	"toggle focusing quickfix
" 	au BufReadPost quickfix noremap <buffer> <A-\> <C-w>k
" 	au BufReadPost quickfix noremap <buffer> <CR> <CR>
" augroup END

noremap ^ zA

"insert a char
noremap <silent> <Insert> :<C-u>call keymap#insert_a_char()<CR>
" noremap <silent> <A-Insert> :<C-u>call keymap#insert_a_digraph()<CR>
" noremap <silent> <CR> :<C-u>call keymap#append_a_char()<CR>
" noremap <silent> <A-CR> :<C-u>call keymap#append_a_digraph()<CR>

"indent
nnoremap <Tab> >>
nnoremap <S-Tab> <<
xnoremap <Tab> >
xnoremap <S-Tab> <
noremap <Space><Tab> :left<CR>

"window controll
"help
"nnoremap <A-h> :<C-u>call system('urxvtc -e nvim "-c help" "-c only"')<CR>

noremap <A-Space> <C-w>w

"terminal
nnoremap <A-t> :<C-u>call system('urxvtc')<CR>

"vim
nnoremap <A-CR> :<C-u>exe "call system('urxvtc -e nvim -R " . @% . "')"<CR>
"update then quit

"adjust window size
nnoremap <A-=>= <C-w>=

"2pain
nnoremap <A-v> :<C-u>vertical ball 2<CR>
nnoremap <A-h> :<C-u>ball 2<CR>
"accept completion
inoremap <expr> <C-a> keymap#accept_popup()

"insert mode
"move wordwise
noremap! <C-b> <S-Left>
noremap! <C-w> <S-Right>
"Delete word
noremap! <C-d> <C-w>
"join
inoremap <C-j> <C-o>J

"yank previous line
inoremap <C-y> <C-r>=getline(line('.') - 1)<CR>
"pull next line
inoremap <C-p> <C-r>=getline(line('.') + 1)<CR>

"move paragraph wise
"inoremap <C-{> <C-o>}<C-o>)
"inoremap <C-}> <C-o>{<C-o>)

"indent
inoremap <expr> <Tab> (pumvisible() ? '<C-n>' : '<C-t>')
inoremap <expr> <S-Tab> (pumvisible() ? '<C-p>' : '<C-d>')
inoremap <A-Tab> <Tab>

inoremap <expr> <BS> (keymap#abort_popup() . '<BS>')

inoremap <expr> <CR> (keymap#accept_popup() . '<CR>')
"CR and put cursor on begging of line
"inoremap <expr> <C-CR> (keymap#accept_popup() . '<CR><C-o>:left<CR>')

"`^ keep cursor after leaving insert
inoremap <expr> <Esc> (keymap#accept_popup() . '<Esc>')

"read from file by Denite
";r
