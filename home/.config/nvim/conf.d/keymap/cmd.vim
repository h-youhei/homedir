":
noremap ; <Nop>

"append
nnoremap ;a :<C-u>write >><Space>

"delete
nnoremap ;d :<C-u>marks<CR>:delmarks<Space>

"Global filter
noremap ;g :g/\V
noremap ;G :%g/\V
noremap ;<A-g> :g/\v
noremap ;<A-G> :%g/\v

"history by denite
";h ;<A-h>

"make
nnoremap ;m :<C-u>mksession!<CR>

"read from file by Denite
";r

"save
nnoremap ;s :<C-u>update<CR>
nnoremap ;S :<C-u>write<Space>

"reVerse global filter
noremap ;v :v/\V
noremap ;V :%v/\V
noremap ;<A-v> :v/\v
noremap ;<A-V> :%v/\v

"mark dir for xmonad
nnoremap ;x :<C-u>call keymap#mark_to_file()<CR>
