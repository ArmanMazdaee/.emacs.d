;; A template system for Emacs
(require 'require-package)

(require-package 'yasnippet)

(add-hook 'after-init-hook
          (lambda ()
            (yas-global-mode 1)))

(provide 'yasnippet-recipe)
