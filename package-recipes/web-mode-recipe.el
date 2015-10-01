;;Web mode for editing html template files
(require 'require-package)

(require-package 'web-mode)

(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;;emmet's support for emacs
(require-package 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)

;;autocomplete support
(require 'company-mode-recipe)
(require-package 'company-web)
(add-hook 'web-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends) '(company-web-html))
            (company-mode t)))

(provide 'web-mode-recipe)
