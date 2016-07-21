;;GUI related configs

;;disable toolbar and scrollbar
(tool-bar-mode -1)
(scroll-bar-mode -1)

;;set font
(set-frame-font "Inconsolata-14")

;;set cursor type
(setq-default cursor-type '(bar . 2))

;;load sanityic-tomorrow-night theme
(require 'sanityinc-tomorrow-night-theme-recipe)

(provide 'gui-init)
