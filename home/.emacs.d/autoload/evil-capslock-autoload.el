(autoload #'evil-capslock-backup "evil-capslock" "" t)
(autoload #'evil-capslock-restore "evil-capslock" "" t)

(add-hook 'evil-insert-state-exit-hook #'evil-capslock-backup)
(add-hook 'evil-insert-state-entry-hook #'evil-capslock-restore)
(add-hook 'evil-emacs-state-exit-hook #'evil-capslock-backup)
(add-hook 'evil-emacs-state-entry-hook #'evil-capslock-restore)
(add-hook 'evil-replace-state-exit-hook #'evil-capslock-backup)
(add-hook 'evil-replace-state-entry-hook #'evil-capslock-restore)

(provide 'evil-capslock-autoload)
