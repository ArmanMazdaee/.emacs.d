;;Quickly switch windows in Emacs
(require 'require-package)

(require-package 'ace-window)
(global-set-key (kbd "C-x o") 'ace-window)

;;Set the sequence of leading characters be in home row
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;;This is useful to change the action midway and execute other action other than the jump default
;;(setq aw-dispatch-always t)

(provide 'ace-window-recipe)
