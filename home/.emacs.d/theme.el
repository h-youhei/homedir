(set-face-attribute 'match nil
	:foreground nil
	:distant-foreground "black"
	:background "lightgray")

(set-face-attribute 'menu nil
	:foreground "white"
	:background "dimgray")

(set-face-attribute 'isearch nil
	:foreground nil
	:distant-foreground "black"
	:background "white"
	:weight 'bold)

(set-face-attribute 'highlight nil
	:foreground nil
	:distant-foreground "white"
	:background "dimgray")

(set-face-attribute 'lazy-highlight nil
	:foreground nil
	:inherit 'highlight)

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
(set-face-attribute 'ivy-minibuffer-match-face-3 nil
	:foreground nil
	:background nil
	:inherit 'ivy-minibuffer-match-face-2)
(set-face-attribute 'ivy-minibuffer-match-face-4 nil
	:foreground nil
	:background nil
	:inherit 'ivy-minibuffer-match-face-2)

(set-face-attribute 'company-tooltip nil
	:foreground nil
	:background nil
	:inherit 'menu)

(set-face-attribute 'company-tooltip-selection nil
	:foreground nil
	:background nil
	:inherit 'match)

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
