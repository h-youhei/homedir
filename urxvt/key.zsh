[ $TERM = rxvt-unicode ] || return

typeset -A key
key=(
	Delete '^[[3~'
	Insert '^[[2~'
	BackTab  '^[[Z'
	Up '^[[A'
	Down '^[[B'
	Left '^[[D'
	Right '^[[C'
	Home '^[[7~'
	End '^[[8~'
	PageUp '^[[5~'
	PageDown '^[[6~'
	F1 '^[[11~'
	F2 '^[[12~'
	F3 '^[[13~'
	F4 '^[[14~'
	F5 '^[[15~'
	F6 '^[[17~'
	F7 '^[[18~'
	F8 '^[[19~'
	F9 '^[[20~'
	F10 '^[[21~'
	F11 '^[[23'
	F12 '^[[24~'
)

#key[S-Tab]='^[[Z'
#key[Insert]='^[[2~'
#key[S-Insert]='^[[2;2~'
#key[Delete]='^[[3~'
#key[S-Delete]='^[[3;2~'

#key[Up]='^[[A'
#key[S-Up]='^[[1;2A'
#key[Down]='^[[B'
#key[S-Down]='^[[1;2B'
#key[Left]='^[[D'
#key[S-Left]='^[[1;2D'
#key[Right]='^[[C'
#key[S-Right]='^[[1;2C'

#key[PageUp]='^[[5~'
#key[S-PageUp]='^[[5;2~'
#key[PageDown]='^[[6~'
#key[S-PageDown]='^[[6;2~'
#key[Home]='^[[7~'
#key[S-Home]='^[[1;2H'
#key[End]='^[[8~'
#key[S-End]='^[[1;2F'