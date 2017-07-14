(require 'emacs-plus)

(defgroup ibus nil
  "ibus state controller"
  :prefix "ibus-")

(defcustom ibus-direct "xkb:us::eng"
  ""
  :type 'string
  :group 'ibus)

(defcustom ibus-engine "mozc-jp"
  ""
  :type 'string
  :group 'ibus)

(defun get-ibus-state ()
  (interactive)
  (let ((state (shell-command-to-string "ibus engine")))
    (string-match-p ibus-engine state)))

(defun ibus-activate ()
  (interactive)
  (shell-command-no-echo (concat "ibus engine " ibus-engine)))

(defun ibus-inactivate ()
  (interactive)
  (shell-command-no-echo (concat "ibus engine " ibus-direct)))

(provide 'ibus)
