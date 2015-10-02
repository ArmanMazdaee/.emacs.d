;;Install go-mode for go development
(require 'require-package)

(require-package 'go-mode)

;;run gofmt before saving file
(add-hook 'go-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'gofmt-before-save)))

;;check if goimports is install and if it is, use it insted of gofmt
(if (executable-find "goimports")
    (add-hook 'go-mode-hook
              (lambda ()
                (setq gofmt-command "goimports")))
  (add-hook 'go-mode-hook
            (lambda ()
              (display-warning 'Go (format "%s\n%s\n%s\n%s\n"
                                           "goimports is not in your path"
                                           "Please install it with:"
                                           "go get golang.org/x/tools/cmd/goimports"
                                           "and restart your emacs")
                               :warning "*Go warnings*"))))

;;check if godef is install and if it is, use M-. for godef-jump
(if (executable-find "godef")
    (add-hook 'go-mode-hook
              (lambda ()
                (local-set-key (kbd "M-.") 'godef-jump)))
  (add-hook 'go-mode-hook
            (lambda ()
              (display-warning 'Go (format "%s\n%s\n%s\n%s\n"
                                           "godef is not in your path"
                                           "Please install it with:"
                                           "go get code.google.com/p/rog-go/exp/cmd/godef"
                                           "and restart your emacs")
                               :warning "*Go warnings*"))))


;;Add yasnippet
(require 'yasnippet-recipe)
(add-hook 'go-mode-hook 'yas-minor-mode)

;;check if gocode is install and if it is, install go-eldoc and company-go
(if (executable-find "gocode")
    (progn
      (require-package 'go-eldoc)
      (add-hook 'go-mode-hook 'go-eldoc-setup)

      (require 'company-mode-recipe)
      (require-package 'company-go)
      (add-hook 'go-mode-hook
                (lambda ()
                  (set (make-local-variable 'company-backends) '(company-go))
                  (company-mode t))))
  (add-hook 'go-mode-hook
            (lambda ()
              (display-warning 'Go (format "%s\n%s\n%s\n%s\n"
                                           "gocode is not in your path and you need it for el-doc and autocomplete"
                                           "Please install it with:"
                                           "go get github.com/nsf/gocode"
                                           "and restart your emacs")
                               :warning "*Go warnings*"))))

;;Add flycheck
(require 'flycheck-recipe)
(add-hook 'go-mode-hook 'flycheck-mode)

(provide 'go-mode-recipe)
