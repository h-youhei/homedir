(require 'evil)

;;;###autoload
(evil-define-operator evil-change-whole-word (beg end type register yank-handler)
	"Change whole word"
	:motion evil-inner-word
	(interactive "<R><x>")
	(evil-change beg end type register yank-handler #'evil-delete))

;;;###autoload
(evil-define-operator evil-change-whole-WORD (beg end type register yank-handler)
	"Change whole WORD"
	:motion evil-inner-WORD
	(interactive "<R><x>")
	(evil-change beg end type register yank-handler #'evil-delete))

;;;###autoload
(evil-define-operator evil-delete-whole-word (beg end type register yank-handler)
	"Delete whole word"
	:motion evil-a-word
	(interactive "<R><x>")
	(evil-delete beg end type register yank-handler))

;;;###autoload
(evil-define-operator evil-delete-whole-WORD (beg end type register yank-handler)
	"Delete whole WORD"
	:motion evil-a-WORD
	(interactive "<R><x>")
	(evil-delete beg end type register yank-handler))

;;;###autoload
(evil-define-operator evil-yank-whole-word (beg end type register yank-handler)
	"Yank whole word"
	:motion evil-inner-word
	:move-point nil
	:repeat nil
	(interactive "<R><x>")
	(evil-yank beg end type register yank-handler))

;;;###autoload
(evil-define-operator evil-yank-whole-WORD (beg end type register yank-handler)
	"Yank whole WORD"
	:motion evil-inner-WORD
	:move-point nil
	:repeat nil
	(interactive "<R><x>")
	(evil-yank beg end type register yank-handler))

(evil-define-operator evil-upcase-whole-word (beg end type register)
	"Upcase whole word"
	:motion evil-a-word
	(interactive "<r>")
	(evil-upcase beg end type))

(evil-define-operator evil-downcase-whole-word (beg end type register)
	"Howncase whole word"
	:motion evil-a-word
	(interactive "<R>")
	(evil-downcase beg end type))
	
(provide 'evil-operate-word)
