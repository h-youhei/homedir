(require 'package)
(require 'cl-lib)

(defun package-auto-install ()
  "Install `package-selected-packages', if it hasn't installed"
  (let ((not-installed (cl-remove-if #'package-installed-p
                                     package-selected-packages)))
    (when not-installed
      (package-refresh-contents)
      (mapc #'package-install not-installed))))

;;;###autoload
(defun package-update ()
  (save-window-excursion
    (package-list-packages)
    (package-menu-mark-upgrades)
    (package-menu-execute t)))

(provide 'package-plus)
