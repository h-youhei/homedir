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

"find and replace for Japanese letter
digraph ca 12363
digraph ci 12365
digraph cu 12367
digraph ce 12369
digraph co 12371
digraph Ca 12459
digraph Ci 12461
digraph Cu 12463
digraph Ce 12465
digraph Co 12467
noremap f<A-k> f<C-k>
noremap f<A-,> f、
noremap f<A-.> f。
noremap f<A-[> f「
noremap f<A-]> f」
noremap f<A-k>a fあ
noremap f<A-k>A fア
noremap f<A-k>i fい
noremap f<A-k>I fイ
noremap f<A-k>u fう
noremap f<A-k>U fウ
noremap f<A-k>e fえ
noremap f<A-k>E fエ
noremap f<A-k>o fお
noremap f<A-k>O fオ
noremap f<A-k>l fん
noremap f<A-k>L fン
noremap F<A-k> F<C-k>
noremap F<A-,> F、
noremap F<A-.> F。
noremap F<A-[> F「
noremap F<A-]> F」
noremap F<A-k>a Fあ
noremap F<A-k>A Fア
noremap F<A-k>i Fい
noremap F<A-k>I Fイ
noremap F<A-k>u Fう
noremap F<A-k>U Fウ
noremap F<A-k>e Fえ
noremap F<A-k>E Fエ
noremap F<A-k>o Fお
noremap F<A-k>O Fオ
noremap F<A-k>l Fん
noremap F<A-k>L Fン
noremap t<A-k> t<C-k>
noremap t<A-,> t、
noremap t<A-.> t。
noremap t<A-[> t「
noremap t<A-]> t」
noremap t<A-k>a tあ
noremap t<A-k>A tア
noremap t<A-k>i tい
noremap t<A-k>I tイ
noremap t<A-k>u tう
noremap t<A-k>U tウ
noremap t<A-k>e tえ
noremap t<A-k>E tエ
noremap t<A-k>o tお
noremap t<A-k>O tオ
noremap t<A-k>l tん
noremap t<A-k>L tン
noremap T<A-k> T<C-k>
noremap T<A-,> T、
noremap T<A-.> T。
noremap T<A-[> T「
noremap T<A-]> T」
noremap T<A-k>a Tあ
noremap T<A-k>A Tア
noremap T<A-k>i Tい
noremap T<A-k>I Tイ
noremap T<A-k>u Tう
noremap T<A-k>U Tウ
noremap T<A-k>e Tえ
noremap T<A-k>E Tエ
noremap T<A-k>o Tお
noremap T<A-k>O Tオ
noremap T<A-k>l Tん
noremap T<A-k>L Tン
noremap r<A-k> r<C-k>
noremap r<A-,> r、
noremap r<A-.> r。
noremap r<A-[> r「
noremap r<A-]> r」
noremap r<A-k>a rあ
noremap r<A-k>A rア
noremap r<A-k>i rい
noremap r<A-k>I rイ
noremap r<A-k>u rう
noremap r<A-k>U rウ
noremap r<A-k>e rえ
noremap r<A-k>E rエ
noremap r<A-k>o rお
noremap r<A-k>O rオ
noremap r<A-k>l rん
noremap r<A-k>L rン

"For Inactivate IM and Capslock, raise InsertEvent after search.
"Not working when an error is encountered. Why? See :help *map_return*
"IMが起動した状態で実行されるから特殊文字しか意味をなさない。
cnoremap <expr><silent> <CR> keymap#CR_with_InsertEvent()
function! keymap#CR_with_InsertEvent()
	return s:is_search() ? "\<CR>\<Insert>\<Right>\<Esc>" : "\<CR>"
endfunction
function! s:is_search()
	let l:cmdtype = getcmdtype()
	return l:cmdtype == '/' || l:cmdtype == '?' ? 1 : 0
endfunction

