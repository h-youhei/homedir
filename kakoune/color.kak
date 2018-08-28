# For Code
face global value red
face global type green
face global variable green
face global module magenta
face global function default
face global string red
face global keyword yellow
face global operator default
face global attribute green
face global comment cyan
face global meta blue
face global builtin default

# For markup
face global title green
face global header green
face global bold default+b
face global italic default+i
face global mono default
face global block blue
face global link magenta
face global bullet yellow
face global list yellow

# builtin faces
face global Default default
face global PrimarySelection bright-white,bright-green
face global SecondarySelection bright-white,bright-magenta
face global PrimaryCursor black,white+b
face global PrimaryCursorEol black,white+b
face global SecondaryCursor bright-white,bright-cyan
face global SecondaryCursorEol bright-white,bright-cyan
face global LineNumbers bright-black
face global LineNumberCursor bright-white,bright-blue
face global MenuForeground bright-white,bright-green
face global MenuBackground default,bright-blue
face global MenuInfo bright-black+i
face global Information yellow
face global Error bright-white,bright-red
face global StatusLine default
face global StatusLineMode magenta
face global StatusLineInfo green
face global StatusLineValue magenta
face global StatusCursor black,white+b
face global Prompt magenta
face global MatchingChar bright-white+b
face global BufferPadding bright-black
face global Whitespace bright-black

define-command console-color %{
	# For Code
	face window value red
	face window type green
	face window variable default
	face window module magenta+b
	face window function default
	face window string red
	face window keyword yellow
	face window operator default
	face window attribute green
	face window comment cyan
	face window meta blue+b
	face window builtin default

	# For markup
	face window title green
	face window header green
	face window bold default+b
	face window italic default+i
	face window mono default
	face window block blue+b
	face window link magenta+b
	face window bullet yellow
	face window list yellow

	# builtin facesglobal
	face window Default default
	face window PrimarySelection black,white
	face window SecondarySelection white,blue
	face window PrimaryCursor black,white
	face window PrimaryCursorEol black,white
	face window SecondaryCursor black,white
	face window SecondaryCursorEol black,white
	face window LineNumbers yellow
	face window LineNumberCursor yellow+b
	face window MenuForeground black,white
	face window MenuBackground white,blue
	face window MenuInfo default+i
	face window Information yellow+b
	face window Error black,red
	face window StatusLine default
	face window StatusLineMode magenta+b
	face window StatusLineInfo green
	face window StatusLineValue magenta+b
	face window StatusCursor black,white
	face window Prompt yellow
	face window MatchingChar white+b
	face window BufferPadding blue
	face window Whitespace blue
}

define-command -hidden _setup-color %{ evaluate-commands %sh{
	if [ $TERM = linux ] ; then
		echo console-color
	else
		echo nop
	fi
}}
hook global WinDisplay .* %{  _setup-color }
