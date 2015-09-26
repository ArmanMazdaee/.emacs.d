;;increase selected region by semantic units.
(require 'require-package)

(require-package 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(provide 'expand-region-recipe)
