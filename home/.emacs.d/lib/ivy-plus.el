(require 'ivy)
(require 'counsel)
(require 'cl-lib)

(defun ivy-plus--match-string-by-func-or-regexp-p (seq-of-f-or-r target)
  (cl-find-if
   (lambda (f-or-r)
     (if (functionp f-or-r)
         (funcall f-or-r target)
       (string-match-p f-or-r target)))
   seq-of-f-or-r))

(defcustom ivy-ignore-files '("\\`\\.")
  "List of regexps or functions matching file names to ignore."
  :type '(repeat (choice regexp function)))

;;;###autoload
(defun ivy-plus-switch-buffer ()
  (interactive)
  (ivy-read "Switch to buffer: " #'internal-complete-buffer
            :matcher #'ivy-plus--switch-buffer-matcher
            :preselect (buffer-name (other-buffer (current-buffer)))
            :action #'ivy--switch-buffer-action
            :caller 'ivy-plus-switch-buffer))

(defun ivy-plus--switch-buffer-matcher (regexp candidates)
  (let ((res (ivy--re-filter regexp candidates)))
    (if (or (null ivy-use-ignore)
            (null ivy-ignore-buffers)
            (string-match "\\`\\*" ivy-text))
        res
      (or (cl-remove-if
           (lambda (buf)
             (ivy-plus--match-string-by-func-or-regexp-p ivy-ignore-buffers buf))
           res)
          res))))

(defun ivy-plus--kill-buffer-action (buffer)
  (kill-buffer buffer)
  (ivy--reset-state ivy-last))

(defun ivyplus--rename-buffer-action (buffer)
  (let ((new-name (read-string "Rename buffer (to new name): ")))
    (with-current-buffer buffer
      (rename-buffer new-name)))
  (ivy--reset-state ivy-last))

(ivy-set-actions
 'ivy-plus-switch-buffer
 '(("k" ivy-plus--kill-buffer-action "kill")
   ("r" ivy-plus--rename-buffer-action "rename")))

;;;###autoload
(defun ivy-plus-find-file ()
  (interactive)
  (ivy-read "Find file: " #'read-file-name-internal
            :matcher #'ivy-plus--find-file-matcher
            :action
            (lambda (x)
              (with-ivy-window
                (find-file x)))
            :require-match 'confirm-after-completion
            :history 'file-name-history
            :caller 'ivy-plus-find-file))

(defun ivy-plus--find-file-matcher (regexp candidates)
  (let ((res (ivy--re-filter regexp candidates)))
    (if (or (null ivy-use-ignore)
            (null ivy-ignore-files)
            (string-match "\\`\\." ivy-text))
        res
      (or (cl-remove-if
           (lambda (x)
             (and
              (not (member x ivy-extra-directories))
              (ivy-plus--match-string-by-func-or-regexp-p ivy-ignore-files x)))
           res)
          res))))

(ivy-set-actions
 'ivy-plus-find-file
 '(("s" counsel-find-file-as-root "sudo")))

(defun ivy-plus-with-find-directory (prompt action)
  (ivy-read prompt
            #'read-file-name-internal
            :matcher #'ivy-plus--find-directory-matcher
            :action action
            :require-match 'confirm-after-completion
            :caller 'ivy-plus-find-directory))

(defun ivy-plus--find-directory-matcher (regexp candidates)
  (let ((res (cl-remove-if-not
              (lambda (x) (string-match-p "/$" x))
              candidates)))
    (setq res (ivy--re-filter regexp res))
    (if (or (null ivy-use-ignore)
            (null ivy-ignore-files)
            (string-match "\\`\\." ivy-text))
        res
      (or (cl-remove-if
           (lambda (x)
             (and
              (not (member x ivy-extra-directories))
              (ivy-plus--match-string-by-func-or-regexp-p ivy-ignore-files x)))
           res)
          res))))

;;;###autoload
(defun ivy-plus-bookmark ()
  "Forward to 'bookmark-jump' or 'bookmark-set' if bookmark doesn't exist."
  (interactive)
  (require 'bookmark)
  (ivy-read "Bookmark: " #'ivy-plus--bookmark-function
            :action (lambda (x)
                      (let ((exist (member x (bookmark-all-names))))
                        (cond ((and exist
                                    (file-directory-p (bookmark-location x)))
                               (with-ivy-window
                                 (let ((default-directory (bookmark-location x)))
                                   (counsel-find-file)))
                               (bookmark-handle-bookmark x)
                               (run-hooks 'bookmark-after-jump-hook))
                              (exist
                               (with-ivy-window
                                 (bookmark-jump x)))
                              (t
                               (bookmark-set x)))))
            :caller 'ivy-plus-bookmark))

(defun ivy-plus--bookmark-function (&rest _)
  (bookmark-all-names))

(defun ivy-plus--bookmark-delete-action (bm)
  (let ((inhibit-message t))
    (bookmark-delete bm))
    (ivy--reset-state ivy-last))

(defun ivy-plus--bookmark-rename-action (bm)
  (let ((inhibit-message t))
    (bookmark-rename bm))
    (ivy--reset-state ivy-last))

(ivy-set-actions
 'ivy-plus-bookmark
 '(("d" ivy-plus--bookmark-delete-action "delete")
   ("r" ivy-plus--bookmark-rename-action "rename")))

(defun ivy-plus-ag-with-find-directory ()
  "Search directory then ag"
  (interactive)
  (ivy-plus-with-find-directory
   "where to start grep: "
   #'(lambda (x) (counsel-ag nil x))))

(provide 'ivy-plus)
