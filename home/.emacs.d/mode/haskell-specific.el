;(add-hook 'haskell-mode-hook #'haskell-mode-hooks)
(with-eval-after-load 'haskell-mode
  (require 'mode-local)
  (setq-mode-local haskell-mode
                   tab-width 2
                   evil-shift-width 2)
  (add-to-list 'company-backends 'company-ghc)
  (require 'evil)
  (evil-define-key 'insert haskell-indentation-mode-map
    [return] #'haskell-indentation-newline-and-indent)
  (add-hook 'company-completion-started-hook
            #'(lambda (_) (advice-add #'haskell-indentation-newline-and-indent
                                      :before
                                      #'company-abort)))
  (add-hook 'company-completion-cancelled-hook
            #'(lambda (_) (advice-remove #'haskell-indentation-newline-and-indent
                                         #'company-abort)))
  )


(provide 'haskell-specific)
