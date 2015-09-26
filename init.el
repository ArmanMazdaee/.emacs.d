;;Add inits and package-recipes to load-path
(add-to-list 'load-path (concat user-emacs-directory "inits/"))
(add-to-list 'load-path (concat user-emacs-directory "my-elisps/"))
(add-to-list 'load-path (concat user-emacs-directory "package-recipes/"))

;;Load main init file
(require 'main-init)
