(with-eval-after-load 'lisp-mode
	(require 'mode-local)
	(setq-mode-local lisp-interaction-mode indent-tabs-mode nil)
	(setq-mode-local emacs-lisp-mode indent-tabs-mode nil)
	)

(provide 'lisp-specific)
