(column-number-mode 1)

(setq-default mode-line-format
              '((:eval (mode-line-align
                        (concat
                         (format-mode-line " %e")
                         (mode-line-evil-state))
                        (concat
                         " "
                         (mode-line-directories)
                         ;; buffer name
                         (mode-line-buffer-name 12)
                         (if buffer-read-only " [RO]" "")
                         (if (buffer-modified-p) " [+]" "")
                         (mode-line-major-mode)
                         (mode-line-encoding)
                         (format-mode-line " (%c,%l/")
                         (format "%d" (line-number-at-pos (point-max)))
                         ")")))))

(defun mode-line-align (left right)
  (let ((available-width (- (window-total-width) (length left))))
    (format (format "%%s%%%ds" available-width) left right)))

(defun mode-line-buffer-name (max-length)
  (let ((name (buffer-name)))
    (substring name 0 (min (length name) max-length))))
(defun mode-line-directories ()
  (let ((parent
         (if (projectile-project-p)
             (if buffer-file-name ;not special buffer, e.g. *scratch*
                 (concat  "<" (projectile-project-name) ">/")
               "")
            mode-line-parent-directories)))
    (concat parent mode-line-current-directory)))

(defun mode-line-major-mode ()
  (if (string-match-p "Fundamental" mode-name)
      ""
    (concat " [" mode-name "]")))

(defun mode-line-encoding ()
  (let ((enc (symbol-name buffer-file-coding-system)))
    (cond ((and (string-match-p "unix" enc)
                (or (string-match-p "utf-8" enc)
                    (string-match-p "undecided" enc)))
           "")
          (t
           (concat " [" enc "]")))))

(defun mode-line-evil-state ()
  (let ((s
         (cond ((or (evil-normal-state-p) (evil-motion-state-p))
                "")
               ((evil-insert-state-p)
                "--Insert--")
               ((evil-visual-state-p)
                "--Visual--")
               ((evil-replace-state-p)
                "--Replace--")
               ((evil-emacs-state-p)
                "--Emacs-- ")
               (t
                "Waiting"))))
    (format "%-11s" s)))

(defun shorten-directory (dir per hierarchy cur-max-len)
  "Cut parent directory and shorten current directory.
PER is max number of characters per hierarchy.
HIERARCHY is max number of path hierarchies from current directory"
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
        (current "")
        (parent ""))
    ;; If there's trailing slash,
    ;; empty string is created by split-string
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))

    (setq current (pop path))
    (setq current (substring current 0 (min (length current) cur-max-len)))
    (setq current (concat current "/"))

    (setq count 0)
    (while (and path (< count hierarchy))
      (let ((this (car path)))
        (setq parent (concat (substring this 0 (min per (length this)))
                             "/"
                             parent)))
      (setq path (cdr path))
      (setq count (1+ count)))
    (when path
      (setq parent (concat "../" parent)))
    (list parent current)))

(defvar-local mode-line-current-directory nil)
(put 'mode-line-current-directory 'permanent-local t)
(defvar-local mode-line-parent-directories nil)
(put 'mode-line-parent-directories 'permanent-local t)

(defun set-current-buffer-directory ()
  (when buffer-file-name ;not special buffer, e.g. *scratch*
    (let ((dirs (shorten-directory default-directory 3 3 8)))
      (setq mode-line-parent-directories (pop dirs))
      (setq mode-line-current-directory (pop dirs)))))

(add-hook 'find-file-hook #'set-current-buffer-directory)
