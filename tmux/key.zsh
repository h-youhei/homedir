[ $TERM = screen ] || return

typeset -A key
key=(
	Delete '^[[3~'
	Insert '^[[2~'
	BackTab  ''
	Up '^[[A'
	Down '^[[B'
	Left '^[[D'
	Right '^[[C'
	Home '^[[1~'
	End '^[[4~'
	PageUp '^[[5~'
	PageDown '^[[6~'
	F1 '^[OP'
	F2 '^[OQ'
	F3 '^[OR'
	F4 '^[OS'
	F5 '^[[15~'
	F6 '^[[17~'
	F7 '^[[18~'
	F8 '^[[19~'
	F9 '^[[20~'
	F10 '^[[21~'
	F11 '^[[23'
	F12 '^[[24~'
)
