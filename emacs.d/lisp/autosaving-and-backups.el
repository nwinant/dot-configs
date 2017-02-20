;;;;;;;;;;;;;;;;;;;;;;
;; BACKUPS / AUTOSAVES
;;;;;;;;;;;;;;;;;;;;;;

(setq auto-save-interval 300)  ; num chars
(setq auto-save-timeout 30)    ; num seconds idle
(setq auto-save-file-name-transforms
      `((".*" ,"~/.emacs-saves/" t)))

(setq
   backup-by-copying t
   backup-directory-alist
   '(("." . "~/.emacs-saves/"))
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)



