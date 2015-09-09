;;Install js2 mode and use it as major mode
(add-to-list 'my-packages-list 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; (add-hook 'js-mode-hook 'js2-minor-mode)

;;Set highlight level to most highlighted
(setq js2-highlight-level 3)

;;set indent width to 2
;; (setq js-indent-level 2)
(setq js2-basic-offset 2)
;; (setq js2-bounce-indent-p t)
;; (setq js2-mode-indent-ignore-first-tab t)

;;disable js2-mode error for ES6
;; (setq js2-mode-show-parse-errors nil)
;; (setq js2-highlight-external-variables nil)

;;Add flycheck if jshint is installed
(if (executable-find "jshint")
    (add-hook 'js2-mode-hook 'flycheck-mode)
  (add-hook 'js2-mode-hook
            (lambda ()
              (display-warning 'javascript (format "%s\n%s\n%s\n%s\n"
                                           "jshint is not in your path"
                                           "Please install it with:"
                                           "npm install -g jshint"
                                           "and restart your emacs")
                               :warning "*javascript warnings*"))))

;;Install skewer-mode for js
(add-to-list 'my-packages-list 'skewer-mode)
(add-hook 'js2-mode-hook 'skewer-mode)
