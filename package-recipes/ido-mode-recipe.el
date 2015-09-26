;;ido-mode
(require 'require-package)

(ido-mode t)
(ido-everywhere t)

;;Do flexible string matching
(setq ido-enable-flex-matching t)

;;Disable ido faces to see flx highlights.
(setq ido-use-faces nil)

;;flx-ido for fuzzy matching
(require-package 'flx-ido)
(add-hook 'after-init-hook 'flx-ido-mode)

;;Add ido all over Emacs, not just for buffers and files
(require-package 'ido-ubiquitous)
(add-hook 'after-init-hook 'ido-ubiquitous-mode)

;;Add ido for M-x
(require-package 'smex)
(global-set-key (kbd "M-x") 'smex)

(provide 'ido-mode-recipe)
