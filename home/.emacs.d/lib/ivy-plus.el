(require 'ivy)
;; from counsel.el
;;;###autoload
(defun counsel-recentf ()
  (interactive)
  (require 'recentf)
  (ivy-read "Recentf: " (mapcar #'substring-no-properties recentf-list)
            :action (lambda (f)
                      (with-ivy-window (find-file f)))
            :re-builder 'ivy--regex-fuzzy
            :caller 'counsel-recentf))

;;;###autoload
(defun counsel-bookmark ()
  "Forward to 'bookmark-jump' or 'bookmark-set' if bookmark doesn't exist."
  (interactive)
  (require 'bookmark)
  (ivy-read "Bookmark: " (bookmark-all-names)
            :action (lambda (x)
                      (let ((exist (member x (bookmark-all-names))))
                        (cond ((and exist
                                    (file-directory-p (bookmark-location x)))
                               (with-ivy-window
                                 (let ((default-directory (bookmark-location x)))
                                   (find-file))))
                              (exist
                               (with-ivy-window
                                 (bookmark-jump x)))
                              (t
                               (bookmark-set x)))))
            :caller 'counsel-bookmark))
(ivy-set-actions
 'counsel-bookmark
 '(("d" bookmark-delete "delete")
   ("r" bookmark-rename "rename")))

(provide 'ivy-plus)
