(column-number-mode 1)

(setq-default mode-line-format (list
	" %e"

	"<"
	'(:eval (mode-line-input-method-state))
	"> "

	'(:eval (mode-line-evil-state))

	'(:eval current-buffer-directory)
	mode-line-buffer-identification
	;" %b" ; buffer name
	'(:eval (if buffer-read-only "[RO]" ""))
	'(:eval (if (buffer-modified-p) "[+]" ""))
	
	mode-line-remote

	;git
	;project root/~/currentdir
	
	; right align

	" "
	'(:eval (mode-line-major-mode))

	;character encoding and line break type
	" ["
	'(:eval (symbol-name buffer-file-coding-system))
	"] "

	" (%c,%l/"
	'(:eval (format "%s" (line-number-at-pos (point-max))))
	")" ; (column,line/total)

	))

(defun mode-line-right-align (right))

(defun mode-line-input-method-state ()
	"A")

(defun mode-line-major-mode ()
	(if (string-match "Fundamental" mode-name)
		""
		mode-name))

(defun mode-line-evil-state ()
	(let ((s
		(cond
			((or (evil-normal-state-p) (evil-motion-state-p))
				"")
			((evil-insert-state-p)
				"--Insert--")
			((evil-visual-state-p)
				"--Visual--")
			((evil-replace-state-p)
				"--Replace--")
			((evil-emacs-state-p)
				"--Emacs-- ")
			(t
				"Waiting"))))
		(format "%-11s" s)))

(defun shorten-directory (dir per hierarchy cur-max-len)
	"Cut parent directory and shorten current directory.
PER is max number of characters per hierarchy.
HIERARCHY is max number of path hierarchies from current directory"
	(let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
		  (current "")
		  (parent ""))
		;empty string is created by split-string
		;if there's trailing slash
		(when (and path (equal "" (car path)))
			(setq path (cdr path)))

		(setq current (pop path))
		(setq current (substring current 0 (min (length current) cur-max-len)))

		(setq count 0)
		(while (and path (< count hierarchy))
			(let ((this (car path)))
				(setq parent (concat
					(substring this 0 (min per (length this)))
					"/"
					parent)))
			(setq path (cdr path))
			(setq count (1+ count)))
		(when path
			(setq parent (concat "../" parent)))
		(concat parent current "/")))

(defvar current-buffer-directory nil)
(make-variable-buffer-local 'current-buffer-directory)
(put 'current-buffer-directory 'permanent-local t)
(defun set-current-buffer-directory ()
	(when buffer-file-name ;not special buffer, e.g. *scratch*
		(setq current-buffer-directory (shorten-directory default-directory 3 3 8))))

(add-hook 'find-file-hook #'set-current-buffer-directory)
