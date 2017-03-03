"----------Law----------{{{
"---Motion---
"xx word
"xX WORD
"X line
"<A-x> to EOL
"<A-X> to BOL

"---Object range---
"i inner
"a all
"e enclosed

"---Object---
"w word
"W WORD
"s sentence
"p paragraph
"b autoblock
"d delimiter
"f find
"t tag

"---Cursor---
"x logical
"<S-x> add some flavor
"<A-x> appearence

"---Word Orientation Move---
"x head of word
"X head of WORD
"<A-x> end of word
"<A-X> end of WORD

"---Regex---
"x very nomagic
"<A-x> very magic

"---Ward---
"x forward
"X backward

"---History---
"x old
"X new

"---Prefix
"g goto
"; cmdline command
"<CR> command that affects windows
"}}}

"----------Mnemonic----------{{{
"---A---
"Append
"---B---
"Back
"Buffer
"---C---
"Change
"Close
"Cd
"Confirm
"---D---
"Delete
"Diff
"---E---
"Enclose
"Edit
"Expand
"---F---
"Find
"File
"---G---
"Go to
"Global
"Grep
"---H---
"History
"---I---
"Insert
"---J---
"Joint
"---K---
"Komanndo(foreign command)
"---l---
"Look into
"---M---
"Mark
"Make
"Mimic
"---N---
"Next
"---O---
"Open
"---P---
"Paste
"Print
"---Q---
"Quit
"---R---
"Replace
"Read
"Reopen
"---S---
"Sed
"Save
"Search
"---T---
"Take
"Terminal
"---U---
"Undo
"Unload
"---V---
"Visual
"inVert global
"Vim
"---W---
"Word
"---X---
"X(do) macro
"eXit
"---Y---
"Yank
"---Z---
"Z ha Settei no S wo nigoraseta mono
"--- .> ---
". is repeating command by default
"--- ,< ---
", is repeating find backward by default
"--- /? ---
"/? is searching by default
"--- ;: ---
": is commandline by default
"--- '" ---
"" is register by default
"--- `~ ---
"toggling case by default
"--- +- ---
"plus minus
"--- = ---
"adjusting indent by default
"--- % ---
"moving cursor to match paren by default
"--- ^_ ---
"fold like appearence
"--- ^ ---
"^ direct up so ^ is changing dir to parent
"--- ()[]{} ---
"parens has direction
"() move to next/prev difference
"<A-()> move to next/prev quickfix
"{} move to next/prev paragraph
"--- \ ---
"help
"--- | ---
"quickfix
"---Tab---
"Tab is used for indent
"---CR---
"Open window
"}}}

"in case make mistake
noremap ZZ <Nop>
noremap ZQ <Nop>


let s:keymap_dir = init#conf_dir . '/keymap'
exe 'source' s:keymap_dir . '/main.vim'
exe 'source' s:keymap_dir . '/insert.vim'
exe 'source' s:keymap_dir . '/cmd.vim'
exe 'source' s:keymap_dir . '/win.vim'

"note

"prefix key
"map to <Nop> in order to prevent default mapping when type prefix key then <Esc>

"nnoremap <CR>r :<C-u>!ls<CR>:read<Space>

"%s grep
"noremap ` :!grep -F -r<Space>
"noremap ~ :!grep -E -r<Space>

"noremap <nowait><silent> <A-i> :<C-u>execute 'normal i'.repeat(nr2char(getchar()), v:count1)<CR>
