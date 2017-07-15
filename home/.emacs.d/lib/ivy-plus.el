(require 'ivy)
;; from counsel.el
(defun ivy-recentf ()
  (interactive)
  (require 'recentf)
  (ivy-read "Recentf: " (mapcar #'substring-no-properties recentf-list)
            :action (lambda (f)
                      (with-ivy-window (find-file f)))
            :caller 'ivy-recentf))

(provide 'ivy-plus)
