(require 'mode-local)
(require 'evil)

(with-eval-after-load 'haskell-mode
  (setq-mode-local haskell-mode
                   tab-width 2
                   evil-shift-width 2)
  )

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

(eval-when-compile (require 'python))
(setq python-indent-offset 4)

(eval-when-compile (require 'markdown-mode))
(setq markdown-fontify-code-blocks-natively t)

(provide 'mode-specific-config)
