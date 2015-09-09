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
  "Get a list of packages and install them"
  (dolist (package my-packages-recipes)
    (let ((name (cl-getf package :name))
          (repo (cl-getf package :repo)))
      (add-to-list 'package-pinned-packages '(name . repo))))

  (dolist (package my-packages-recipes)
    (let ((before (cl-getf package :before)))
      (if before
          (eval before))))

  (let ((need-to-refresh t))
    (dolist (package packages-list)
      (unless (package-installed-p package)
        (if need-to-refresh
            (progn
              (message "Refreshing packages arhive")
              (setq need-to-refresh nil)
              (package-refresh-contents)))
        (message "Installing %S" package)
        (package-install package))))

  (dolist (package my-packages-recipes)
    (let ((name (cl-getf package :name))
          (after (cl-getf package :after)))
      (if (and
           after
           (package-installed-p name))
          (eval after)
        (message "%S" package)))))

;;Load personal recipes for packages
(load (expand-file-name "package-recipes"
                        (file-name-directory load-file-name)))

;;Load your config files here
(let ((init-dir (file-name-directory load-file-name)))
  (load (expand-file-name "config" init-dir))
  (load (expand-file-name "gui-config" init-dir))
  (load (expand-file-name "global-packages" init-dir))
  (load (expand-file-name "web" init-dir))
  (load (expand-file-name "go" init-dir)))

;;install packages in my-packages-lists
(cl-remove-duplicates my-packages-list)
(install-my-packages my-packages-list)
(run-hooks 'after-my-packages-init-hook)
