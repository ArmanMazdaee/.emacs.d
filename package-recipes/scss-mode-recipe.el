;;scss mode recipe
(require 'require-package)

;;scss major mode
(require-package 'scss-mode)

;;Disable auto compile at save
(setq scss-compile-at-save nil)

;;Open scss file with scss mode too
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

;;add auto complete support
(add-hook 'scss-mode-hook
          (lambda ()
            (add-to-list (make-local-variable 'company-backends) 'company-css)))


(provide 'scss-mode-recipe)
