;;;###autoload
(defun reload-config ()
  "reload config file"
  (interactive)
  (load-file (locate-user-emacs-file "init.el")))

(defun shell-command-no-echo (command)
  (with-temp-buffer (shell-command command t)))

(defgroup emacs-plus nil ""
  :group 'Convenience)
(defcustom terminal-command "urxvtc"
  "command that open terminal emulator
This value is used by open-terminal"
  :group 'emacs-plus
  )

;;;###autoload
(defun open-terminal ()
  (interactive)
  (shell-command-no-echo terminal-command))

;;;###autoload
(defun quick-diff ()
  "View diff the current modified changes with the saved version."
  (interactive)
  (diff-buffer-with-file (current-buffer)))

;;;###autoload
(defun smart-switch-window ()
  "Switch to other window. If there's only one window, switch to other buffer"
  (interactive)
  (if (> (length (window-list)) 1)
      (other-window 1)
    (switch-to-buffer (other-buffer (current-buffer)))))

(provide 'emacs-plus)
