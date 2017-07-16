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
  (let ((state (shell-command-to-string "ibus engine")))
    (string-match-p ibus-engine state)))

(defun ibus-turn-on ()
  (shell-command-no-echo (concat "ibus engine " ibus-engine)))

(defun ibus-turn-off ()
  (shell-command-no-echo (concat "ibus engine " ibus-direct)))

(provide 'ibus)
