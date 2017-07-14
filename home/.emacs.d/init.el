(defvar auto-install nil)
(defconst favorite-packages '(evil
                              evil-surround
                              evil-exchange
                              linum-relative
                              ivy
                              projectile
                              company
                              haskell-mode
                              ghc
                              company-ghc
                              markdown-mode
                              ))
;; to refresh window settings, M-x desktop-remove

;; appearence
(setq inhibit-startup-screen t
      inhibit-startup-echo-area-message t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(blink-cursor-mode 0)

(set-frame-font "Dejavu Sans Mono 11" nil t)
;; https://ja.wikipedia.org/wiki/IPA%E3%83%95%E3%82%A9%E3%83%B3%E3%83%88
;; ... JIS X 0213:2004に準拠している。
(set-fontset-font t 'japanese-jisx0213.2004-1 (font-spec :family "IPA Gothic"))

(setq whitespace-style '(face
                         trailing
                         tabs
                         spaces
                         space-mark
                         tab-mark
                         ))
(setq whitespace-display-mappings '((tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t]))
      whitespace-space-regexp "\\(\u3000+\\)")
(global-whitespace-mode 1)
(let ((default-bg-color (face-attribute 'default :background)))
  (set-face-attribute 'whitespace-trailing nil
                      :background default-bg-color
                      :foreground "Red"
                      :underline t)
  (set-face-attribute 'whitespace-tab nil
                      :background default-bg-color
                      :foreground "LightSkyBlue"
                      :underline t)
  (set-face-attribute 'whitespace-space nil
                      :background "LightSkyBlue"))

;; history
(defconst temp-emacs-dir (expand-file-name (format "emacs%d" (user-uid))
                                           temporary-file-directory))
(setq backup-directory-alist `((".*" . ,(concat temp-emacs-dir "/backup")))
      ;; auto-save/'s trailing slash is important
      auto-save-file-name-transforms `((".*"
                                        ,(expand-file-name "auto-save/"
                                                           user-emacs-directory)
                                        t))
      auto-save-timeout 60
      auto-save-interval 50)

(setq desktop-load-locked-desktop nil
      desktop-save 'if-exists ;to not save if locked
      desktop-restore-eager 5
      desktop-lazy-idle-delay 2
      desktop-locals-to-save '()
      )
(desktop-save-mode 1)

;; misc
(show-paren-mode 1)
(save-place-mode 1)
(setq-default tab-width 4)
(setq backward-delete-char-untabify-method 'hungry
      electric-indent-chars (remq ?\n electric-indent-chars)
 )
(setq comment-style 'plain)
(fset 'yes-or-no-p 'y-or-n-p)
(setq use-dialog-box nil)

;; packages
;; packape manager
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;;auto install
(when auto-install
  (require 'cl-lib)
  (let ((not-installed (cl-remove-if #'package-installed-p favorite-packages)))
    (when not-installed
      (package-refresh-contents)
      (mapc #'package-install not-installed))))

;;evil
(require 'evil)
(setq evil-move-cursor-back nil ;when leave insert. t is vim equivalent
      evil-cross-lines t ;at line egde
      evil-want-C-i-jump nil
      evil-want-C-d-scroll nil
      evil-disable-insert-state-bindings t
      evil-echo-state nil
      evil-text-object-change-visual-type nil
      evil-ex-visual-char-range t
      evil-search-module "evil-search"
      evil-magic "very-nomagic"
      evil-ex-search-vim-style-regexp t
      evil-ex-substitute-case "sensitive"
      evil-ex-substitute-global t
      )
(setq-default evil-shift-width tab-width)
;;(setq-global evil-surround-pairs-alist)

(evil-declare-not-repeat #'evil-yank-line)

(setq undo-tree-auto-save-history t
      undo-tree-history-directory-alist `((".*" . ,(concat temp-emacs-dir "/undo")))
      ;;undo-tree-visualizer-diff t
      )


;; real number for current line
;; relative number for the other line
(setq linum-relative-current-symbol "")
(require 'linum-relative)
(global-linum-mode 1)
(linum-relative-on)

(ivy-mode 1)

;; projectile
(setq projectile-completion-system 'ivy
      projectile-keymap-prefix (kbd "C-p")
      )
(define-key evil-normal-state-map (kbd "C-p") nil)
(projectile-mode 1)


;; company
(setq company-idle-delay 0
      company-minimum-prefix-length 2
      company-tooltip-minimum 3
      company-tooltip-limit 5
      company-tooltip-offset-display nil
      )
(global-company-mode 1)

(add-to-list 'load-path (expand-file-name "autoload" user-emacs-directory))
(require 'init-autoload)

(defun evil-maybe-remove-spaces-fix (&optional do-remove)
  (if do-remove
      (progn
        (when (and
               evil-maybe-remove-spaces
               (save-excursion
                 (beginning-of-line)
                 (looking-at "^\\s-*$")))
          (delete-region (line-beginning-position) (line-end-position))
          (setq evil-maybe-remove-spaces nil)))
    (setq evil-maybe-remove-spaces
          (memq this-command '(evil-open-above
                               evil-open-below
                               evil-append
                               evil-append-line
                               newline
                               newline-and-indent
                               indent-and-newline
                               haskell-indentation-newline-and-indent
                               )))))

(advice-add #'evil-maybe-remove-spaces :override #'evil-maybe-remove-spaces-fix)

(evil-mode 1)

(load (expand-file-name "mode-specific" user-emacs-directory))
(load (expand-file-name "alias" user-emacs-directory))
(load (expand-file-name "keymap" user-emacs-directory))
(load (expand-file-name "modeline" user-emacs-directory))
(load (expand-file-name "theme" user-emacs-directory))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (linum-relative evil-surround))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
