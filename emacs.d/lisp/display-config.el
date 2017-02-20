;;;;;;;;;;;;;;;;;;;;;
;; DISPLAY
;;;;;;;;;;;;;;;;;;;;;

;; turn on visual bell
(setq visible-bell t)

;; get rid of the toolbar on top of the window
;; (tool-bar-mode 1)

;; Use "y or n" answers instead of full words "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Frame titlebar; always contain the bufferâs name regardless of the # of existing frames. See:
;; * https://www.gnu.org/software/emacs/manual/html_node/efaq/Displaying-the-current-file-name-in-the-titlebar.html
;; * http://emacs-fu.blogspot.com/2011/01/setting-frame-title.html
(setq frame-title-format '("%b (" invocation-name "@" system-name ")"))

;; Display current column #. See:
;; * https://www.gnu.org/software/emacs/manual/html_node/efaq/Displaying-the-current-line-or-column.html
(setq column-number-mode t)

;;(add-to-list 'default-frame-alist '(width . 120))
;;(add-to-list 'default-frame-alist '(height . 64))
(add-to-list 'default-frame-alist '(width . 108))
(add-to-list 'default-frame-alist '(height . 62))

(set-frame-parameter (selected-frame) 'alpha '(98 98))
(add-to-list 'default-frame-alist '(alpha 98 98))

;(load-theme 'manoj-dark t)
;(set-face-attribute 'default nil :background "#2e3436") ;; background of tango-dark

;(load-theme 'tango-dark t)
;(set-face-attribute 'default nil :background "dim gray")
;(set-face-attribute 'default nil :background "gray25")
;(set-face-attribute 'default nil :background "gray19")
;(set-face-attribute 'default nil :background "gray16")
;(set-face-attribute 'default nil :background "#1e2426")
;;(set-face-attribute 'default nil :background "#000000") ;; background of tango-dark

;(face-attribute 'default :background)



