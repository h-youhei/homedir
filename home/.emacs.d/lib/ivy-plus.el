(require 'ivy)
(require 'cl-lib)

(defun match-string-by-func-or-regexp-p (seq-of-f-or-r target)
  (cl-find-if
   (lambda (f-or-r)
     (if (functionp f-or-r)
         (funcall f-or-r target)
       (string-match-p f-or-r target)))
   seq-of-f-or-r))

(defun counsel--switch-buffer-matcher (regexp candidates)
  (let ((res (ivy--re-filter regexp candidates)))
    (if (or (null ivy-use-ignore)
            (null ivy-ignore-buffers)
            (string-match "\\`\\*" ivy-text))
        res
      (or (cl-remove-if
           (lambda (buf)
             (match-string-by-func-or-regexp-p ivy-ignore-buffers buf))
           res)
          res))))

(defcustom ivy-ignore-files '("\\`\\.")
  "List of regexps or functions matching file names to ignore."
  :type '(repeat (choice regexp function)))

(defun counsel--find-file-matcher (regexp candidates)
  (let ((res (ivy--re-filter regexp candidates)))
    (if (or (null ivy-use-ignore)
            (null ivy-ignore-files)
            (string-match "\\`\\." ivy-text))
        res
      (or (cl-remove-if
           (lambda (x)
             (and
              (not (member x ivy-extra-directories))
              (match-string-by-func-or-regexp-p ivy-ignore-files x)))
           res)
          res))))

;;;###autoload
(defun counsel-switch-buffer ()
  (interactive)
  (ivy-read "Switch to buffer: " 'internal-complete-buffer
            :matcher #'counsel--switch-buffer-matcher
            :preselect (buffer-name (other-buffer (current-buffer)))
            :action #'ivy--switch-buffer-action
            :caller 'counsel-switch-buffer))

(defun ivy--kill-buffer-action (buf)
  (kill-buffer buf)
  (ivy--reset-state ivy-last))

(ivy-set-actions
 'counsel-switch-buffer
 '(("k" ivy--kill-buffer-action "kill")
   ("r" ivy--rename-buffer-action "rename")))

;;;###autoload
(defun counsel-find-file ()
  (interactive)
  (ivy-read "Find file: " 'read-file-name-internal
            :matcher #'counsel--find-file-matcher
            :action
            (lambda (x)
              (with-ivy-window
                (find-file x)))
            :require-match 'confirm-after-completion
            :history 'file-name-history
            :caller 'counsel-find-file))

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
                               (bookmark-handle-bookmark x)
                               (with-ivy-window
                                 (let ((default-directory (bookmark-location x)))
                                   (counsel-find-file)))
                               (run-hooks 'bookmark-after-jump-hook))
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
