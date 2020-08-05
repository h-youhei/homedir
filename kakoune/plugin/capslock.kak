declare-option -hidden bool capslock_was_on false

#not a tty in kakoune
define-command capslock-turn-on %{ evaluate-commands %sh{
	#if [ $TERM = linux ] ; then
		#setleds caps < $TTY
	#else
		state=`xset q | grep LED | rev | cut -c1`
		state=`expr $state % 2`
		if [ $state -eq 0 ] ; then
			echo 'capslock-toggle'
		else
			echo nop
		fi
	#fi
}}

define-command capslock-turn-off %{ evaluate-commands %sh{
	#if [ $TERM = linux ] ; then
		#setleds -F -caps < $TTY
	#else
		state=`xset q | grep LED | rev | cut -c1`
		state=`expr $state % 2`
		if [ $state -eq 1 ] ; then
			echo 'capslock-toggle'
		else
			echo nop
		fi
	#fi
}}

define-command -hidden capslock-toggle %{ %sh{
	xdotool key Caps_Lock
	echo nop
}}

define-command -hidden capslock-turn-off-with-state %{ evaluate-commands %sh{
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
		state=`expr $state % 2`
		if [ $state -eq 1 ] ; then
			echo 'set-option global capslock_was_on true'
			echo 'capslock-toggle'
		else
			echo 'set-option global capslock_was_on false'
		fi
	#fi
}}

define-command -hidden capslock-restore-state %{ evaluate-commands %sh{
	if [ $kak_opt_capslock_was_on = true ] ; then
		echo 'capslock-turn-on'
	else
		echo nop
	fi
}}

define-command -docstring 'Turn off capslock when you go back normal mode.
Turn on capslock when you enter insert mode,
if it was on when you left insert mode last time.' \
setup-capslock-auto-switch %{
	remove-hooks global capslock
	hook -group capslock global ModeChange pop:insert:normal %{ capslock-turn-off-with-state }
	hook -group capslock global ModeChange push:normal:insert %{ capslock-restore-state }
	hook -group capslock global ModeChange pop:prompt:normal %{ capslock-turn-off }
}

define-command -docstring 'turn off capslock when you go back normal mode.' \
setup-capslock-auto-off %{
	remove-hooks global capslock
	hook -group capslock global ModeChange pop:insert:normal %{ capslock-turn-off }
	hook -group capslock global ModeChange pop:prompt:normal %{ capslock-turn-off }
}
