;;enabling fast/direct cursor movement in current view
(require 'require-package)

(require-package 'ace-jump-mode)
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)

(provide 'ace-jump-mode-recipe)
