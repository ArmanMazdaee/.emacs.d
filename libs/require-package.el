(setq required-packages nil)

(defun required-package-p (pkg)
  "Return true if package PKG is required"
  (memql pkg required-packages))

(defun require-package (pkg)
  "Require package PKG to install with install-required-packages"
  (unless (required-package-p pkg)
    (add-to-list 'required-packages pkg)))

(defun required-packages-install ()
  "Install required packages"
  (unless package-archive-contents
    (package-refresh-contents))
  (dolist (package required-packages)
    (unless (package-installed-p package)
      (message "Installing %S" package)
      (package-install package))))
