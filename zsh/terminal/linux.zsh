[ $TERM = linux ] || return

typeset -A key
key=(
	Delete '^[[~'
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
	F1 '^[[A~'
	F2 '^[[B~'
	F3 '^[[C~'
	F4 '^[[D~'
	F5 '^[[E~'
	F6 '^[[17~'
	F7 '^[[18~'
	F8 '^[[19~'
	F9 '^[[20~'
	F10 '^[[21~'
	F11 '^[[23'
	F12 '^[[24~'
)
