;;HTML mode recipe
(require 'require-package)

;;emmet's support for emacs
(require-package 'emmet-mode)
(add-hook 'html-mode-hook 'emmet-mode)

;;autocomplete support
(require-package 'company-web)
(add-hook 'html-mode-hook
          (lambda ()
            (add-to-list (make-local-variable 'company-backends) 'company-web-html)))

(provide 'html-mode-recipe)
