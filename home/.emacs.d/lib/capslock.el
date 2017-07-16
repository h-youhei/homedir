(require 'emacs-plus)

(defgroup capslock nil
  "capslock state controller"
  :prefix "capslock-")

(defun capslock-toggle ()
  (shell-command-no-echo "xdotool key Caps_Lock"))

(defun get-capslock-state ()
  (let ((state (aref (shell-command-to-string
                      "xset q | grep LED | rev | cut -c1")
                     0)))
    (eq state ?1)))

(defun capslock-turn-on ()
  (unless (get-capslock-state)
    (capslock-toggle)))

(defun capslock-turn-off ()             ;
  (when (get-capslock-state)
    (capslock-toggle)))

(provide 'capslock)
