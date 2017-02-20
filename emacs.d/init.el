;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Misc emacs customizations
;;
;; This file should be loaded automatically. If not, add this to .emacs (or whatever):
;;
;;   (load-file "/home/nwinant/.emacs.d/init.el")
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;/usr/share/emacs/24.5/etc/themes/tango-dark-theme.el

;;;;;;;;;;;;;;;;;;;;;
;; Custom configs
;;;;;;;;;;;;;;;;;;;;;

(load-theme 'manoj-dark t)
(set-face-attribute 'default nil :background "#2e3436") ;; background of tango-dark

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(load "autosaving-and-backups")
(load "display-config")
(load "shell-utils")

;(require 'shell-utils)
;(require 'load-directory)


;; Adding MELPA-STABLE for markdown-mode:
;; * http://jblevins.org/projects/markdown-mode/
;; * https://www.emacswiki.org/emacs/MarkdownMode
(require 'package)
;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;(add-to-list 'package-archives
;             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; Evil...
(require 'evil)
(evil-mode 1)



;;;;;;;;;;;;;;;;;;;;;
;; Custom BINDINGS
;;;;;;;;;;;;;;;;;;;;;
;;
;; *  C-shift-F1  :  Launch new shell
;; *  C-shift-F3  :  Cycle through shells, or create one if there are none.
;; *  C-=         :  Run visual diff on current directory (default tool is meld)  
;;
(global-set-key (kbd "C-<f1>") 'run-new-shell)
(global-set-key (kbd "C-<f3>") 'alt-shell-dwim)
(add-hook 'shell-mode-hook 'run-shell-init)
(global-set-key (kbd "C-=") 'diff-current-dir-visual)
(global-set-key (kbd "C-?") 'show-cheatsheet)



;;;;;;;;;;;;;;;;;;;;;
;; SHORTCUTS
;;;;;;;;;;;;;;;;;;;;;
;;
;; *  M-RET  :  Re-sync dirs between shell & emacs via shell-resync-dirs
;; *  C-l    :  Move the screen wrt to the cursor, cycling between current line at bottom, middle, 
;;              and top of the screen



;;;;;;;;;;;;;;;;;;;;;
;; OTHER
;;;;;;;;;;;;;;;;;;;;;
;;
;; *  M-x eval-buffer  :  Reload current buffer (e.g., this config)
;; *  C-u M-x shell    :  Create new shell, prompting for name (e.g, *shell*<2>)
;; *  C-c C-c p        :  Runs Markdown on the current buffer & displays preview in browser
;; *  C-c C-c m        :  Runs Markdown on the current buffer & shows HTML output in another buffer
;; *  C-c C-h          :  List of Markdown-mode key bindings




;;;;;;;;;;;;;;;;;;;;;
;; Emacs daemon, etc.
;;;;;;;;;;;;;;;;;;;;;
;;
;; kill-emacs               emacsclient -e '(kill-emacs)'
;; client-save-kill-emacs   emacsclient -e '(client-save-kill-emacs)'



