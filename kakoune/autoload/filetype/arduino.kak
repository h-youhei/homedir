hook global BufCreate .*\.ino$ %{
	set-option buffer filetype c
}

