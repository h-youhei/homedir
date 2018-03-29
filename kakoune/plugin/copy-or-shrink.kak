define-command -hidden copy-or-shrink-upward %{ %sh{
	current=`echo $kak_selections_desc | cut -f 1 -d '.'`
	top=`echo $kak_selections_desc | cut -f 2 -d ':' | cut -f 1 -d '.'`
	#should use gt here, to handle case having only one selection
	if [ $current -gt $top ] ; then
		echo "execute-keys '<a-space>'"
	else
		echo "execute-keys '<a-C>'"
	fi
}}
define-command -hidden copy-or-shrink-downward %{ %sh{
	current=`echo $kak_selections_desc | cut -f 1 -d '.'`
	buttom=`echo $kak_selections_desc | rev | cut -f 1 -d ':' | rev | cut -f 1 -d '.'`
	#should use lt here, to handle case having only one selection
	if [ $current -lt $buttom ] ; then
		echo "execute-keys '<a-space>'"
	else
		echo 'execute-keys C'
	fi
}}
