"accept completion
inoremap <expr> <A-a> keymap#accept_popup()

"Back
noremap! <A-b> <S-Left>
inoremap <A-B> <C-o>B

"Capitalize
inoremap <A-c> <C-r>=keymap#capitalize_word()<CR>
inoremap <A-C> <C-r>=keymap#capitalize_line()<CR>

"Delete
noremap! <A-d> <C-w>
noremap! <A-D> <C-u>

"Find
inoremap <A-f> <C-o>f
inoremap <A-F> <C-o>F

"go next by ultisnips in insert
"insert <A-g> <A-G>

"convert the word to higher case
inoremap <A-h> <C-r>=keymap#upcase_word()<CR>
inoremap <A-H> <C-r>=keymap#upcase_line()<CR>

"joint
inoremap <A-j> <C-o>J

"convert the word to lower case
inoremap <A-l> <C-r>=keymap#downcase_word()<CR>
inoremap <A-L> <C-r>=keymap#downcase_line()<CR>

"Mark
inoremap <A-m> <C-o>`z
inoremap <A-M> <C-o>mz

"Next match
inoremap <A-n> <C-o>n
inoremap <A-N> <C-o>N

"Once
inoremap <A-o> <C-o>

"Paste
inoremap <A-p> <C-r>+

"Take
inoremap <A-t> <C-o>t
inoremap <A-T> <C-o>T

"Undo complition by deoplete
"<A-u>

"Visual
inoremap <A-v> <C-o>v
inoremap <A-V> <C-o>V

"Word
noremap! <A-w> <S-Right>
inoremap <A-W> <C-o>W

"Yank from above/below line
inoremap <A-y> <C-r>=getline(line('.') - 1)<CR>
inoremap <A-Y> <C-r>=getline(line('.') + 1)<CR>

"repeat find
inoremap <A-,> ;
inoremap <A-<> ,

"search
inoremap <A-/> <C-o>?\V
inoremap <A-?> <C-o>?\V

"case
inoremap <A-~> <C-o>~

"increment
inoremap <A-+> <C-o><C-a>
inoremap <A--> <C-o><C-x>

"adjust
inoremap <A-=> <C-o>==

"paragraph
inoremap <A-{> <C-o>}<C-o>)
inoremap <A-}> <C-o>{

"match paren
inoremap <A-%> <C-o>%

"indent
inoremap <expr> <Tab> (pumvisible() ? '<C-n>' : '<C-t>')
inoremap <expr> <S-Tab> (pumvisible() ? '<C-p>' : '<C-d>')
inoremap <A-Tab> <Tab>

inoremap <expr> <BS> (keymap#abort_popup() . '<BS>')

inoremap <expr> <CR> (keymap#accept_popup() . '<CR>')
"CR and put cursor on begging of line
inoremap <expr> <A-CR> (keymap#accept_popup() . '<CR><C-o>:left<CR>')

"`^ keep cursor after leaving insert
inoremap <expr> <Esc> (keymap#accept_popup() . '<Esc>`^')

"cursor
inoremap <expr> <Up> (keymap#accept_popup() . '<Up>')
inoremap <expr> <Down> (keymap#accept_popup() . '<Down>')
inoremap <A-Up> <C-o>gk
inoremap <A-Down> <C-o>gj
inoremap <S-Up> <C-o>-
inoremap <S-Down> <C-o>+
inoremap <S-Left> <C-o>(
inoremap <S-Right> <C-o>)

inoremap <A-Space> <C-o>zz
inoremap <A-PageUp> <C-o>zb
inoremap <A-PageDown> <C-o>zt
inoremap <S-PageUp> <C-o>gg
inoremap <S-PageDown> <C-o>G

inoremap <Home> <C-o>^
inoremap <End> <C-o>$
inoremap <A-Home> <C-o>zs
inoremap <A-End> <C-o>ze
inoremap <expr> <S-Home> (keymap#accept_popup() . '<Home>')
inoremap <expr> <S-End> (keymap#accept_popup() . '<End>')
