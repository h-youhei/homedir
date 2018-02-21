(require 'evil)

(defgroup evil-ibus nil
  ""
  :group 'External)

(defcustom ibus-direct "xkb:us::eng"
  "engine for direct input.
To show list, run the shell-command 'ibus list-engine'."
  :type 'string
  :group 'evil-ibus)

(defcustom ibus-engine "mozc-jp"
  "engine for non-ascii input.
 To show list, run the shell-command 'ibus list-engine"
  :type 'string
  :group 'evil-ibus)

(defcustom evil-ibus-auto-switch-insert t
  "whether switch input method automatically when you entry or exit insert state."
  :type 'bool
  :group 'evil-ibus)

(defcustom evil-ibus-auto-switch-replace t
  "whether switch input method automatically when you entry or exit replace state."
  :type 'bool
  :group 'evil-ibus)

(defcustom evil-ibus-auto-switch-method 'keep
  "keep: turn off ibus when you exit insert state. restore state when you entry insert state.
drop: turn off ibus when you exit insert state. when you entry insert state, start direct input anyway."
  :type 'symbol
  :options '(keep drop)
  :group 'evil-ibus)

;; (defcustom evil-ibus-auto-switch-search t
;;   "whether switch input method automatically when you entry or exit search state."
;;   :type 'bool
;;   :group 'ibus)

(defun get-ibus-state ()
  (let ((state (shell-command-to-string "ibus engine")))
    (string-match-p ibus-engine state)))

(defun shell-command-no-echo (command)
  (with-temp-buffer (shell-command command t)))

(defun ibus-turn-on ()
  (shell-command-no-echo (concat "ibus engine " ibus-engine)))

(defun ibus-turn-off ()
  (shell-command-no-echo (concat "ibus engine " ibus-direct)))

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

(define-minor-mode evil-ibus-auto-switch-mode
  "switch ibus automatically when evil state changes."
  :init-value nil
  :group 'ibus
  :global t

  (if evil-ibus-auto-switch-mode
      (evil-ibus--auto-switch-mode-initialize)
    (evil-ibus--auto-switch-mode-finalize)))

(defun evil-ibus--auto-switch-mode-initialize ()
  (when evil-ibus-auto-switch-insert
    (if (eq evil-ibus-auto-switch-method 'drop)
        (add-hook 'evil-insert-state-exit-hook #'ibus-turn-off)
      (add-hook 'evil-insert-state-exit-hook #'evil-ibus-backup)
      (add-hook 'evil-insert-state-entry-hook #'evil-ibus-restore)))
  (when evil-ibus-auto-switch-replace
    (if (eq evil-ibus-auto-switch-method 'drop)
        (add-hook 'evil-replace-state-exit-hook #'ibus-turn-off)
      (add-hook 'evil-replace-state-exit-hook #'evil-ibus-backup)
      (add-hook 'evil-replace-state-entry-hook #'evil-ibus-restore))))

(defun evil-ibus--auto-switch-mode-finalize ()
  (when evil-ibus-auto-switch-insert
    (if (eq evil-ibus-auto-switch-method 'drop)
        (remove-hook 'evil-insert-state-exit-hook #'ibus-turn-off)
      (remove-hook 'evil-insert-state-exit-hook #'evil-ibus-backup)
      (remove-hook 'evil-insert-state-entry-hook #'evil-ibus-restore)))
  (when evil-ibus-auto-switch-replace
    (if (eq evil-ibus-auto-switch-method 'drop)
        (remove-hook 'evil-replace-state-exit-hook #'ibus-turn-off)
      (remove-hook 'evil-replace-state-exit-hook #'evil-ibus-backup)
      (remove-hook 'evil-replace-state-entry-hook #'evil-ibus-restore))))

;; (when evil-ibus-auto-switch-search)

(provide 'evil-ibus)
