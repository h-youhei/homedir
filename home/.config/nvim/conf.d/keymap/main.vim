"Append
"a A
noremap <A-a> ea
noremap <A-A> Ea
"Append a kana by hitomozi
"<A-a> <A-A>

"Back
"b B
noremap <A-b> ge
noremap <A-B> gE

"Change
nnoremap cc ciw
nnoremap cC ciW
nnoremap C cc
nnoremap <A-c> C
nnoremap <A-C> c^
"change enclosure by sandwitch.vim
"ce cE

"cd by denite
"Home
nnoremap ch :<C-u>cd<CR>
"Root
nnoremap cr :<C-u>cd /<CR>
"git Project root
nnoremap cp :<C-u>exe 'cd' system('git rev-parse --show-toplevel 2>/dev/null')<CR>

"Delete
nnoremap dd daw
nnoremap dD daW
nnoremap D dd
nnoremap <A-d> D
nnoremap <A-D> d^
"delete enclosure by sandwitch.vim
"de dE

"Diff
nnoremap do do
nnoremap dp dp
nnoremap du :<C-u>diffupdate<CR>

"Enclose by sandwitch.vim
"ee eE E <A-e> <A-E>
noremap e<Esc> <Nop>

"Find
"f F
"find a kana by hitomozi
"<A-f> <A-F>

"Goto
noremap gg M
noremap g<Up> H
noremap g<Down> L
noremap G gm
noremap g<Left> g0
noremap g<Right> g$
"gi gv

"History
"jumplist
noremap h <C-o>
noremap H <C-i>
"changelist
noremap <A-h> g;
noremap <A-H> g,

"Insert
"i I
"Insert a kana by hitomozi
"<A-i> <A-I>
noremap <A-i> bi
noremap <A-I> Bi

"Joint
noremap j J
"split
noremap J i<CR><Esc>

"Komanndo
noremap k<Esc> <Nop>
nnoremap k !
nnoremap kk !aw
nnoremap kK !aW
nnoremap K ^!$
nnoremap <A-k> !$
nnoremap <A-K> !^
nnoremap kr :read !
xnoremap k :!

"Look into
noremap lw *
noremap lb #
noremap L g<C-]>
nnoremap <A-l> :<C-u>tags<CR>:tag<Space>
nnoremap <A-L> :<C-u>tjump<Space>

"Mark
noremap m :<C-u>call keymap#goto_mark()<CR>
noremap M :<C-u>call keymap#set_mark()<CR>

"Next match
"n N
noremap <A-n> gn
noremap <A-N> gN
xnoremap n gn
xnoremap N gN
xnoremap <A-n> n
xnoremap <A-N> N

"Open
"o O

