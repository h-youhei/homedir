(add-to-list 'load-path (expand-file-name "lib" user-emacs-directory))

(require 'autoload-evil-start-insert)
(require 'autoload-evil-operate-word)
(require 'autoload-evil-smart-motion)
(require 'autoload-evil-ex-interactive)
(require 'autoload-misc)

(require 'autoload-evil-surround-plus)

(require 'autoload-evil-exchange-plus)

(provide 'init-autoload)
