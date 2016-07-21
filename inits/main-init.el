;;Main init file

;;Package.el configs
(require 'package-init)

;;Load global-init contain some global configs and
;;requiring global package recipes
(require 'global-init)

;;load gui configs
(require 'gui-init)

;;Load major mode recipe files
(require 'web-mode-recipe)
(require 'javascript-mode-recipe)
(require 'go-mode-recipe)
(require 'scala-mode-recipe)

;;Install required packages
(require 'require-package)
(package-initialize)
(required-packages-install)

(provide 'main-init)
