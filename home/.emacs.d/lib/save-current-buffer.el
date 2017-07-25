(require 'save-visited-files)

(defcustom save-current-buffer-location (locate-user-emacs-file
                                         ".current-buffer")
  "Location of the file that contains the current buffer"
  :type 'file
  :group 'save-current-buffer)

(defun save-current-buffer-get ()
  (when (minibufferp (current-buffer))
    (other-window 1))
  (buffer-name (current-buffer)))

(defun save-current-buffer-ignore-p (buffer)
  (or (null buffer)
      (not (stringp buffer))))

(defun save-current-buffer-save ()
  (let ((buffer-name (save-current-buffer-get)))
    (with-temp-file save-current-buffer-location
      (ignore-errors
        (erase-buffer)
        (insert buffer-name "\n")))))

(defun save-current-buffer-restore ()
  (with-temp-buffer
    (insert-file-contents save-current-buffer-location)
    (ignore-errors
      (goto-char (point-min))
      (let ((buffer-name (buffer-substring-no-properties (line-beginning-position)
                                                         (line-end-position))))
        (unless (save-current-buffer-ignore-p buffer-name)
          (switch-to-buffer buffer-name nil 'force-same-window))))))

;;;###autoload
(define-minor-mode save-current-buffer-mode
  "Minor mode to automatically save current buffer, and show the buffer after save-visited-file restore files"
  :init-value nil
  :global t
  :group 'save-current-buffer

  (if save-current-buffer-mode
      (progn
        (add-hook 'kill-emacs-hook #'save-current-buffer-save)
        (advice-add 'save-visited-files-restore
                    :after
                    #'save-current-buffer-restore)
        (message "Save current buffer mode eenabled"))

    (remove-hook 'kill-emacs-hook #'save-current-buffer-save)
    (message "Save current buffer mode disabled")))

(provide 'save-current-buffer)
