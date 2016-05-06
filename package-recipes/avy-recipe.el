;;Jump to things in Emacs tree-style
(require 'require-package)
(require-package 'avy)

;;Add a custom function so for avy so I can bind all usefull function
;;to just one key
(require 'cl)
(defun my/avy-jump (arg)
  "custom jump for avy that acts like this:
        my/avy-jump -> avy-goto-word-1
    C-u my/avy-jump -> avy-goto-char
C-u C-u my/avy-jump -> avy-goto-line"
  (interactive "p")
  (let ((current-prefix-arg 1)
        (f (cl-case arg
              (4 'avy-goto-char)
              (16 'avy-goto-line)
              (t 'avy-goto-word-1))))
    (call-interactively f)))

(global-set-key (kbd "C-'") 'my/avy-jump)

(provide 'avy-recipe)
