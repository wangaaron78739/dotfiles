;;; $DOOMDIR/+bindings.el -*- lexical-binding: t; -*-

(defun browse-file-directory ()
  "Open the current file's directory however the OS would."
  (interactive)
  (if default-directory
      (browse-url-of-file (expand-file-name default-directory))
    (error "No `default-directory' to open")))

(when (eq system-type 'gnu/linux)
  (setq x-super-keysym 'super)
        (map!
        :leader
        :desc "Open current file directory"
        "o o" #'browse-file-directory))

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'super))

(map!
 :gnvime "s-/"   #'evilnc-comment-or-uncomment-lines
 :gnvime "M-y"   #'counsel-yank-pop
 :gnvime "s-v"   #'clipboard-yank
 :gnvime "s-V"   #'counsel-yank-pop
 :gnvime "s-x"   #'clipboard-kill-region
 :gnvime "s-c"   #'clipboard-kill-ring-save
 :gnvime "s-z"   #'undo-tree-undo
 :gnvime "s-Z"   #'undo-tree-redo
)
