(require 'evil)

(defmacro evil-ex-range-string ()
	'(list
		(let ((s (concat
			(cond
				((and
					(evil-visual-state-p)
					evil-ex-visual-char-range
					(memq (evil-visual-type) '(inclusive exclusive)))
				"`<,`>")
				((evil-visual-state-p)
				"'<,'>")
				(current-prefix-arg
					(let ((arg (prefix-numeric-value current-prefix-arg)))
					(cond
						((< arg 0) (setq arg (1+ arg)))
						((> arg 0) (setq arg (1- arg))))
					(if (= arg 0) '(".") (format ".,.%+d" arg)))))
			evil-ex-initial-input)))
		(and (> (length s) 0) s))))

;;;###autoload
(evil-define-command evil-ex-interactive-substitute (&optional range)
	(interactive (evil-ex-range-string))
	(evil-ex (concat range "s/")))

(provide 'evil-ex-interactive)