"""Buffer/Tabpage/Window
"filer
nnoremap <CR>f :update<CR>:edit %:p:h<CR>
nnoremap <CR>tf :update<CR>:tabedit %:p:h<CR>
nnoremap <CR>vf :update<CR>:vsplit %:p:h<CR>
nnoremap <CR>hf :update<CR>:split %:p:h<CR>

"edit
nnoremap <CR>e :update<CR>:!ls<CR>:edit<Space>
nnoremap <CR>te :update<CR>:!ls<CR>:tabedit<Space>
nnoremap <CR>ve :update<CR>:!ls<CR>:vsplit<Space>
nnoremap <CR>he :update<CR>:!ls<CR>:split<Space>

"open the file whose name is under the cursor
nnoremap <CR>o gF
nnoremap <CR>to <C-w>gF
"to do test
nnoremap <CR>vo :exec("vsplit ".expand("<cword>"))
nnoremap <CR>ho <C-w>F

"tag
"to do test
nnoremap <CR>vt :exec("vertical stjump ".expand("<cword>"))
nnoremap <CR>ht <C-w>g<C-]>
nnoremap <CR>T :tjump<Space>
nnoremap <CR>vT :vertical stjump<Space>
nnoremap <CR>hT :stjump<Space>

"write/append to chosen file
nnoremap <CR>w :write<Space>
nnoremap <CR>a :write >><Space>

"close
nnoremap <CR>c :bdelete<CR>
nnoremap <CR>C :!ls<CR>:bdelete<Space>
nnoremap <CR>tc :tabclose<CR>
nnoremap <CR>tC :tabs<CR>:tabclose<Space>

"move/multiple
nnoremap <CR>tm <C-w>t
nnoremap <CR>vm :vsplit<CR>
nnoremap <CR>hm :split<CR>

"new
nnoremap <CR>n :enew<CR>
nnoremap <CR>tn :tabnew<CR>
nnoremap <CR>vn :vnew<CR>
nnoremap <CR>hn :new<CR>

"diff
nnoremap <CR>vd :!ls<CR>:vertical diffsplit<Space>
nnoremap <CR>hd :!ls<CR>:diffsplit<Space>

"help
nnoremap <CR>vh :vertical help<CR>
nnoremap <CR>hh :help<CR>

"adjust window size
nnoremap <CR>= <C-w>=

"file manage
nnoremap <CR>r :!ls<CR>:read<Space>
nnoremap <CR>u :update<CR>
nnoremap <CR>q :quit<CR>
nnoremap <CR><Space>q :quit!<CR>
nnoremap <CR><Space>Q :qall!<CR>
nnoremap <CR>Q :qall<CR>
"update then quit
nnoremap <CR>x :xit<CR>
nnoremap <CR>X :xall<CR>

"buffer
"show list of buffers then move to a buffer
nnoremap <CR>b :up<CR>:ls<CR>:buffer<Space>
"noremap <CR>tb :up<CR>:ls<CR>:buffer<Space>
"noremap <CR>vb :up<CR>:ls<CR>:buffer<Space>
"noremap <CR>hb :up<CR>:ls<CR>:buffer<Space>

"noremap <Leader>s :call session#make_project()<CR>

"print
nnoremap <nowait> <CR>pc :changes<CR>
nnoremap <nowait> <CR>pm :marks<CR>
nnoremap <nowait> <CR>pr :registers<CR>
nnoremap <nowait> <CR>pj :jumps<CR>
nnoremap <nowait> <CR>pt :tags<CR>

"plugin
nnoremap <nowait> <CR>P :call init#plugin_update()<CR>
execute 'nnoremap <nowait> <CR><Space>p :edit ' . init#conf_dir . '/dein.toml<CR>'
execute 'nnoremap <nowait> <CR><Space>P :edit ' . init#conf_dir . '/dein_lazy.toml<CR>'

"setting
"toggle options
nnoremap z <Nop>
nnoremap zh :setl hlsearch!<CR>
nnoremap z_ :setl list!<CR>
nnoremap zs :setl spell!<CR>
nnoremap zp :setl paste!<CR>
nnoremap zc :setl autochdir!<CR>
nnoremap zm :setl showmatch!<CR>
nnoremap zb :setl backup!<CR>
nnoremap zl :setl linebreak!<CR>
nnoremap zn :setl relativenumber!<CR>
nnoremap zw :setl wrap!<CR>
"autoindent
"cindent
"copyindent
"cursorbind
"diff
"readonly
"scrollbind
"smartindent
"reload
nnoremap <nowait> Z :source $MYVIMRC<CR>
execute 'nnoremap <nowait> <Space>z :edit ' . init#conf_dir . '/keymap.vim<CR>'
nnoremap <nowait> <Space>Z :edit $MYVIMRC<CR>


"quickfix
nnoremap <nowait> x :copen<CR>
nnoremap <nowait> X :cclose<CR>
augroup keymap
	autocmd BufReadPost quickfix noremap <buffer><nowait> x <C-w>k
	autocmd BufReadPost quickfix noremap <buffer><nowait> <CR> <CR>
augroup END

"abbreviations
nnoremap @ <Nop>
nnoremap @p :iabbrev <buffer><CR>
nnoremap @a :iabbrev <buffer><Space>
nnoremap @d :iunabbrev <buffer><Space>
nnoremap @D :iabclear<CR>

"args
nnoremap $ <Nop>
nnoremap $p :args<CR>
nnoremap $a :argadd<Space>
nnoremap $d :argdel<Space>
nnoremap $e :argedit<Space>
"noremap $x :argdo<Space>
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
noremap <CR>s :s/\V
nnoremap <CR>S :%s/\V
noremap <CR>g :g/\V
noremap <CR>G :v/\V
"reg
noremap <CR><Space>s :s/\v
nnoremap <CR><Space>S :%s/\v
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
noremap <nowait> <Space>h <C-i>
"the newest jump
"why 50? It's the maxbound of jumplist.
noremap <nowait> <Space><Space>H 50<C-i>
inoremap <nowait> <A-h> <C-o><C-o>
inoremap <nowait> <A-H> <C-o><C-i>

"changelist
noremap <nowait> H g;
noremap <nowait> <Space>H g,
"the newest change
"why 50? It's the maxbound of changelist.
noremap <nowait> <Space><Space>H 50g,

"indent
noremap <nowait> <Tab> >>
noremap	<nowait> <S-Tab> <<
vnoremap <nowait> <Tab> >
vnoremap <nowait> <S-Tab> <
noremap <nowait> <Space><Tab> gg=G2<C-o>
xnoremap <nowait> <Space><Tab> =
inoremap <nowait> <Tab> <C-t>
inoremap <nowait> <S-Tab> <C-d>

"repeat
noremap <nowait> . .
"macro
noremap <nowait> > @@
"substitute
noremap <nowait><silent> = :&&<CR>
"command
noremap <nowait><silent> + :@:<CR>

"shell
noremap <nowait> k :!
noremap <nowait><silent> K :<C-u>terminal<CR>
noremap <nowait><silent> <Space>k :read !
noremap <nowait> <Space>K <C-z>
xnoremap <nowait> k !

"command
noremap <nowait> ; :
noremap <nowait> : q:

"Macro
noremap <nowait> e @z
noremap <nowait> E qz<Esc>
noremap <Space>e @
noremap <Space>E q

"mark
noremap ] `
noremap [ '
noremap <nowait> ]] ''
noremap <nowait> [[ ``
noremap <nowait> ]# ]#
noremap <nowait> [# [#
"quick
noremap <nowait> m `z
noremap <nowait> M mz
noremap <Space>M m
inoremap <nowait> <A-m> <C-o>`z
inoremap <nowait> <A-M> <C-o>mz

"visual
noremap <nowait> v <C-v>
"noremap <nowait> V V
noremap <nowait> <A-v> v
noremap <nowait> <Space>v gv
inoremap <nowait> <A-y> <C-o><C-v>
inoremap <nowait> <A-Y> <C-o>V

"tip: C-v I $A
"tn tN
"I A
"o O
"~ d < > =
"D-j

"insert
noremap <nowait> i i
noremap <nowait> I I
noremap <nowait><silent> <A-i> :<C-u>execute 'normal i'.repeat(nr2char(getchar()), v:count1)<CR>
noremap <nowait> <Space>i Bi
noremap <nowait> <Space>I 0i

"append
noremap <nowait> a a
noremap <nowait> A A
noremap <nowait><silent> <A-a> :<C-u>execute 'normal a'.repeat(nr2char(getchar()), v:count1)<CR>
noremap <nowait> <Space>a Ea
noremap <nowait> <Space>A g_a

"Open
"noremap <nowait> o o
"noremap <nowait> O O
noremap <nowait> <Space>o gi

"fold
noremap <nowait> ^ za
noremap <nowait> <Space>^ zA

"comment
"nmap <nowait> # <Plug>(comment-toggle)

"joint
noremap <nowait> j J
inoremap <A-j> <C-o>J
"split
noremap <nowait> J i<CR><Esc>

"Replace
"noremap r r
"noremap <nowait> R R

"Register
"* + 0 a-z A-Z % # / :
noremap ' "+
"noremap " "
noremap <A-'> "0
inoremap <A-'> <C-o>"+
inoremap <A-"> <C-o>"

"Paste
noremap <nowait> p ]p
noremap <nowait> P [p
noremap <nowait> <Space>p gpk
inoremap <nowait> <A-p> <C-o>p

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

"Surround
map <silent> s <Plug>(operator-sandwich-add)
nmap <silent> ss <Plug>(operator-sandwich-add)iw
nmap <silent> sS <Plug>(operator-sandwich-add)iW
nmap <silent> S <Home><Plug>(operator-sandwich-add)<End>
nmap <silent> <Space>s <Plug>(operator-sandwich-add)<End>
nmap <silent> <Space>S <Plug>(operator-sandwich-add)<Home>

"Change
"noremap c c
nnoremap <nowait> cc ciw
nnoremap <nowait> cC ciW
nnoremap <nowait> C cc
nnoremap <nowait> <Space>c C
nnoremap <nowait> <Space>C c^
"xnoremap <nowait> c c
nmap <silent> cs <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nmap <silent> cS <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
"transpose
inoremap <A-c> <Esc>daWBhPgi

"Delete
noremap <nowait> <Delete> x
noremap <nowait> <S-Delete> s
noremap <nowait> <Backspace> X
"noremap d d
nnoremap <nowait> dd daw
nnoremap <nowait> dD daW
nnoremap <nowait> D dd
nnoremap <nowait> <Space>d D
nnoremap <nowait> <Space>D d^
"xnoremap <nowait> d d
nmap <silent> ds <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nmap <silent> dS <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
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

"search
"no regex
noremap <nowait> / /\V
noremap <nowait> ? ?\V
inoremap <nowait> <A-/> <C-o>/\V
inoremap <nowait> <A-?> <C-o>?\V
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
inoremap <nowait> <A-n> <C-o>n
inoremap <nowait> <A-N> <C-o>N

"find
"noremap f f
"noremap F F
inoremap <A-f> <C-o>f
inoremap <A-F> <C-o>F
"Exclusive
"noremap t t
"noremap T T
inoremap <A-t> <C-o>t
inoremap <A-T> <C-o>T
"repeat
noremap <nowait> , ;
noremap <nowait> < ,
inoremap <nowait> <A-,> <C-o>;
inoremap <nowait> <A-<> <C-o>,

"match
"noremap <nowait> % %

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

"Jump

"tab
"move index
noremap <nowait> <S-Left> gT
noremap <nowait> <S-Right> gt
noremap <nowait><silent> <Space><S-Left> :<C-u>tabfirst<CR>
noremap <nowait><silent> <Space><S-Right> :<C-u>tablast<CR>

"window
noremap <nowait> <A-Left> <C-w>h
noremap <nowait> <A-Down> <C-w>j
noremap <nowait> <A-Up> <C-w>k
noremap <nowait> <A-Right> <C-w>l

"Cursor
noremap <nowait><expr> <Up> (v:count ? 'k' : 'gk')
noremap <nowait><expr> <Down> (v:count ? 'j' : 'gj')
noremap <nowait> <S-Up> -
noremap <nowait> <S-Down> +

noremap <nowait> <Left> h
noremap <nowait> <Right> l

noremap <nowait><silent> <PageDown> :<C-u>call keymap#down_half_winheight(v:count1)<CR>
noremap <nowait><silent> <PageUp> :<C-u>call keymap#up_half_winheight(v:count1)<CR>
noremap <nowait> <Space><PageUp> gg
noremap <nowait> <Space><PageDown> G

function! keymap#up_half_winheight(count)
	let l:half_height = winheight(0) / 2
	let l:move_amount = l:half_height * a:count
	execute 'normal!' . l:move_amount . 'gk'
endfunction

function! keymap#down_half_winheight(count)
	let l:half_height = winheight(0) / 2
	let l:move_amount = l:half_height * a:count
	execute 'normal!' . l:move_amount . 'gj'
endfunction

noremap <nowait> <Home> g^
noremap <nowait> <End> g$
noremap <nowait> <S-Home> ^
noremap <nowait> <S-End> $
noremap <nowait><expr> <Space><Home> (v:count ? '<Bar>' : '0')
noremap <nowait><expr> <Space><End> (v:count ? '<Bar>' : 'g_')

"Esc
noremap <nowait> <Esc> <Esc>
