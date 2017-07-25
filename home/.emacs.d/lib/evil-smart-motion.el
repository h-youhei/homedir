(require 'evil)

;;;###autoload
(evil-define-motion evil-smart-previous-line (count)
  "Move the cursor a screen line up.
If COUNT is given, move COUNT logical lines up."
  :type line
  (if count
      (evil-previous-line count)
    (evil-previous-visual-line nil)))

;;;###autoload
(evil-define-motion evil-smart-next-line (count)
  "Move the cursor a screen line down.
If COUNT is given, move COUNT logical lines down."
  :type line
  (if count
      (evil-next-line count)
    (evil-next-visual-line nil)))

;;;###autoload
(evil-define-motion evil-smart-beginning-of-line (count)
  "Move the cursor to the first non blank. If already there, to the beginning of line.
If COUNT is given, go to column COUNT on the current line."
  :type exclusive
  (if count
                                        ;because beggining of line is 0
      (evil-goto-column (1- count))
    (let ((oldpos (point)))
      (evil-first-non-blank)
      (when (= oldpos (point))
        (evil-beginning-of-line)))))

;;;###autoload
(evil-define-motion evil-smart-end-of-line (count)
  "Move the cursor to the end of line. If already there, to the last non blank.
If COUNT is given, go to COUNT column from end of the line on the current line."
  :type inclusive
  (if count
      (let ((end (- (line-end-position) (line-beginning-position))))
        (evil-goto-column (max 0 (- end count))))
    (let ((oldpos (point)))
      (evil-end-of-line-fix nil)
      (when (= oldpos (point))
        (evil-last-non-blank nil)))))

;; handle insert mode
(evil-define-motion evil-end-of-line-fix (count)
  (move-end-of-line count)
  (when evil-track-eol
    (setq temporary-goal-column most-positive-fixnum
          this-command #'next-line))
  (unless (or (evil-visual-state-p)
              (evil-insert-state-p))
    (evil-adjust-cursor t)
    (when (eolp)
      (setq evil-this-type 'exclusive))))

;;;###autoload
(evil-define-motion evil-smart-goto-last-line (count)
  "Go to the first non-blank character of the last line.
If COUNT is given, go to COUNT line from the last line."
  :jump t
  :type line
  (with-no-warnings (end-of-buffer))
  (when (looking-at-p "^$")
    (evil-previous-line))
  (when count (evil-previous-line (1- count)))
  (evil-first-non-blank))

(provide 'evil-smart-motion)
