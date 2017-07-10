(defun reload-config ()
	"reload config file"
	(interactive)
	(load-file (expand-file-name "init.el" user-emacs-directory)))

(require 'evil)
(evil-define-operator evil-rectangle-number-lines (beg end type count)
	"If COUNT given, number lines start from COUNT"
	(interactive "<R>P")
	(rectangle-number-lines beg end (if count count 1)))

(evil-define-command evil-repeat-macro (count macro)
	:repeat nil
	(interactive
		(let (count macro)
			(setq
				count (if current-prefix-arg
					(if (numberp current-prefix-arg)
						current-prefix-arg
						0) 1))
			(cond
				((eq evil-last-register ?:)
					(setq
						macro (lambda () (evil-ex-repeat nil))
						evil-last-register ?:))
				(t
					(unless evil-last-register
						(user-error "No previously executed keyboard macro."))
					(setq macro (evil-get-register evil-last-register t))))
			(list count macro)))
	(evil-execute-macro count macro))

(evil-define-command evil-save-and-delete-buffer ()
	:repeat nil
	(interactive)
	(save-buffer)
	(evil-delete-buffer nil))

(provide 'misc)
