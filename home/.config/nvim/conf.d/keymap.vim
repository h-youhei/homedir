"when press g etc mapped any command, it is not happen that refreshing the window.
"I guess that what I wrote just above won't happen if I map with <nowait>.
"Is this a bug?

scriptencoding utf-8

augroup keymap
	autocmd! keymap
augroup END

"in case make mistake
noremap ZZ <Nop>
noremap ZQ <Nop>

"to use as prefix key
"to prevent default mapping when type prefix key then <Esc>
noremap <Space> <Nop>
noremap <CR> <Nop>

"Inactivate IM and Capslock after command mode
"BUG always locate cursor at head
"nnoremap <expr><silent> <SID>Inactivate keymap#inactivate()
"cnoremap <silent><script> <CR> <CR><SID>Inactivate
"cnoremap <silent><script> <Esc> <Esc><SID>Inactivate
"function! keymap#inactivate()
"	let l:view = winsaveview()
"	call capslock#inactivate()
"	call fcitx#inactivate()
"	call winrestview(l:view)
"endfunction

"""Buffer/Tabpage/Window

nnoremap <A-o> :<C-u>tabnew<CR>
nnoremap <A-v> :<C-u>vnew<CR>
nnoremap <A-h> :<C-u>new<CR>
"switch horizontal or vertical
nnoremap <A-H> :<C-u>ball 2<CR>
nnoremap <A-V> :<C-u>vertical ball 2<CR>

"edit
nnoremap <CR>e :<C-u>update<CR>:!ls<CR>:edit<Space>

"open the file whose name is under the cursor
nnoremap <CR>o gF

"tag
nnoremap <CR>t :<C-u>tags<CR>:tag<Space>
nnoremap <CR>T :<C-u>tjump<Space>

"write/append to chosen file
nnoremap <CR>w :<C-u>write<Space>
nnoremap <CR>a :<C-u>write >><Space>

"close
nnoremap <CR>c :<C-u>tabclose<CR>
nnoremap <CR>C :<C-u>tabs<CR>:tabclose<Space>

"move to another tab
nnoremap <CR>m <C-w>t

"new
nnoremap <CR>n :<C-u>enew<CR>

"diff
nnoremap <CR>d :<C-u>windo diffthis<CR>
nnoremap <CR>D :<C-u>windo diffoff<CR>

"open same file as readonly
nnoremap <CR>v :<C-u>sview %<CR>

"adjust window size
nnoremap <CR>= <C-w>=

"file manage
nnoremap <CR>r :<C-u>!ls<CR>:read<Space>
nnoremap <CR>u :<C-u>update<CR>
nnoremap <CR>q :<C-u>quit<CR>
nnoremap <CR>Q :<C-u>quit!<CR>
nnoremap <CR><Space>q :<C-u>qall<CR>
nnoremap <CR><Space>Q :<C-u>qall!<CR>
"update then quit
nnoremap <CR>x :<C-u>xit<CR>
nnoremap <CR>X :<C-u>update<CR>:bdelete<CR>
nnoremap <CR><Space>x :<C-u>xall<CR>

"buffer
"show list of buffers then move to a buffer
nnoremap <CR>b :<C-u>update<CR>:ls<CR>:buffer<Space>
"hide
nnoremap <CR>h :<C-u>bdelete<CR>
nnoremap <CR>H :<C-u>ls<CR>:bdelete<Space>

"project
nnoremap <CR>P :<C-u>call project#make()<CR>

"print
nnoremap <nowait> <CR>pc :<C-u>changes<CR>
nnoremap <nowait> <CR>pm :<C-u>marks<CR>
nnoremap <nowait> <CR>pr :<C-u>registers<CR>
nnoremap <nowait> <CR>pj :<C-u>jumps<CR>
nnoremap <nowait> <CR>pt :<C-u>tags<CR>

"setting
"toggle options
nnoremap z <Nop>
nnoremap z_ :<C-u>setl list!<CR>
nnoremap zb :<C-u>setl backup!<CR>
nnoremap zc :<C-u>setl autochdir!<CR>
nnoremap zf :<C-u>setl foldenable!<CR>
nnoremap zh :<C-u>setl hlsearch!<CR>
nnoremap zi :<C-u>setl autoindent!<CR>
nnoremap zl :<C-u>setl linebreak!<CR>
nnoremap zm :<C-u>setl showmatch!<CR>
nnoremap zn :<C-u>setl relativenumber!<CR>
nnoremap zp :<C-u>setl paste!<CR>
nnoremap zs :<C-u>setl spell!<CR>
nnoremap zt :<C-u>setl expandtab!<CR>
nnoremap zw :<C-u>setl wrap!<CR>
"cursorbind
"scrollbind

"reload
nnoremap <nowait> Zv :<C-u>source $MYVIMRC<CR>
nnoremap <nowait> Zp :<C-u>call plugin#update()<CR>

"quickfix
nnoremap <nowait> x :<C-u>copen<CR>
nnoremap <nowait> X :<C-u>cclose<CR>
augroup keymap
	autocmd BufReadPost quickfix noremap <buffer><nowait> x <C-w>k
	autocmd BufReadPost quickfix noremap <buffer><nowait> <CR> <CR>
augroup END

"abbreviations
nnoremap $ <Nop>
nnoremap $p :<C-u>iabbrev <buffer><CR>
nnoremap $a :<C-u>iabbrev <buffer><Space>
nnoremap $d :<C-u>iunabbrev <buffer><Space>
nnoremap $D :<C-u>iabclear<CR>

"args
nnoremap @ <Nop>
nnoremap @p :<C-u>args<CR>
nnoremap @a :<C-u>argadd<Space>
nnoremap @d :<C-u>argdel<Space>
nnoremap @e :<C-u>argedit<Space>
"noremap @x :<C-u>argdo<Space>
"%s grep

"object range
"i a s

"object
"w word
"W WORD
"s sentence
"p paragraph
"b autoblock
"d delimiter
"f find
"t tag

omap ib <Plug>(textobj-sandwich-auto-i)
xmap ib <Plug>(textobj-sandwich-auto-i)
omap ab <Plug>(textobj-sandwich-auto-a)
xmap ab <Plug>(textobj-sandwich-auto-a)
omap if <Plug>(textobj-sandwich-query-i)
xmap if <Plug>(textobj-sandwich-query-i)
omap af <Plug>(textobj-sandwich-query-a)
xmap af <Plug>(textobj-sandwich-query-a)

"noremap ` :!grep -F -r<Space>
"noremap ~ :!grep -E -r<Space>

"edit
"noreg
noremap <CR>g :g/\V
noremap <CR>G :v/\V
"reg
noremap <CR><Space>g :g/\v
noremap <CR><Space>G :v/\v

"diff
noremap <nowait> \ ]c
noremap <nowait> <Bar> [c

"This is useful after recovering from swap file
noremap <nowait><silent> ! :<C-u>edit<CR>

"spellcheck
noremap <nowait> & ]s
noremap <nowait> * [s

"tag
noremap <nowait> l g<C-]>
noremap <nowait> L <C-t>

"increment
noremap <nowait> - <C-a>
noremap <nowait> _ <C-x>

"jumplist
noremap <nowait> h <C-o>
noremap <nowait> H <C-i>
"the newest jump
inoremap <nowait> <A-h> <C-o><C-o>
inoremap <nowait> <A-H> <C-o><C-i>

"changelist
"noremap <nowait> H g;
"noremap <nowait> <Space>H g,
"the newest change
"why 50? It's the maxbound of changelist.
"noremap <nowait> <Space><Space>H 50g,

"indent
noremap <nowait> <Tab> >>
noremap <nowait> <S-Tab> <<
vnoremap <nowait> <Tab> >
vnoremap <nowait> <S-Tab> <
noremap <nowait> <Space><Tab> gg=G2<C-o>
xnoremap <nowait> <Space><Tab> =
inoremap <nowait> <A-Tab> <C-t>
inoremap <nowait> <A-S-Tab> <C-d>

"repeat
nmap <nowait> . <Plug>(operator-sandwich-dot)
"macro
noremap <nowait> > @@
"substitute
noremap <nowait><silent> = :&&<CR>
"command
noremap <nowait><silent> + :@:<CR>

"shell
noremap <nowait> k :!
noremap <nowait><silent> K :<C-u>call system('urxvtc')<CR>
noremap <nowait><silent> <Space>k :read !
noremap <nowait> <Space>K <C-z>
xnoremap <nowait> k !

"command
noremap <nowait> ; :
noremap <nowait> : gQ

"Macro
noremap <nowait> x @
noremap <nowait> X q

"mark
noremap <nowait> m `
noremap <nowait> M m
inoremap <nowait> <A-m> <C-o>`
inoremap <nowait> <A-M> <C-o>m

"visual
noremap <nowait> v <C-v>
"noremap <nowait> V V
noremap <nowait> <C-v> v
noremap <nowait> <Space>v gv
inoremap <nowait> <A-v> <C-o><C-v>
inoremap <nowait> <A-V> <C-o>V

"tip: C-v I $A
"tn tN
"I A
"o O
"~ d < > =
"D-j

"insert
noremap <nowait> i i
noremap <nowait> I I
"noremap <nowait><silent> <A-i> :<C-u>execute 'normal i'.repeat(nr2char(getchar()), v:count1)<CR>
noremap <nowait> <Space>i Bi
noremap <nowait> <Space>I 0i
"insert word above cursor
inoremap <nowait><expr> <A-i> (col('.') == 1 ? '<Esc>kyaWjpa' : '<Esc>klyaWjpa')

"append
noremap <nowait> a a
noremap <nowait> A A
noremap <nowait> <Space>a Ea
noremap <nowait> <Space>A g_a
"insert word below cursor
inoremap <nowait><expr> <A-a> (col('.') == 1 ? '<Esc>jyaWkpa' : '<Esc>jlyaWkpa')

"Open
"noremap <nowait> o o
"noremap <nowait> O O
noremap <nowait> <Space>o gi

"fold
noremap <nowait> ^ za
noremap <nowait> <Space>^ zA


map <nowait> # <Plug>(openbrowser-smart-search)

"joint
noremap <nowait> j J
inoremap <A-j> <C-o>J
"split
noremap <nowait> J i<CR><Esc>

"Replace
"noremap r r
"noremap <nowait> R R
inoremap <nowait> <A-r> <Insert>

"Register
"* + 0 a-z A-Z % # / :
noremap ' "+
"noremap " "
noremap <A-'> "0

"Paste
noremap <nowait> p ]p
noremap <nowait> P [p
noremap <nowait> <Space>p gpk
inoremap <nowait> <A-p> <C-r>+

"""Motion"""
"xx word
"X line
"<Sp>x to EOL
"<Sp>X to BOL

"Copy
"noremap y y
nnoremap <nowait> yy yaw
nnoremap <nowait> yY yaW
nnoremap <nowait> Y yy
nnoremap <nowait> <Space>y y$
nnoremap <nowait> <Space>Y y^
"xnoremap <nowait> y y
inoremap <nowait> <A-y> <C-o>yaw
inoremap <nowait> <A-Y> <C-o>yy

"Case
nnoremap <nowait> ` ~
inoremap <nowait> <A-`> <C-o>~
"Upper
nnoremap ~u gU
nnoremap <nowait>~uu gUiw
nnoremap <nowait>~uU gUiW
nnoremap <nowait>~U gUgU
nnoremap <nowait> <Space>~u gU$
nnoremap <nowait> <Space>~U gU^
xnoremap <nowait> ~ U
inoremap <nowait> <A-~> <C-o>gUiw
"Lower
nnoremap ~l gu
nnoremap <nowait>~ll guiw
nnoremap <nowait>~lL guiW
nnoremap <nowait>~L gugu
nnoremap <nowait> <Space>~l gu$
nnoremap <nowait> <Space>~L gu^
xnoremap <nowait> ` u

"enclose
map <silent> e <Plug>(operator-sandwich-add)
nmap <silent> ee <Plug>(operator-sandwich-add)iw
nmap <silent> eE <Plug>(operator-sandwich-add)iW
nmap <silent> E <Home><Plug>(operator-sandwich-add)<End>
nmap <silent> <Space>e <Plug>(operator-sandwich-add)<End>
nmap <silent> <Space>E <Plug>(operator-sandwich-add)<Home>

"Change
"noremap c c
nnoremap <nowait> cc ciw
nnoremap <nowait> cC ciW
nnoremap <nowait> C cc
nnoremap <nowait> <Space>c C
nnoremap <nowait> <Space>C c^
"xnoremap <nowait> c c
nmap <silent> ce <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nmap <silent> cE <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
"transpose
inoremap <A-c> <Esc>daWBhPgi
nnoremap cd :<C-u>silent lcd<Space>
nnoremap cD :<C-u>lcd %:p:h<CR>


"Delete
noremap <nowait> <Delete> x
noremap <nowait> <S-Delete> s
noremap <nowait> <Backspace> X
"noremap <nowait> <S-Backspace> Xi

"noremap d d
nnoremap <nowait> dd daw
nnoremap <nowait> dD daW
nnoremap <nowait> D dd
nnoremap <nowait> <Space>d D
nnoremap <nowait> <Space>D d^
"xnoremap <nowait> d d
nmap <silent> de <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nmap <silent> dE <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
inoremap <A-d> <C-o>daw
inoremap <A-D> <C-o>dd
"diff
nnoremap <nowait> do do
nnoremap <nowait> dp dp
nnoremap <nowait> du :diffupdate<CR>


"Undo
"noremap <nowait> u u
noremap <nowait> U <C-r>
noremap <nowait> <Space>u U
inoremap <nowait> <A-u> <C-u>

"help
noremap <nowait> q :<C-u>help<Space>
noremap <nowait><silent> Q :<C-u>helpclose<CR>
noremap <nowait> <Space>q :<C-u>helpgrep \V
noremap <nowait> <Space>Q :<C-u>helpgrep \v
"use Tagjump for jump in help

"substitute
"no regex
noremap s :s/\V
nnoremap S :%s/\V
"regex
noremap <Space>s :s/\v
nnoremap <Space>S :%s/\v

"search
"no regex
noremap <nowait> / /\V
noremap <nowait> ? ?\V
"regex
noremap <nowait> <Space>/ /\v
noremap <nowait> <Space>? ?\v
"repeat
"noremap <nowait> n n
"noremap <nowait> N N
noremap <nowait> <Space>n gn
noremap <nowait> <Space>N gN
xnoremap <nowait> n gn
xnoremap <nowait> N gN
xnoremap <nowait> <Space>n n
xnoremap <nowait> <Space>N N

"find
"noremap f f
"noremap F F
"Exclusive
"noremap t t
"noremap T T
"repeat
noremap <nowait> , ;
noremap <nowait> < ,

inoremap <A-f> <C-o>f
inoremap <A-F> <C-o>F
inoremap <A-t> <C-o>t
inoremap <A-T> <C-o>T

"match
"noremap <nowait> % %
inoremap <A-%> <C-o>%

"sentence
"noremap <nowait> ) )
"noremap <nowait> ( (

"paragraph
noremap <nowait> } })
"noremap <nowait> { {
noremap <nowait> <Space>} }k
inoremap <nowait> <A-{> <C-o>}<C-o>)
inoremap <nowait> <A-}> <C-o>{

"word
"noremap <nowait> w w
noremap <nowait> <Space>w e
"noremap <nowait> W W
noremap <nowait> <Space>W E
noremap <nowait> <A-w> *
inoremap <nowait> <A-w> <C-o>W
"back
"noremap <nowait> b b
noremap <nowait> <Space>b e
"noremap <nowait> B B
noremap <nowait> <Space>B gE
noremap <nowait> <A-b> #
inoremap <nowait> <A-b> <C-o>B

"window
noremap <nowait> <A-Down> <C-w>w
noremap <nowait> <A-Up> <C-w>W

"tab
"move index
noremap <nowait> <A-Right> gt
noremap <nowait> <A-Left> gT
"noremap <nowait><silent> <Space><A-Left> :<C-u>tabfirst<CR>
"noremap <nowait><silent> <Space><A-Right> :<C-u>tablast<CR>

"Cursor
noremap <nowait><expr> <Up> (v:count ? 'k' : 'gk')
noremap <nowait><expr> <Down> (v:count ? 'j' : 'gj')
noremap <nowait> <S-Up> -
noremap <nowait> <S-Down> +

noremap <nowait> <Left> h
noremap <nowait> <Right> l

"noremap <nowait><silent> <PageDown> <PageDown>
"noremap <nowait><silent> <PageUp> <PageUp>
noremap <nowait> <S-PageUp> gg
noremap <nowait> <S-PageDown> G

noremap <nowait> <S-Left> g^
noremap <nowait> <S-Right> g$
noremap <nowait> <Home> ^
noremap <nowait> <End> $
noremap <nowait><expr> <S-Home> (v:count ? '<Bar>' : '0')
noremap <nowait><expr> <S-End> (v:count ? '<Bar>' : 'g_')

"scroll
noremap <nowait> <Space><Space> zz
noremap <nowait> <Space><Up> zb
noremap <nowait> <Space><Down> zt

"Esc
noremap <nowait> <Esc> <Esc>
