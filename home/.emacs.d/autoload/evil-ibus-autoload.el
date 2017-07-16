(autoload 'evil-ibus-backup "evil-ibus" "" t)
(autoload 'evil-ibus-restore "evil-ibus" "" t)

(add-hook 'evil-insert-state-exit-hook #'evil-ibus-backup)
(add-hook 'evil-insert-state-entry-hook #'evil-ibus-restore)
(add-hook 'evil-emacs-state-exit-hook #'evil-ibus-backup)
(add-hook 'evil-emacs-state-entry-hook #'evil-ibus-restore)
(add-hook 'evil-replace-state-exit-hook #'evil-ibus-backup)
(add-hook 'evil-replace-state-entry-hook #'evil-ibus-restore)

(provide 'evil-ibus-autoload)
