;;Add melpa and melpa-stable repos
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

;;add things you want to get done after your package initialize to this hook
(setq after-my-packages-init-hook '())

;;Load require-package
;;to make sure required packages will install with package.el
(load "~/.emacs.d/libs/require-package")

;;Load inits files
(load "~/.emacs.d/inits/config")
(load "~/.emacs.d/inits/gui-config")
(load "~/.emacs.d/inits/global-packages")
(load "~/.emacs.d/inits/web")
(load "~/.emacs.d/inits/javascript")
(load "~/.emacs.d/inits/go")

;;Install required packages
(required-packages-install)
(run-hooks 'after-my-packages-init-hook)
