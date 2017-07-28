(require 'mode-local)
(require 'evil)

(setq-mode-local haskell-mode
                 tab-width 2
                 evil-shift-width 2)


(setq-mode-local lisp-interaction-mode
                 indent-tabs-mode nil
                 tab-width 2
                 evil-shift-width 2
                 )
(setq-mode-local emacs-lisp-mode
                 indent-tabs-mode nil
                 tab-width 2
                 evil-shift-width 2
                 )
(require 'bool-flip)
(defun setup-lisp-bool-flip ()
  (make-local-variable 'bool-flip-alist)
  (push '("t" . "nil") bool-flip-alist))
(add-hook 'emacs-lisp-mode-hook #'setup-lisp-bool-flip)


(setq python-indent-offset 4)


(setq markdown-fontify-code-blocks-natively t)


(setq-mode-local sgml-mode
                 tab-width 2
                 evil-shift-width 2)

(provide 'mode-specific-config)
