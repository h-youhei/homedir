"TODO windows mac

augroup capslock
	autocmd!
	au BufEnter,CmdwinEnter * let b:was_capslock_on = 0
	au InsertLeave * call capslock#inactivate_with_state()
	au InsertEnter * call capslock#restore_state()
augroup END
