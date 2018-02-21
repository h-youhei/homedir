(require 'yasnippet)

;;;###autoload
(defun load-yas-expand ()
  (interactive)
  (yas-global-mode 1)
  (yas-expand))
;;;###autoload
(defun load-yas-new-snippet ()
  (interactive)
  (yas-global-mode 1)
  (yas-new-snippet))
;;;###autoload
(defun load-yas-visit-snippet-file ()
  (interactive)
  (yas-global-mode 1)
  (yas-visit-snippet-file))
;;;###autoload
(defun load-yas-insert-snippet ()
  (interactive)
  (yas-global-mode 1)
  (yas-insert-snippet))

(require 'evil)
;;;###autoload
(defun yas-visual-expand ()
  (interactive)
  (yas-insert-snippet)
  (evil-insert nil))

;;;###autoload
(defun load-yas-visual-expand ()
  (interactive)
  (yas-global-mode 1)
  (yas-visual-expand))

(provide 'yasnippet-plus)
