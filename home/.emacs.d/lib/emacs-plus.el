(defun reload-config ()
	"reload config file"
	(interactive)
	(load-file (expand-file-name "init.el" user-emacs-directory)))

(provide 'emacs-plus)
