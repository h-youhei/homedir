(require 'ibus)
(require 'evil)

(defvar evil-ibus-state nil
  "ibus state when to leave insert, emacs and replace state.
Non-nil means ibus is running.
nil means ibus is not running.")

(defun evil-ibus-inactivate ()
  (interactive)
  (setq evil-ibus-state (get-ibus-state))
  (ibus-inactivate))

(defun evil-ibus-restore ()
  (interactive)
  (when evil-ibus-state
    (ibus-activate)))

(provide 'evil-ibus)
