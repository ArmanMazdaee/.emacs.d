;;Main init file

;;Package.el configs
(require 'package-init)

;;Load global-init contain some global configs and
;;requiring global package recipes
(require 'global-init)

;;load gui configs
(require 'gui-init)

;;Load major mode recipe files
;; (require 'html-mode-recipe)
(require 'web-mode-recipe)
(require 'css-mode-recipe)
(require 'scss-mode-recipe)
(require 'javascript-mode-recipe)
(require 'go-mode-recipe)
(require 'scala-mode-recipe)
(require 'python-mode-recipe)

;;Install required packages
(require 'require-package)
(package-initialize)
(required-packages-install)

(provide 'main-init)
