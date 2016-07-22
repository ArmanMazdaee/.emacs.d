;;Web mode for editing html template files
(require 'require-package)

;;web-mode
(require-package 'web-mode)

(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(add-hook 'web-mode-hook
          (lambda ()
            (setq web-mode-enable-auto-pairing nil)
            (setq web-mode-markup-indent-offset 2)
            (setq web-mode-css-indent-offset 2)
            (setq web-mode-code-indent-offset 2)
            (setq web-mode-attr-indent-offset 2)))

;;emmet's support for emacs
(require-package 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)

;;autocomplete support
(require-package 'company-web)
(add-hook 'web-mode-hook
          (lambda ()
            (add-to-list (make-local-variable 'company-backends) 'company-web-html)))

(provide 'web-mode-recipe)
