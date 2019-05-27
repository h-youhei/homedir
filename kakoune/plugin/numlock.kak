#not a tty in kakoune
define-command numlock-turn-on %{ evaluate-commands %sh{
	#if [ $TERM = linux ] ; then
		#setleds num < $TTY
	#else
		state=`xset q | grep LED | rev | cut -c1`
		#Num_Lock is second bit.
		#'/ 2' shift to right 1 bit so Num_Lock is now first bit.
		#'% 2' check first bit is on.
		state=`expr $state / 2 % 2`
		if [ $state -eq 0 ] ; then
			echo 'numlock-toggle'
		else
			echo nop
		fi
	#fi
}}

define-command numlock-turn-off %{ evaluate-commands %sh{
	#if [ $TERM = linux ] ; then
		#setleds -F -num < $TTY
	#else
		state=`xset q | grep LED | rev | cut -c1`
		#Num_Lock is second bit.
		#'/ 2' shift to right 1 bit so Num_Lock is now first bit.
		#'% 2' check first bit is on.
		state=`expr $state / 2 % 2`
		if [ $state -eq 1 ] ; then
			echo 'numlock-toggle'
		else
			echo nop
		fi
	#fi
}}

define-command -hidden numlock-toggle %{ %sh{
	xdotool key Num_Lock
	echo nop
}}
