;;; $DOOMDIR/+bindings.el -*- lexical-binding: t; -*-

(when (eq system-type 'gnu/linux)
  (setq x-super-keysym 'super))

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'super))

(map!
 :gnvime "M-/"   #'evilnc-comment-or-uncomment-lines
 :gnvime "s-v"   #'clipboard-yank
 :gnvime "s-x"   #'clipboard-kill-region
 :gnvime "s-c"   #'clipboard-kill-ring-save
 :gnvime "s-z"   #'undo-tree-undo
 :gnvime "s-Z"   #'undo-tree-redo
)
