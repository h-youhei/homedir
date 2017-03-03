augroup fcitx
	autocmd!
	au BufEnter,CmdwinEnter * let b:was_fcitx_on = 0
	au InsertLeave * call fcitx#inactivate_with_state()
	au InsertEnter * call fcitx#restore_state()
augroup END
