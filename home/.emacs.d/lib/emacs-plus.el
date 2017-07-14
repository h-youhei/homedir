(defun reload-config ()
  "reload config file"
  (interactive)
  (load-file (expand-file-name "init.el" user-emacs-directory)))

(defun shell-command-no-echo (command)
  (with-temp-buffer (shell-command command t)))

(defcustom terminal-command "urxvtc"
  "command that open terminal emulator
This value is used by open-terminal")

(defun open-terminal ()
  (interactive)
  (shell-command-no-echo terminal-command))

(provide 'emacs-plus)
