;;Install js2 mode and use it as javascript major mode
(require 'require-package)

(require-package 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;;Set highlight level to most highlighted
;;(setq js2-highlight-level 3)

;;set indent width to 2
(setq js2-basic-offset 2)


;;Add flycheck if jshint is installed for linting code
(if (executable-find "jshint")
    (progn
     (require 'flycheck-recipe)
     (add-hook 'js2-mode-hook 'flycheck-mode))
  (add-hook 'js2-mode-hook
            (lambda ()
              (display-warning 'javascript (format "%s\n%s\n%s\n%s\n"
                                                   "jshint is not in your path"
                                                   "Please install it with:"
                                                   "npm install -g jshint"
                                                   "and restart your emacs")
                               :warning "*javascript warnings*"))))

;;Install skewer-mode for Live web development in Emacs
(require 'skewer-mode-recipe)
(add-hook 'js2-mode-hook 'skewer-mode)

;;Check if torn is install and if it is, install company-tern
(if (executable-find "tern")
    (progn
      (require 'company-mode-recipe)
      (require-package 'tern)
      (require-package 'company-tern)
      (add-hook 'js2-mode-hook
                (lambda ()
                  (set (make-local-variable 'company-backends) '(company-tern))
                  (company-mode t)
                  (tern-mode t))))
  (add-hook 'js2-mode-hook
            (lambda ()
              (display-warning 'javascript (format "%s\n%s\n%s\n%s\n"
                                           "tern is not in your path and you need it for autocomplete"
                                           "Please install it with:"
                                           "npm install -g tern"
                                           "and restart your emacs")
                               :warning "*javascript warnings*"))))

(provide 'javascript-mode-recipe)
