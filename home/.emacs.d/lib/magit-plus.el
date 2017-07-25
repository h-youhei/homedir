(require 'evil)
(require 'magit)

(defun git-commit-evil-maybe-start-insert ()
  "Start insert when gitcommit except amend."
  (let ((first-line (buffer-substring-no-properties (line-beginning-position)
                                                    (line-end-position))))
    (when (string-match-p "^$" first-line)
      (evil-insert-state))))

(defun magit-status-init ()
  "set cursor to Unstaged or Untracked section"
  (let* ((unstaged-section (magit-get-section '((unstaged) (status))))
         (untracked-section (magit-get-section '((untracked) (status))))
         (dest (or unstaged-section untracked-section)))
    (when dest
      (magit-section-goto dest)
      (magit-section-forward))))

(provide 'magit-plus)
