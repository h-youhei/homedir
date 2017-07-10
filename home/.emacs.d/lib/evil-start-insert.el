(require 'evil)

(defun evil-simple-insert (count)
	(setq
		evil-insert-count count
		evil-insert-lines nil)
	(evil-insert-state 1))

;;;###autoload
(defun evil-insert-word (count)
	"Switch to insert state at beggining of current word.
The insertion will be repeated COUNT times."
	(interactive "p")
	(push (point) buffer-undo-list)
	(unless (bobp) (evil-backward-word-begin 1))
	(evil-simple-insert count))

;;;###autoload
(defun evil-insert-WORD (count)
	"Switch to insert state at beggining of current WORD.
The insertion will be repeated COUNT times."
	(interactive "p")
	(push (point) buffer-undo-list)
	(unless (bobp) (evil-backward-WORD-begin 1))
	(evil-simple-insert count))

;;;###autoload
(defun evil-append-word (count)
	"Switch to insert state at end of current word.
The insertion will be repeated COUNT times."
	(interactive "p")
	(push (point) buffer-undo-list)
	(unless (eobp)
		(evil-forward-word-end 1)
		(forward-char))
	(evil-simple-insert count)
	(add-hook 'post-command-hook #'evil-maybe-remove-spaces))

;;;###autoload
(defun evil-append-WORD (count)
	"Switch to insert state at end of current WORD.
The insertion will be repeated COUNT times."
	(interactive "p")
	(push (point) buffer-undo-list)
	(unless (eobp)
		(evil-forward-WORD-end 1)
		(forward-char))
	(evil-simple-insert count)
	(add-hook 'post-command-hook #'evil-maybe-remove-spaces))

;;;###autoload
(defun evil-break-line(count)
	"Break current line, insert COUNT empty lines, then start insert mode."
	(interactive "p")
	(unless (eq evil-want-fine-undo t) (evil-start-undo-step))
	(newline)
	(evil-open-above count))

(evil-define-operator evil-backward-substitute (beg end type register)
	"Change backward character"
	:motion evil-backward-char
	(interactive "<R><x>")
	(evil-change beg end type register))

(evil-declare-not-repeat #'evil-yank-line)

(provide 'evil-start-insert)
