declare-option -hidden bool capslock_was_on false

#not a tty in kakoune
define-command capslock-turn-on %{ %sh{
	#if [ $TERM = linux ] ; then
		#setleds caps < $TTY
	#else
		state=`xset q | grep LED | rev | cut -c1`
		[ $state -eq 0 ] && echo 'capslock-toggle'
	#fi
}}

define-command capslock-turn-off %{ %sh{
	#if [ $TERM = linux ] ; then
		#setleds -F -caps < $TTY
	#else
		state=`xset q | grep LED | rev | cut -c1`
		[ $state -eq 1 ] && echo 'capslock-toggle'
	#fi
}}

define-command -hidden capslock-toggle %{ %sh{
	xdotool key Caps_Lock
}}
	
define-command -hidden capslock-turn-off-with-state %{ %sh{
	#if [ $TERM = linux ] ; then
		#state=`setleds | awk 'NR==2 { print $6 } ' < $TTY`
		#if [ $state = on ] ; then
			#setleds -F -caps < $TTY
			#echo 'set-option global capslock_was_on true'
		#else
			#echo 'set-option global capslock_was_on false'
		#fi
	#else
		state=`xset q | grep LED | rev | cut -c1`
		if [ $state -eq 1 ] ; then
			echo 'set-option global capslock_was_on true'
			echo 'capslock-toggle'
		else
			echo 'set-option global capslock_was_on false'
		fi
	#fi
}}

define-command -hidden capslock-restore-state %{ %sh{
	[ $kak_opt_capslock_was_on = true ] && echo 'capslock-turn-on'
}}

define-command -docstring 'Turn off capslock when you go back normal mode.
Turn on capslock when you enter insert mode,
if it was on when you left insert mode last time.' \
setup-capslock-auto-switch %{
	remove-hooks global capslock
	hook -group capslock global ModeChange insert:normal %{ capslock-turn-off-with-state }
	hook -group capslock global ModeChange normal:insert %{ capslock-restore-state }
	hook -group capslock global ModeChange prompt:normal %{ capslock-turn-off }
}

define-command -docstring 'turn off capslock when you go back normal mode.' \
setup-capslock-auto-off %{
	remove-hooks global capslock
	hook -group capslock global ModeChange insert:normal %{ capslock-turn-off }
	hook -group capslock global ModeChange prompt:normal %{ capslock-turn-off }
}
