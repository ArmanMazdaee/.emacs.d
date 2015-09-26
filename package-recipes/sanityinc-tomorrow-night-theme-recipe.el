;;Sanityic-tomorrow-night theme
;;make sure sanityinc-tomorrow theme is installed
(require 'require-package)

(require-package 'color-theme-sanityinc-tomorrow)

;;Load sanityinc-tomorrow-night
(add-hook 'after-init-hook
	  (lambda ()
	    (load-theme 'sanityinc-tomorrow-night t)))

(provide 'sanityinc-tomorrow-night-theme-recipe)
