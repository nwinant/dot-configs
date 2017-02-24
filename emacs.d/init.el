;;;   /================================[[  Emacs init.d  ]]=======================================\
 ;;| 
 ;;|    Emacs customizations (nwinant)
 ;;| 
 ;;|    This file should be loaded automatically. If not, add this to .emacs (or whatever):
 ;;| 
 ;;|      (load-file "~/.emacs.d/init.el")
 ;;| 
 ;;; \--------------------------------------------------------------------------------------------/




;;  [====[  Load custom configs  ]================================================================]

(load-theme 'manoj-dark t)
(set-face-attribute 'default nil :background "#2e3436") ;; background of tango-dark

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(load "autosaving-and-backups")
(load "display-config")
(load "shell-utils")


;;  [====[  Load packages  ]======================================================================]

(require 'package)
;; (setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
;; 			 ("marmalade" . "https://marmalade-repo.org/packages/")
;; 			 ;("melpa" . "http://melpa.org/packages/")))
;; 			 ("melpa-stable" . "https://stable.melpa.org/packages/")))
(setq package-archives '(("melpa-stable" . "https://stable.melpa.org/packages/")))

(package-initialize)
;; package-install: 
;;   evil  (requires melpa, not melpa-stable)
;;   markdown-mode

(require 'evil)
;(evil-mode 1)  ;; toggled per-buffer by C-:


;;  [====[  Misc functions  ]=====================================================================]

(defun bark-at-user (msg)
  (message "%s" (propertize
		 msg 'face '(:background "orange" :foreground "black"))))


;;  [====[  Mouse stuff  ]========================================================================]

; http://stackoverflow.com/questions/13036155/how-to-combine-emacs-primary-clipboard-copy-and-paste-behavior-on-ms-windows

;; (setq select-active-regions   nil)
;; (setq mouse-drag-copy-region  t)
;; (setq x-select-enable-primary t)
;; (setq x-select-enable-clipboard nil)

;;(setq select-active-regions nil)
;;(setq mouse-drag-copy-region t)
;;(global-set-key [mouse-2] 'mouse-yank-at-click)


;;  [====[  Custom bindings  ]====================================================================]
 ;
 ;|  *  C-shift-F1  :  Launch new shell
 ;|  *  C-shift-F3  :  Cycle through shells, or create one if there are none.
 ;|  *  C-=         :  Run visual diff on current directory (default tool is meld)
 ;|  *  C-:         :  Evil mode (toggle)
 ;;
(global-set-key (kbd "C-<f1>") 'run-new-shell)
(global-set-key (kbd "C-<f3>") 'alt-shell-dwim)
(add-hook 'shell-mode-hook 'run-shell-init)
(global-set-key (kbd "C-=") 'diff-current-dir-visual)
(global-set-key (kbd "C-?") 'show-cheatsheet)
(global-set-key (kbd "C-:") 'evil-local-mode)

;;  This drives me nuts, so let's disable it:
(global-set-key (kbd "C-x C-c")
		(lambda ()
		  (interactive)
		  (bark-at-user "NOPE! To quit: M-x kill-emacs (or :q in evil-mode)")))


;;  [====[  Shortcuts  ]==========================================================================]
 ;
 ;|  *  M-RET  :  Re-sync dirs between shell & emacs via shell-resync-dirs
 ;|  *  C-l    :  Move the screen wrt to the cursor, cycling between current line at bottom, middle, 
 ;|              and top of the screen
 ;;


;;  [====[  OTHER  ]==============================================================================]
 ;
 ;|  *  M-x eval-buffer  :  Reload current buffer (e.g., this config)
 ;|  *  C-u M-x shell    :  Create new shell, prompting for name (e.g, *shell*<2>)
 ;|  *  C-c C-c p        :  Runs Markdown on the current buffer & displays preview in browser
 ;|  *  C-c C-c m        :  Runs Markdown on the current buffer & shows HTML output in another buffer
 ;|  *  C-c C-h          :  List of Markdown-mode key bindings
 ;;


;;  [====[  Emacs daemon, etc.  ]=================================================================]
 ;
 ;|  kill-emacs               emacsclient -e '(kill-emacs)'
 ;|  client-save-kill-emacs   emacsclient -e '(client-save-kill-emacs)'
 ;;




;;;   \================================[[  ! END Emacs init.d !  ]]===============================/
