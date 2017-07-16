(require 'ibus)
(require 'evil)

(defvar evil-ibus-state nil
  "ibus state when to leave insert, emacs and replace state.
Non-nil means ibus is running.
nil means ibus is not running.")

(defun evil-ibus-backup ()
  (setq evil-ibus-state (get-ibus-state))
  (ibus-turn-off))

(defun evil-ibus-restore ()
  (when evil-ibus-state
    (ibus-turn-on)))

(provide 'evil-ibus)
