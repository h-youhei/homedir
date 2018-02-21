(require 'evil)
(require 'evil-surround)

;;;###autoload
(evil-define-operator evil-surround-whole-line (beg end type char)
	"Surround whole line with CHAR."
	:motion evil-line
	(interactive "<R>c")
	(evil-surround-region beg end type char))

;;;###autoload
(evil-define-operator evil-surround-whole-word (beg end type char)
	"Surround whole word with CHAR."
	:motion evil-inner-word
	(interactive "<R>c")
	(evil-surround-region beg end type char))

;;;###autoload
(evil-define-operator evil-surround-whole-WORD (beg end type char)
	"Surround COUNT WORDS with CHAR."
	:motion evil-inner-word
	(interactive "<R>c")
	(evil-surround-region beg end type char))

(provide 'evil-surround-plus)
