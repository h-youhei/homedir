(add-to-list 'load-path (expand-file-name "lib" user-emacs-directory))

(require 'emacs-plus-autoload)
(require 'ibus-autoload)
(require 'evil-ibus-autoload)
(require 'evil-plus-autoload)
(require 'evil-smart-motion-autoload)

(require 'evil-surround-plus-autoload)

(require 'evil-exchange-plus-autoload)

(require 'projectile-plus-autoload)

(require 'ivy-plus-autoload)

(provide 'autoload-init)
