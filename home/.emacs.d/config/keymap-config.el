(require 'evil)
(require 'ivy)
(require 'projectile)
(require 'autoload-init)
;; (defvaralias 'wmap 'evil-window-map)
;; (defvaralias 'smap 'evil-ex-search-keymap)
;; (defvaralias 'rmap 'evil-read-key-map)

(let ((nmap evil-normal-state-map)
      (imap evil-insert-state-map)
      (vmap evil-visual-state-map)
      (mmap evil-motion-state-map)
      (omap evil-operator-state-map)
      (emap evil-emacs-state-map))
  ;; to use as prefix key
  (define-key mmap (kbd "SPC") nil)
  (global-set-key (kbd "M-e") nil)
  (global-set-key (kbd "M-a") nil)

  (global-set-key [escape] #'evil-escape)
  (define-key nmap [escape] #'evil-escape)

  ;; window
  (global-set-key (kbd "C-t") #'open-terminal)
  (global-set-key (kbd "M-<return>") #'make-frame-command)
  (global-set-key (kbd "M-SPC") #'smart-switch-window)

  ;; buffer
  (define-key mmap (kbd "C-b") nil)
  (global-set-key (kbd "C-b") #'ivy-plus-switch-buffer)
  (global-set-key (kbd "C-S-b") #'buffer-menu)
  (define-key mmap "q" #'evil-delete-buffer)
  (define-key nmap "q" #'evil-delete-buffer)
  (define-key nmap "Q" #'evil-save-and-delete-buffer)
  (define-key nmap "+" #'save-buffer)

  ;; filer
  (define-key mmap (kbd "C-f") nil)
  (global-set-key (kbd "C-f") #'ivy-plus-find-file)
  (global-set-key (kbd "C-S-f") (lambda () (interactive) (dired "./")))
  (define-key nmap (kbd "C-r") nil)
  (global-set-key (kbd "C-r") #'counsel-recentf)
  (global-set-key (kbd "C-m") #'ivy-plus-bookmark)
  (global-set-key (kbd "C-S-m") #'bookmark-bmenu-list)
  (define-key mmap (kbd "C-m") nil)
  (define-key mmap [return] #'evil-ret)

  (declare-function dired-find-file 'dired)
  (with-eval-after-load 'dired
    (let ((map dired-mode-map))
      (define-key map [return] #'dired-find-file)
      (define-key map (kbd "C-m") nil)))

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
  (define-key nmap (kbd "SPC `") #'evil-upcase-whole-word)
  (define-key nmap (kbd "SPC ~") #'evil-downcase-whole-word)
  (define-key vmap "`" #'evil-upcase)
  (define-key vmap "~" #'evil-downcase)
  (define-key vmap "+" #'evil-rectangle-number-lines)

  ;; comment
  (define-key nmap ";" #'comment-line)
  (define-key vmap ";" #'comment-or-uncomment-region)

  ;; joint
  (define-key nmap "j" #'evil-join-comment)
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
  (define-key nmap "_" (lambda () (interactive) (evil-ex "%s/")))
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
  (define-key nmap (kbd "SPC s") #'evil-surround-whole-word)
  (define-key nmap (kbd "SPC S") #'evil-surround-whole-WORD)

  ;; exchange
  (define-key nmap "x" #'evil-exchange)
  (define-key vmap "x" #'evil-exchange)
  (define-key nmap "X" #'evil-exchange-whole-line)
  (define-key nmap (kbd "SPC x") #'evil-exchange-whole-word)
  (define-key nmap (kbd "SPC X") #'evil-exchange-whole-WORD)

  ;; flip boolean
  (define-key nmap "`" #'bool-flip-do-flip)

  ;; insert mode
  (define-key imap [tab] #'indent-for-tab-command)
  (define-key imap [return] #'evil-ret-and-indent)
  (define-key imap (kbd "S-<return>") #'newline)
  (define-key imap (kbd "C-b") #'evil-backward-word-begin)
  (define-key imap (kbd "C-d") #'evil-delete-backward-word)
  (define-key imap (kbd "C-w") #'evil-forward-word-begin)
  (define-key imap (kbd "C-u") #'evil-backward-delete-line)
  (define-key imap (kbd "C-j") #'evil-join)
  ;; yank
  (define-key imap (kbd "C-y") #'evil-copy-word-from-above)
  ;; float
  (define-key imap (kbd "C-f") #'evil-copy-word-from-below)
  (define-key imap (kbd "C-s") #'counsel-company)
  ;;(define-key imap (kbd "C-{"))
  ;;(define-key imap (kbd "C-}"))

  ;; ivy
  (let ((map minibuffer-local-map))
    (define-key map [escape] #'minibuffer-keyboard-quit)
    )

  (global-set-key (kbd "C-u") #'ivy-resume)
  (global-set-key (kbd "C-s") #'swiper)
  (global-set-key (kbd "C-S-s") #'ivy-plus-ag-with-find-directory)
  (global-set-key (kbd "C-i") #'counsel-imenu)
  (define-key mmap (kbd "C-y") nil)
  (global-set-key (kbd "C-y") #'counsel-yank-pop)

  (let ((map ivy-minibuffer-map))
    (define-key map [escape] #'minibuffer-keyboard-quit)
    (define-key map [return] #'ivy-done)
    (define-key map (kbd "S-<return>") #'ivy-immediate-done)
    (define-key map (kbd "C-<return>") #'ivy-call)
    (define-key map [backtab] #'ivy-dispatching-call)
    (define-key map (kbd "C-<tab>") #'ivy-read-action)
    (define-key map (kbd "C-f") #'ivy-toggle-fuzzy)
    (define-key map (kbd "C-d") #'ivy-backward-kill-word)
    (define-key map (kbd "C-i") #'ivy-insert-current)
    (define-key map (kbd "C-u") #'ivy-kill-line)
    (define-key map (kbd "C-s") #'ivy-reverse-i-search)
    )
  (ivy-set-actions
   t
   '(("i" (lambda (x) (insert (if (stringp x) x (car x)))) "insert")
     ("y" (lambda (x) (kill-new (if (stringp x) x (car x)))) "copy")))


  (with-eval-after-load 'company
    (declare-function company-complete-selection 'company)
    (declare-function company-select-next 'company)
    (declare-function company-select-previous 'company)
    (let ((map company-active-map))
      (define-key map [return] nil)
      (define-key map [tab] #'company-complete-selection)
      (define-key map (kbd "C-n") #'company-select-next)
      (define-key map (kbd "C-p") #'company-select-previous)
      (define-key map [up] nil)
      (define-key map [down] nil)))


  (with-eval-after-load 'yassnippet
    (declare-function yas-expand 'yasnippet)
    (declare-function yas-insert-snippet 'yasnippet)
    (declare-function yas-visit-snippet-file 'yasnippet)
    (declare-function yas-new-snippet 'yasnippet)
    (declare-function yas-next-field-or-maybe-expand 'yasnippet)
    (declare-function yas-prev-field 'yasnippet)
    (declare-function yas-skip-and-clear-or-delete-char 'yasnippet)
    (declare-function yas-tryout-snippet 'yasnippet)

    (define-key imap (kbd "C-e") #'load-yas-expand)
    (define-key imap (kbd "C-S-e") #'load-yas-insert-snippet)
    (global-set-key (kbd "M-e s") #'load-yas-visit-snippet-file)
    (global-set-key (kbd "M-a s") #'load-yas-new-snippet)

    (let ((map yas-minor-mode-map))
      (evil-define-key 'insert map (kbd "C-e") #'yas-expand)
      (evil-define-key 'insert map (kbd "C-S-e") #'yas-insert-snippet)
      (define-key map (kbd "M-e s") #'yas-visit-snippet-file)
      (define-key map (kbd "M-a s") #'yas-new-snippet)
      )
    (let ((map yas-keymap))
      (define-key map (kbd "C-e") #'yas-next-field-or-maybe-expand)
      (define-key map (kbd "C-S-e") #'yas-prev-field)
      (define-key map (kbd "<delete>")
        #'yas-skip-and-clear-or-delete-char)
      )
    (let ((map snippet-mode-map))
      (define-key map (kbd "M-r") #'yas-tryout-snippet)
      )
    )

  (let ((map undo-tree-visualizer-mode-map))
    (define-key map [return] #'undo-tree-visualizer-quit)
    (define-key map [escape] #'undo-tree-visualizer-abort)
    )

  (setq projectile-keymap-prefix nil)
  (define-key nmap (kbd "C-p") nil)
  (global-set-key (kbd "C-p") #'projectile-command-map)
  (let ((map projectile-command-map))
    (define-key map [escape] #'keyboard-quit)
    (define-key map "t" #'projectile-open-terminal)
    (define-key map "s" #'counsel-git-grep)
    )

  (global-set-key (kbd "C-g") #'magit-status)

  (declare-function with-editor-finish 'with-editor)
  (declare-function with-editor-cansel 'with-editor)
  (with-eval-after-load 'with-editor
    (let ((map with-editor-mode-map))
      (evil-define-key 'normal map "q!" #'with-editor-cancel)
      (evil-define-key 'normal map "Q" #'with-editor-finish)
    ))

  (with-eval-after-load 'git-commit
    (let ((map git-commit-mode-map))
      (evil-define-key 'normal map
        "q!" (lambda () (interactive)
              (with-editor-cancel nil) (magit-mode-bury-buffer)))
      (evil-define-key 'normal map
        "Q" (lambda () (interactive)
              (with-editor-finish nil) (magit-mode-bury-buffer)))
      ))

  (with-eval-after-load 'magit-popup
    (define-key magit-popup-mode-map [escape] 'magit-popup-quit))
  (with-eval-after-load 'magit
    (evil-define-key 'normal magit-diff-mode-map
      "q" #'magit-mode-bury-buffer))

  )

(provide 'keymap-config)
