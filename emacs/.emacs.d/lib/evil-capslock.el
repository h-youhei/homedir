(require 'evil)

(defgroup evil-capslock nil
  ""
  :group 'External)

(defcustom evil-capslock-auto-switch-insert t
  "whether switch input method automatically when you entry or exit insert state."
  :type 'bool
  :group 'evil-capslock)

(defcustom evil-capslock-auto-switch-replace t
  "whether switch input method automatically when you entry or exit replace state."
  :type 'bool
  :group 'evil-capslock)

(defcustom evil-capslock-auto-switch-method 'keep
  "keep: turn off capslock when you exit insert state. restore state when you entry insert state.
drop: turn off capslock when you exit insert state. when you entry insert state, start direct input anyway."
  :type 'symbol
  :options '(keep drop)
  :group 'evil-capslock)

(defun capslock-toggle ()
  (with-temp-buffer (shell-command "xdotool key Caps_Lock" t)))

(defun get-capslock-state ()
  (let ((state (aref (shell-command-to-string
                      "xset q | grep LED | rev | cut -c1")
                     0)))
    (eq state ?1)))

(defun capslock-turn-on ()
  (unless (get-capslock-state)
    (capslock-toggle)))

(defun capslock-turn-off ()
  (when (get-capslock-state)
    (capslock-toggle)))

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

(define-minor-mode evil-capslock-auto-switch-mode
  "Switch capslock automatically when evil state changes."
  :init-value nil
  :group 'evil-capslock
  :global t

  (if evil-capslock-auto-switch-mode
      (evil-capslock--auto-switch-mode-initialize)
    (evil-capslock--auto-switch-mode-finalize)))

(defun evil-capslock--auto-switch-mode-initialize ()
  (when evil-capslock-auto-switch-insert
    (if (eq evil-capslock-auto-switch-method 'drop)
        (add-hook 'evil-insert-state-exit-hook #'capslock-turn-off)
      (add-hook 'evil-insert-state-exit-hook #'evil-capslock-backup)
      (add-hook 'evil-insert-state-entry-hook #'evil-capslock-restore)))
  (when evil-capslock-auto-switch-replace
    (if (eq evil-capslock-auto-switch-method 'drop)
        (add-hook 'evil-replace-state-exit-hook #'capslock-turn-off)
      (add-hook 'evil-replace-state-exit-hook #'evil-capslock-backup)
      (add-hook 'evil-replace-state-entry-hook #'evil-capslock-restore))))

(defun evil-capslock--auto-switch-mode-finalize ()
  (when evil-capslock-auto-switch-insert
    (if (eq evil-capslock-auto-switch-method 'drop)
        (remove-hook 'evil-insert-state-exit-hook #'capslock-turn-off)
      (remove-hook 'evil-insert-state-exit-hook #'evil-capslock-backup)
      (remove-hook 'evil-insert-state-entry-hook #'evil-capslock-restore)))
  (when evil-capslock-auto-switch-replace
    (if (eq evil-capslock-auto-switch-method 'drop)
        (remove-hook 'evil-replace-state-exit-hook #'capslock-turn-off)
      (remove-hook 'evil-replace-state-exit-hook #'evil-capslock-backup)
      (remove-hook 'evil-replace-state-entry-hook #'evil-capslock-restore))))

(provide 'evil-capslock)
