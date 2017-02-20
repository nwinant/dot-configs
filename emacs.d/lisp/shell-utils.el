;;;;;;;;;;;;;;;;;;;;;
;; SHELL-MODE
;;;;;;;;;;;;;;;;;;;;;

(provide 'shell-utils)

;; esc-return: re-sync dirs between shell & emacs
;; * http://stackoverflow.com/questions/163591/bash-autocompletion-in-emacs-shell-mode
;;(global-set-key "\M-\r" 'shell-resync-dirs)
(defun run-new-shell ()
  (interactive)
  (shell (generate-new-buffer "*shell*")))

;; https://www.emacswiki.org/emacs/ShellMode#toc3
(defun alt-shell-dwim (arg)
  "Run an inferior shell like `shell'. If an inferior shell as its I/O
 through the current buffer, then pop the next buffer in `buffer-list'
 whose name is generated from the string \"*shell*\". When called with
 an argument, start a new inferior shell whose I/O will go to a buffer
 named after the string \"*shell*\" using `generate-new-buffer-name'."
  (interactive "P")
  (let* ((shell-buffer-list
	  (let (blist)
	    (dolist (buff (buffer-list) blist)
	      (when (string-match "^\\*shell\\*" (buffer-name buff))
		(setq blist (cons buff blist))))))
	 (name (if arg
		   (generate-new-buffer-name "*shell*")
		 (car shell-buffer-list))))
    (shell name)))

;; C-shift-F1: launch new shell
(global-set-key (kbd "C-<f1>") 'run-new-shell)

;; C-shift-F3: cycle through shells
(global-set-key (kbd "C-<f3>") 'alt-shell-dwim)

;; Monitor shell process, killing buffer on exit
(defun shell-process-sentinel (process state)
  (message "%s" state)
  (if (or
       (string-match "exited abnormally with code.*" state)
       (string-match "finished" state))
      (kill-buffer (current-buffer))))

;; Shell-mode init
(defun run-shell-init ()
  (run-at-time "1 sec" nil #'shell-resync-dirs)
  (set-process-sentinel (get-buffer-process (current-buffer))
			'shell-process-sentinel))



;;;;;;;;;;;;;;;;;;;;;
;; Shell commands
;;;;;;;;;;;;;;;;;;;;;

(defun meld-file-path (path)
  (interactive)
  (start-process "meld-file-path" nil "/usr/bin/meld" path))

(defun meld-current-dir ()
  (interactive)
  (meld-file-path "."))

(defun diff-current-dir-visual ()
  (interactive)
  (meld-current-dir))

(defun show-cheatsheet ()
  (interactive)
  (find-file "~/scripts/conf/emacs-cheatsheet.txt"))


