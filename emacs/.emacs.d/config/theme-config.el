(set-face-attribute 'match nil
                    :foreground nil
                    :distant-foreground "black"
                    :background "lightgray")

(set-face-attribute 'menu nil
                    :foreground "white"
                    :background "dimgray")

(set-face-attribute 'isearch nil
                    :foreground "black"
                    :background "white"
                    :weight 'bold)

(set-face-attribute 'highlight nil
                    :foreground nil
                    :distant-foreground "white"
                    :background "dimgray")

(set-face-attribute 'lazy-highlight nil
                    :foreground nil
                    :inherit 'highlight)

(require 'ivy)
(setq ivy-minibuffer-faces '(ivy-minibuffer-match-face-1
                             ivy-minibuffer-match-face-2))
(set-face-attribute 'ivy-current-match nil
                    :foreground nil
                    :background nil
                    :inherit 'match)
(set-face-attribute 'ivy-minibuffer-match-face-1 nil
                    :foreground nil
                    :background nil
                    :inherit 'highlight)
(set-face-attribute 'ivy-minibuffer-match-face-2 nil
                    :foreground nil
                    :background nil
                    :inherit 'isearch)

(with-eval-after-load 'swiper
  (setq swiper-faces '(swiper-match-face-1
                       swiper-match-face-2))
  (set-face-attribute 'swiper-match-face-1 nil
                      :inherit 'ivy-minibuffer-match-face-1)
  (set-face-attribute 'swiper-match-face-2 nil
                      :inherit 'ivy-minibuffer-match-face-2))


(with-eval-after-load 'company
  (set-face-attribute 'company-tooltip nil
                      :foreground nil
                      :background nil
                      :inherit 'menu)

  (set-face-attribute 'company-tooltip-selection nil
                      :foreground nil
                      :background nil
                      :inherit 'match))

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

(provide 'theme-config)
