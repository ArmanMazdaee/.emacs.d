;; A template system for Emacs
(require 'require-package)

(require-package 'yasnippet)

(eval-after-load "yasnippet"
  (lambda ()
    (yas-reload-all)))

(provide 'yasnippet-recipe)
