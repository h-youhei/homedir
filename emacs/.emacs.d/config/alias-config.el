(require 'autoload-init)

(defalias 'rc #'reload-config)

(defalias 'pd #'package-delete)
(defalias 'pl #'package-list-packages)
(defalias 'par #'package-autoremove)
(defalias 'pu #'package-update)

(require 'flycheck)
;;; Error List
(defalias 'el #'flycheck-list-errors)

;;; View Modified
(defalias 'vm #'quick-diff)

;;; Delete Auto Save
(defalias 'das '(lambda () (interactive) (delete-file buffer-auto-save-file-name)))
;;; View diff between current buffer and Auto Save
(defalias 'ras #'recover-this-file)

(provide 'alias-config)
