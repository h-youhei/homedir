;(add-hook 'haskell-mode-hook #'haskell-mode-hooks)
(require 'mode-local)

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


(setq python-indent-offset 4)
