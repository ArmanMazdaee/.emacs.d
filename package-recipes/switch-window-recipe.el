;;Offer a *visual* way to choose a window to switch to
(require 'require-package)

(require-package 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)

(provide 'switch-window-recipe)
