define-command  insert-with-count -hidden %{ execute-keys %sh{
	if [ $kak_count = 0 -o $kak_count = 1 ]; then
		echo i
	else
		echo "a.<esc>\;d${kak_count}P${kak_count}H<a-\;>Hs.<ret>c"
	fi
}}
define-command append-with-count -hidden %{ execute-keys %sh{
	if [ $kak_count = 0 -o $kak_count = 1 ]; then
		echo a
	else
		decremented=`expr $kak_count - 1`
		echo "a.<esc>\;y${kak_count}Pd${decremented}Hs.<ret>c"
	fi
}}
