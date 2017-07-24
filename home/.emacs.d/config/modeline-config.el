(column-number-mode 1)

(setq-default mode-line-format
              '((:eval (mode-line-align
                        (concat
                         (format-mode-line " %e")
                         (propertize (mode-line-evil-state) 'face 'bold))
                        (concat
                         " "
                         (mode-line-current-project-and-directory)
                         (propertize (mode-line-buffer-name 12) 'face 'bold)
                         (if buffer-read-only " [RO]" "")
                         (if (buffer-modified-p) " [+]" "")
                         (mode-line-major-mode)
                         (mode-line-encoding)
                         ;; (column,line/total line)
                         (format-mode-line " (%c,%l/")
                         (format "%d" (line-number-at-pos (point-max)))
                         ")")))))

;; wait fix the bug: window-total-width.
;; http://emacs.1067599.n8.nabble.com/bug-19972-24-4-Font-size-change-doesn-t-update-window-total-width-td351021.html
(defun mode-line-align (left right)
  (let ((available-width (- (window-total-width-workaround) (length left))))
    ;; after evaluated inner format, if available-width were 80
    ;; (format "%s%80s" left right)
    (format (format "%%s%%%ds" available-width) left right)))

(require 'nlinum)
(defun window-total-width-workaround ()
  ;; 2 is fringe
  (+ (window-width) 2 nlinum--width))

(defun digit (number)
  ;; return digit number of NUMBER
  (let ((count 0))
    (while (> number 0)
      (setq number (/ number 10))
      (setq count (1+ count)))
    count))

(defun mode-line-buffer-name (max-length)
  (let ((name (buffer-name)))
    (substring name 0 (min (length name) max-length))))

(require 'projectile)
(defvar-local mode-line-current-project-and-directory-cache nil)
(put 'mode-line-current-project-and-directory-cache 'permanent-local t)
(defun mode-line-current-project-and-directory ()
  (if mode-line-current-project-and-directory-cache
      mode-line-current-project-and-directory-cache
    (setq mode-line-current-project-and-directory-cache
          (if (null buffer-file-name) ;not special buffer, e.g. *scratch*
              ""
            (if (projectile-project-p)
                (concat "<"
                        (projectile-project-name)
                        ">/"
                        (mode-line-current-directory 1 12))
              (mode-line-current-directory 3 7 t))))))

(defun mode-line-major-mode ()
  ;; Ordinary case, show nothing.
  (if (string-match-p "Fundamental" mode-name)
      ""
    (concat " [" mode-name "]")))

(defun mode-line-encoding ()
  (let ((enc (symbol-name buffer-file-coding-system)))
    ;; Ordinary case, show nothing.
    (cond ((and (string-match-p "unix" enc)
                (or (string-match-p "utf-8" enc)
                    (string-match-p "undecided" enc)))
           "")
          (t
           (concat " [" enc "]")))))

(require 'evil)
(defun mode-line-evil-state ()
  (let ((s
         (cond ((evil-normal-state-p)
                "")
               ((evil-insert-state-p)
                "-- INSERT --")
               ((evil-visual-state-p)
                (cond ((eq evil-visual-selection 'block)
                       "-- V-BLOCK --")
                      ((eq evil-visual-selection 'line)
                       "-- V-LINE --")
                      (t
                       "-- VISUAL --")))
               ((evil-replace-state-p)
                "-- REPLACE --")
               ((evil-motion-state-p)
                "-- MOTION --")
               ((evil-emacs-state-p)
                "-- EMACS --")
               (t
                "Waiting"))))
    (format "%-11s" s)))

(defun shorten-string (string max-length)
  (substring string 0 (min max-length (length string))))

(defun split-path (directory)
  (let ((path (reverse (split-string
                        (abbreviate-file-name directory)
                        "/"))))
    ;; If there's trailing slash,
    ;; empty string is created by split-string
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))
    path))

(defun mode-line-current-directory (&optional hierarchy max-length show-omitted?)
  (let* ((dirs (split-path default-directory))
         (ln (length dirs))
         (head "") (output ""))
    (if (null hierarchy)
        (setq hierarchy ln)
      (if (> hierarchy ln)
          (setq hierarchy ln)
        (when show-omitted?
          (setq head "../"))))
    (let (dir)
      (while (> hierarchy 0)
        (setq dir (pop dirs))
        (when max-length
          (setq dir (shorten-string dir max-length)))
        (setq output (concat dir "/" output)
              hierarchy (1- hierarchy))))
    (concat head output)))

(provide 'modeline-config)
