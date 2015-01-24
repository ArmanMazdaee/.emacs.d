(require 'cl-lib)

;;add repo to packages-archives and initialize packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

;;add any package you want to this list
(setq my-packages-list '())
;;add things you want to get done after your package initialize to this hook
(setq after-my-packages-init-hook '())

(defun install-my-packages (packages-list)
  "Get a list of packages and install them if needed"
  (let ((need-to-refresh t))
    (dolist (package packages-list)
      (unless (package-installed-p package)
        (if need-to-refresh
            (progn
              (message "Refreshing packages arhive")
              (setq need-to-refresh nil)
              (package-refresh-contents)))
        (message "Installing %S" package)
        (package-install package)))))

;;install packages in my-packages-lists
(remove-duplicates my-packages-list)
(install-my-packages my-packages-list)
(run-hooks 'after-my-packages-init-hook)

