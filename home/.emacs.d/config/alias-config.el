(require 'autoload-init)

(defalias 'rc #'reload-config)

(defalias 'pd #'package-delete)
(defalias 'pl #'package-list-packages)
(defalias 'par #'package-autoremove)

(require 'flycheck)
;;; Error List
(defalias 'el #'flycheck-list-errors)

(provide 'alias-config)
