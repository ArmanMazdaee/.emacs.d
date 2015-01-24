;;disable backup and
(setq backup-inhibited t)
(setq auto-save-default nil)

;;enter just y-or-n insted of yes-or-no
(fset 'yes-or-no-p 'y-or-n-p)

;;set default tab setting
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;;show line and column numbers in mode line
(line-number-mode 1)
(column-number-mode 1)

;;delete all whitespaces at the end of a file before save file
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;highlight current line
(global-hl-line-mode)

(delete-selection-mode t)
(global-visual-line-mode t)
