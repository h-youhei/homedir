;(add-hook 'haskell-mode-hook #'haskell-mode-hooks)
(require 'mode-local)

(with-eval-after-load 'haskell-mode
  (setq-mode-local haskell-mode
                   tab-width 2
                   evil-shift-width 2)

  (evil-define-key 'insert haskell-indentation-mode-map
    [return] #'haskell-indentation-newline-and-indent)

  ;; to integrate evil-maybe-remove-spaces
  (add-hook 'company-completion-started-hook
            #'(lambda (_) (advice-add #'haskell-indentation-newline-and-indent
                                      :before
                                      #'company-abort)))
  (add-hook 'company-completion-cancelled-hook
            #'(lambda (_) (advice-remove #'haskell-indentation-newline-and-indent
                                         #'company-abort)))
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
