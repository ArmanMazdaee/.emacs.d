(add-to-list 'my-packages-list 'go-mode)

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

;; ;;check if oracle is install
;; (if (executable-find "oracle")
;;     (progn
;;       (load-file "$GOPATH/src/golang.org/x/tools/cmd/oracle/oracle.el")
;;       (add-hook 'go-mode-hook 'go-oracle-mode))
;;   (add-hook 'go-mode-hook
;;             (lambda ()
;;               (display-warning 'Go (format "%s\n%s\n%s\n%s\n"
;;                                            "oracle is not in your path"
;;                                            "Please install it with:"
;;                                            "go get golang.org/x/tools/cmd/oracle"
;;                                            "and restart your emacs")
;;                                :warning "*Go warnings*"))))

;;check if gocode is install and if it is, install go-eldoc and go-autocomplete
(if (executable-find "gocode")
    (progn
      (add-to-list 'my-packages-list 'go-eldoc)
      (add-hook 'go-mode-hook 'go-eldoc-setup)

      (add-to-list 'my-packages-list 'go-autocomplete)
      (add-hook 'after-my-packages-init-hook
                (lambda ()
                  (require 'auto-complete-config)
                  (require 'go-autocomplete)))
      (add-hook 'go-mode-hook 'auto-complete-mode))
  (add-hook 'go-mode-hook
            (lambda ()
              (display-warning 'Go (format "%s\n%s\n%s\n%s\n"
                                           "gocode is not in your path and you need it for el-doc and autocomplete"
                                           "Please install it with:"
                                           "go get github.com/nsf/gocode"
                                           "and restart your emacs")
                               :warning "*Go warnings*"))))

;;Add flycheck
(add-to-list 'my-packages-list 'flycheck)
(add-hook 'go-mode-hook 'flycheck-mode)
