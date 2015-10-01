;;Add autocomplete support for emacs
(require 'require-package)

(require-package 'company)

(setq company-idle-delay nil)
(add-hook 'company-mode-hook
          (lambda ()
            (define-key company-mode-map (kbd "<tab>") 'company-indent-or-complete-common)))

(provide 'company-mode-recipe)
