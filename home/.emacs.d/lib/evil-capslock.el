(require 'capslock)
(require 'evil)

(defvar evil-capslock-state nil
  "capslock state when to leave insert, emacs and replace state.
Non-nil means capslock is running.
nil means capslock is not running.")

(defun evil-capslock-backup ()
  (setq evil-capslock-state (get-capslock-state))
  (capslock-turn-off))

(defun evil-capslock-restore ()
  (when evil-capslock-state
    (capslock-turn-on)))

(provide 'evil-capslock)
