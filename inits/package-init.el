;;Package.el configs
(require 'package)

;;Add melpa and melpa-stable repos
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;;Disable loading the packages again after processing the init file again
(setq package-enable-at-startup nil)

(provide 'package-init)
