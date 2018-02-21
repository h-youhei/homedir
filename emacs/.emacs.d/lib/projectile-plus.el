(require 'emacs-plus)
(require 'projectile)

(defun projectile-open-terminal ()
  (interactive)
  (projectile-with-default-dir (projectile-project-root)
    (open-terminal)))

(provide 'projectile-plus)
