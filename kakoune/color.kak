define-command gui-color %{
	# For Code
	face value red
	face type green
	face variable green
	face module magenta
	face function default
	face string red
	face keyword yellow
	face operator default
	face attribute green
	face comment cyan
	face meta blue
	face builtin default

	# For markup
	face title green
	face header green
	face bold default+b
	face italic default+i
	face mono default
	face block blue
	face link magenta
	face bullet yellow
	face list yellow

	# builtin faces
	face Default default
	face PrimarySelection bright-white,bright-green
	face SecondarySelection bright-white,bright-magenta
	face PrimaryCursor black,white+b
	face PrimaryCursorEol black,white+b
	face SecondaryCursor bright-blue,bright-cyan
	face SecondaryCursorEol bright-blue,bright-cyan
	face LineNumbers bright-black
	face LineNumberCursor bright-white,bright-blue
	face MenuForeground bright-blue,bright-cyan+b
	face MenuBackground bright-cyan,bright-blue
	face MenuInfo bright-black+i
	face Information bright-yellow
	face Error bright-white,bright-red
	face StatusLine default
	face StatusLineMode magenta
	face StatusLineInfo green
	face StatusLineValue magenta
	face StatusCursor black,white+b
	face Prompt magenta
	face MatchingChar bright-white+b
	face BufferPadding bright-black
	face Whitespace bright-black
}

define-command console-color %{
	# For Code
	face value red
	face type green
	face variable default
	face module magenta+b
	face function default
	face string red
	face keyword yellow
	face operator default
	face attribute green
	face comment cyan
	face meta blue+b
	face builtin default

	# For markup
	face title green
	face header green
	face bold default+b
	face italic default+i
	face mono default
	face block blue+b
	face link magenta+b
	face bullet yellow
	face list yellow

	# builtin faces
	face Default default
	face PrimarySelection black,white
	face SecondarySelection white,blue
	face PrimaryCursor black,white
	face PrimaryCursorEol black,white
	face SecondaryCursor black,white
	face SecondaryCursorEol black,white
	face LineNumbers yellow
	face LineNumberCursor yellow+b
	face MenuForeground black,white
	face MenuBackground white,blue
	face MenuInfo default+i
	face Information yellow+b
	face Error black,red
	face StatusLine default
	face StatusLineMode magenta+b
	face StatusLineInfo green
	face StatusLineValue magenta+b
	face StatusCursor black,white
	face Prompt yellow
	face MatchingChar white+b
	face BufferPadding blue
	face Whitespace blue
}

define-command -hidden _setup-color %{ %sh{
	if [ $TERM = linux ] ; then
		echo console-color
	else
		echo gui-color
	fi
}}

hook global WinDisplay .* %{ _setup-color }