"Paste
noremap p ]p
noremap P [p
noremap <A-p> gpk

"Quit
nnoremap q :<C-u>cclose<CR>:quit<CR>
nnoremap Q <Nop>
nnoremap Q! :<C-u>cclose<CR>:quit!<CR>
nnoremap Qa :<C-u>qall<CR>

"Replace
"r R
"replace a kana by hitomozi
"<A-r> <A-R>

"Sed
noremap s :s/\V
nnoremap S :%s/\V
noremap <A-s> :s/\v
nnoremap <A-S> :%s/\v
"surround target by snippet
"vmap S

"Take
"t T
"take a kana by hitomozi
"<A-t> <A-T>

"Undo
"u
nnoremap U <C-r>
nnoremap <A-u> U

"Visual
"v V
noremap <A-v> <C-v>

"Word
"w W
noremap <A-w> e
noremap <A-W> E

"X(do) Macro
noremap x :<C-u>call keymap#evoke_macro()<CR>
noremap X :<C-u>call keymap#set_macro()<CR>

"Yank (copy)
"y
nnoremap yy yaw
nnoremap yY yaW
nnoremap Y yy
nnoremap <A-y> y$
nnoremap <A-Y> y^

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
nnoremap zn :<C-u>setl relativenumber!<CR>
nnoremap zp :<C-u>setl paste!<CR>
nnoremap zs :<C-u>setl spell!<CR>
nnoremap zt :<C-u>setl expandtab!<CR>
nnoremap zw :<C-u>setl wrap!<CR>

"reload
nnoremap Zv :<C-u>source $MYVIMRC<CR>
nnoremap Zp :<C-u>call dein#update()<CR>
nnoremap Zr :<C-u>call dein#remote_plugins()<CR>
"Zs edit snipet

"repeat find
noremap , ;
noremap < ,

"repeat command
".
"macro
noremap > @@
"sed
noremap <silent> <A-.> :&&<CR>
"commandline
noremap <silent> <A->> + :@:<CR>

"search
noremap <expr> / (ibus#activate() . '/\V')
noremap <expr> ? (ibus#activate() . '?\V')
noremap <expr> <A-/> (ibus#activate() . '/\v')
noremap <expr> <A-?> (ibus#activate() . '?\v')

cnoremap <expr> <CR> (ibus#inactivate() . '<CR>')
cnoremap <expr> <Esc> (ibus#inactivate() . '<C-u><BS>')
"Register
"* + 0 a-z A-Z % # / :
noremap ' "+
noremap " :<C-u>call keymap#select_register()<CR>
noremap <A-'> "0

"Case
"~
nnoremap ` <Nop>
xnoremap ` u
xnoremap ~ U
"Upper
nnoremap `u gU
nnoremap `uu gUiw
nnoremap `uU gUiW
nnoremap `U gUgU
nnoremap `<A-u> gU$
nnoremap `<A-U> gU^
"Lower
nnoremap `l gu
nnoremap `ll guiw
nnoremap `lL guiW
nnoremap `L gugu
nnoremap `<A-l> gu$
nnoremap `<A-L> gu^

"increment
noremap + <C-a>
xnoremap <A-+> g<C-a>
"decrement
noremap - <C-x>
xnoremap <A--> g<C-x>

"adjust
nnoremap = ==

"paragraph
noremap } })
"noremap <nowait> { {
noremap <A-}> }k

"help
"\ search help by denite
nnoremap <Bar> :<C-u>helpclose<CR>

"quickfix
nnoremap <A-\> :<C-u>copen<CR>
nnoremap <A-Bar> :<C-u>cclose<CR>
augroup my
	"toggle focusing quickfix
	au BufReadPost quickfix noremap <buffer> <A-\> <C-w>k
augroup END

"match paren
"%

"fold
noremap ^ zO
noremap _ zC

"goto parent dir
nnoremap <A-^> :cd ..<CR>

"diff
noremap ) ]c
noremap ( [c
"quickfix
noremap <A-)> :cnext<CR>
noremap <A-(> :cNext<CR>

"indent
nnoremap <Tab> >>
nnoremap <S-Tab> <<
xnoremap <Tab> >
xnoremap <S-Tab> <
nnoremap <A-Tab> :left<CR>

"Delete char with no register
nnoremap <Del> "_x
nnoremap <A-Del> "_s
xnoremap <Del> x
xnoremap <A-Del> s
nnoremap <BS> "_X
nnoremap <A-BS> "_Xi
xnoremap <BS> X
xnoremap <A-BS> Xi

"cursor
noremap <A-Up> gk
noremap <A-Down> gj
noremap <S-Up> -
noremap <S-Down> +

noremap <A-Left> gT
noremap <A-Right> gt
"sentence
noremap <S-Left> (
noremap <S-Right> )

"<PageUp> <PageDown>
"scroll
noremap <A-Space> zz
noremap <A-PageUp> zb
noremap <A-PageDown> zt
noremap <S-PageUp> gg
noremap <S-PageDown> G

noremap <Home> ^
noremap <End> $
noremap <A-Home> zs
noremap <A-End> ze
noremap <expr> <S-Home> (v:count ? '<Bar>' : '0')
noremap <expr> <S-End> (v:count ? '<Bar>' : 'g_')
