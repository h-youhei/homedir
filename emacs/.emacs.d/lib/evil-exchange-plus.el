(require 'evil)
(require 'evil-exchange)

;;;###autoload
(evil-define-operator evil-exchange-whole-line (beg end type)
	"Exchange line."
	:motion evil-line
	(interactive "<R>")
	(evil-exchange beg end type))

;;;###autoload
(evil-define-operator evil-exchange-whole-word (beg end type)
	"Exchange word."
	:motion evil-a-word
	(interactive "<R>")
	(evil-exchange beg end type))

;;;###autoload
(evil-define-operator evil-exchange-whole-WORD (beg end type)
	"Exchange WORD."
	:motion evil-a-WORD
	(interactive "<R>")
	(evil-exchange beg end type))

(provide 'evil-exchange-plus)
