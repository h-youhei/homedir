"help group-name
"help highlight-group

set background=dark
hi clear
let g:colors_name = 'youhei'
if exists('syntax_on')
	syntax reset
endif

"0 8  black   dark_gray
"1 9  red     hi_red
"2 10 green   hi_green
"3 11 yellow  hi_yellow
"4 12 blue    hi_blue
"5 13 magenta blue_gray
"6 14 cyan    green_gray
"7 15 white   light_giey

hi Normal cterm=none ctermfg=7 ctermbg=0
hi! link VertSplit Normal
hi! link ModeMsg Normal

hi Comment cterm=none ctermfg=4

hi Constant cterm=none ctermfg=1

hi Identifier cterm=none ctermfg=6

hi Statement cterm=none ctermfg=3

hi PreProc cterm=none ctermfg=5
hi! link Special PreProc

hi Type cterm=none ctermfg=2

hi Underlined cterm=underline ctermfg=10

hi Error cterm=none ctermfg=7 ctermbg=9
hi! link ErrorMsg Error

hi Todo cterm=none ctermfg=0 ctermbg=11
hi! link WarningMsg Todo

hi NonText cterm=none ctermfg=12
hi! link SpecialKey NonText

hi SpellBad cterm=underline ctermfg=11

hi Title cterm=bold ctermfg=7

hi Visual cterm=none ctermbg=8
hi! link MatchParen Visual
hi! link QuickFixLine Visual

hi Cursor cterm=none ctermfg=0 ctermbg=15

hi Folded cterm=italic ctermfg=0 ctermbg=4
hi FoldColumn cterm=bold ctermfg=7 ctermbg=8

hi LineNr cterm=italic ctermfg=15
hi CursorLineNr cterm=bold ctermfg=7

hi StatusLine cterm=bold ctermfg=7 ctermbg=8
hi StatusLineNC cterm=none ctermfg=15 ctermbg=8
hi TabLineFill cterm=none ctermfg=7 ctermbg=8
hi! link Pmenu TabLineFill

hi Search cterm=none ctermfg=0 ctermbg=15
hi! link WildMenu Search
hi! link PmenuSel Search

hi MoreMsg cterm=none ctermfg=10
hi! link Question MoreMsg

hi DiffChange cterm=none ctermbg=14
hi! link DiffText DiffChange

hi! link DiffAdd Normal
hi DiffDelete cterm=none ctermfg=none ctermbg=13

hi IncSearch cterm=reverse
hi! link Substitute IncSearch
