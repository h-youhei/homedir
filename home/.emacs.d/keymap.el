(defvaralias 'nmap 'evil-normal-state-map)
(defvaralias 'imap 'evil-insert-state-map)
(defvaralias 'vmap 'evil-visual-state-map)
(defvaralias 'mmap 'evil-motion-state-map)
(defvaralias 'omap 'evil-operator-state-map)
(defvaralias 'emap 'evil-emacs-state-map)
(defvaralias 'wmap 'evil-window-map)
(defvaralias 'smap 'evil-ex-search-keymap)
(defvaralias 'rmap 'evil-read-key-map)

;; to use as prefix key
(define-key mmap (kbd "SPC") nil)

(global-set-key [escape] #'keyboard-quit)
(define-key nmap [escape] #'keyboard-quit)

(global-set-key (kbd "C-u") #'ivy-resume)

;; window
(global-set-key (kbd "M-t") #'open-terminal)
(global-set-key (kbd "M-<return>") #'make-frame-command)
(define-key mmap (kbd "M-SPC") #'evil-window-next)

;; buffer
(define-key mmap (kbd "C-b") nil)
(global-set-key (kbd "C-b") #'switch-to-buffer)
(global-set-key (kbd "C-S-b") #'buffer-menu)
(define-key mmap "q" #'evil-delete-buffer)
(define-key nmap "q" #'evil-delete-buffer)
(define-key nmap "Q" #'evil-save-and-delete-buffer)
(define-key nmap "+" #'save-buffer)

;; filer
(define-key mmap (kbd "C-f") nil)
(global-set-key (kbd "C-f") #'find-file)
(global-set-key (kbd "C-S-f") #'(lambda () (interactive) (dired "./")))
(define-key nmap (kbd "C-r") nil)
(global-set-key (kbd "C-r") #'ivy-recentf)

;; start insert
(define-key nmap (kbd "SPC i") #'evil-insert-word)
(define-key nmap (kbd "SPC I") #'evil-insert-WORD)
(define-key nmap (kbd "SPC a") #'evil-append-word)
(define-key nmap (kbd "SPC A") #'evil-append-WORD)
(define-key nmap (kbd "SPC o") #'evil-insert-resume)

;; start visual
(define-key mmap (kbd "SPC v") #'evil-visual-restore)
(define-key mmap (kbd "SPC g") #'mark-whole-buffer)
(advice-add #'mark-whole-buffer :before #'evil-set-jump)

;; operator
(define-key nmap "C" #'evil-change-whole-line)
(define-key nmap (kbd "SPC c") #'evil-change-whole-word)
(define-key nmap (kbd "SPC C") #'evil-change-whole-WORD)
(define-key nmap "D" #'evil-delete-whole-line)
(define-key nmap (kbd "SPC d") #'evil-delete-whole-word)
(define-key nmap (kbd "SPC D") #'evil-delete-whole-WORD)
(define-key nmap (kbd "SPC y") #'evil-yank-whole-word)
(define-key nmap (kbd "SPC Y") #'evil-yank-whole-WORD)
;(define-key nmap (kbd "SPC u") #'evil-upcase-whole-word)
;(define-key nmap (kbd "SPC U") #'evil-downcase-whole-word)
(define-key vmap "u" #'evil-upcase)
(define-key vmap "U" #'evil-downcase)
(define-key vmap "+" #'evil-rectangle-number-lines)

;; comment
(define-key nmap ";" #'comment-line)
(define-key vmap ";" #'comment-or-uncomment-region)

;; joint
(define-key nmap "j" #'evil-join)
(define-key nmap "J" #'evil-split)

;; delete char
(define-key omap (kbd "<delete>") #'evil-forward-char)
(define-key omap (kbd "<backspace>") #'evil-backward-char)
(define-key nmap (kbd "S-<delete>") #'evil-substitute)
(define-key nmap (kbd "<backspace>") #'evil-delete-backward-char)
(define-key vmap (kbd "<backspace>") #'evil-delete-backward-char)
(define-key nmap (kbd "S-<backspace>") #'evil-backward-substitute)

;; undo
(define-key nmap "U" #'undo-tree-redo)
(define-key nmap (kbd "SPC u") #'undo-tree-visualize)

;; mark
(define-key nmap "@" #'evil-set-marker)
(define-key mmap "m" #'evil-goto-mark)
(define-key mmap "M" #'evil-goto-mark-line)

;; key macro
(define-key nmap "&" #'evil-record-macro)
(define-key nmap "k" #'evil-execute-macro)
(define-key nmap "K" #'evil-repeat-macro)

;;command
(define-key nmap "!" #'shell-command)
(define-key vmap "!" #'evil-shell-command)
(define-key nmap ":" #'eval-expression)
(define-key nmap (kbd "SPC :") #'ielm)

;; history
(define-key mmap "h" #'evil-jump-backward)
(define-key mmap "H" #'evil-jump-forward)
(define-key nmap "l" #'goto-last-change)
(define-key nmap "L" #'goto-last-change-reverse)

;; search
(define-key mmap "#" #'evil-search-word-forward)
(define-key mmap "*" #'evil-search-word-backward)

;; find
(define-key mmap "," #'evil-repeat-find-char)
(define-key mmap "<" #'evil-repeat-find-char-reverse)

;; substitute
(define-key nmap "-" #'evil-ex-interactive-substitute)
(define-key vmap "-" #'evil-ex-interactive-substitute)
(define-key nmap "_" #'(lambda () (interactive) (evil-ex "%s/")))
(define-key nmap ">" #'evil-ex-repeat-substitute)

;; motion
(define-key mmap "][" #'evil-forward-section-begin)
(define-key mmap "]]" #'evil-forward-section-end)

(define-key mmap (kbd "SPC e") #'evil-backward-word-end)
(define-key mmap (kbd "SPC E") #'evil-backward-WORD-end)

(define-key nmap "'" #'evil-use-clipboard)
(define-key mmap [up] #'evil-smart-previous-line)
(define-key imap [up] #'evil-previous-visual-line)
(define-key mmap [down] #'evil-smart-next-line)
(define-key imap [down] #'evil-next-visual-line)

(define-key mmap [home] #'evil-smart-beginning-of-line)
(define-key imap [home] #'evil-smart-beginning-of-line)
(define-key mmap [end] #'evil-smart-end-of-line)
(define-key imap [end] #'evil-smart-end-of-line)

;; scroll
(define-key mmap [prior] #'evil-scroll-page-up)
(define-key imap [prior] #'evil-scroll-page-up)
(define-key mmap [next] #'evil-scroll-page-down)
(define-key imap [next] #'evil-scroll-page-down)
(define-key mmap (kbd "SPC <prior>") #'evil-scroll-line-to-bottom)
(define-key mmap (kbd "SPC <next>") #'evil-scroll-line-to-top)

;; jump
(define-key mmap "g" #'evil-goto-first-line)
;; get rid of predefined keys
(define-key nmap "g" #'evil-goto-first-line)
(define-key mmap "G" #'evil-smart-goto-last-line)
(define-key mmap (kbd "S-SPC") #'evil-middle-of-visual-line)
(define-key mmap (kbd "SPC SPC") #'evil-window-middle)
(define-key mmap (kbd "SPC <up>") #'evil-window-top)
(define-key mmap (kbd "SPC <down>") #'evil-window-bottom)
(define-key mmap (kbd "SPC <left>") #'evil-beginning-of-visual-line)
(define-key mmap (kbd "SPC <right>") #'evil-end-of-visual-line)

;; indent
(define-key nmap [tab] #'evil-shift-right-line)
(define-key vmap [tab] #'evil-shift-right)
(define-key nmap [backtab] #'evil-shift-left-line)
(define-key vmap [backtab] #'evil-shift-left)
(define-key nmap (kbd "SPC <tab>") #'evil-align-left)
(define-key vmap (kbd "SPC <tab>") #'evil-align-left)
(define-key nmap (kbd "SPC <backtab>") #'evil-align-right)
(define-key vmap (kbd "SPC <backtab>") #'evil-align-right)
(define-key nmap "=" #'evil-indent-line)
(define-key nmap (kbd "SPC =") #'evil-align-center)
(define-key vmap (kbd "SPC =") #'evil-align-center)

;; zap tag
;; (define-key nmap "z" #')
;; (define-key vmap "z" #')
;; (define-key mmap "z" #')
;; (define-key nmap "Z" #')
;; (define-key vmap "Z" #')
;; (define-key mmap "Z" #')

;; surround
(define-key omap "s" #'evil-surround-edit)
(define-key nmap "s" #'evil-surround-region)
(define-key vmap "s" #'evil-surround-region)
(define-key nmap "S" #'evil-surround-whole-line)
;; (define-key vmap "D" #'evil-surround-delete-region)
;; (define-key vmap "C" #'evil-surround-change-region)
(define-key nmap (kbd "SPC s") #'evil-surround-whole-word)
(define-key nmap (kbd "SPC S") #'evil-surround-whole-WORD)

;; exchange
(define-key nmap "x" #'evil-exchange)
(define-key vmap "x" #'evil-exchange)
(define-key nmap "X" #'evil-exchange-whole-line)
(define-key nmap (kbd "SPC x") #'evil-exchange-whole-word)
(define-key nmap (kbd "SPC X") #'evil-exchange-whole-WORD)

;; flip boolean
;; (define-key nmap "`" #')

;; insert mode
;; (define-key imap [tab] #'tab-to-tab-stop)
(define-key imap [return] #'newline-and-indent)
(define-key imap (kbd "S-<return>") #'newline)
(define-key imap (kbd "C-b") #'evil-backward-word-begin)
(define-key imap (kbd "C-d") #'evil-delete-backward-word)
(define-key imap (kbd "C-w") #'evil-forward-word-begin)
;; (define-key imap (kbd "C-u") #'evil-backward-kill-line)
(define-key imap (kbd "C-j") #'evil-join)
;; (define-key imap (kbd "C-y") #'evil-copy-previous-line)
;; (define-key imap (kbd "C-p") #'evil-copy-next-line)
;;(define-key imap (kbd "C-{"))
;;(define-key imap (kbd "C-}"))

(let ((map company-active-map))
  (define-key map [escape] #'(lambda () (interactive) (company-abort) (evil-normal-state)))
  (define-key map [return] nil)
  (define-key map [tab] #'company-complete-selection)
  (define-key map (kbd "C-n") #'company-select-next)
  (define-key map (kbd "C-p") #'company-select-previous)
  (define-key map [up] nil)
  (define-key map [down] nil)
  )

;; to integrate evil-maybe-remove-spaces
(add-hook 'company-completion-started-hook
          #'(lambda (_) (advice-add #'newline-and-indent :before #'company-abort)))
(add-hook 'company-completion-cancelled-hook
          #'(lambda (_) (advice-remove #'newline-and-indent #'company-abort)))

(let ((map undo-tree-visualizer-mode-map))
  (define-key map [escape] #'undo-tree-visualizer-quit)
  )

(let ((map minibuffer-local-map))
  (define-key map [escape] 'minibuffer-keyboard-quit)
  )

(let ((map ivy-minibuffer-map))
  (define-key map [escape] 'minibuffer-keyboard-quit)
  (define-key map (kbd "S-<return>") 'ivy-immediate-done)
  )

(let ((map projectile-command-map))
  (define-key map "t" #'projectile-open-terminal)
  )

;; snippet
;; define-key map (kbd "C-<tab>") expand-or-jump
