;;elscreen patched to work with recent Emacs
(require 'require-package)

(require-package 'elscreen)

(add-hook 'after-init-hook 'elscreen-start)
(setq elscreen-display-tab nil)

(provide 'elscreen-recipe)
