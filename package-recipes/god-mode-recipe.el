(require 'require-package)
;;Global minor mode for entering Emacs commands without modifier keys
(require-package 'god-mode)

;;bind god-mode to escape and make it global
(global-set-key (kbd "<escape>") 'god-mode-all)
(setq god-exempt-major-modes nil)
(setq god-exempt-predicates nil)

;; ;;change cursor-type when god mod is enable
(add-hook 'god-mode-enabled-hook
          (lambda ()
            (setq cursor-type 'box)))
(add-hook 'god-mode-disabled-hook
          (lambda ()
            (setq cursor-type (default-value 'cursor-type))))

;;Some handy short cuts
(add-hook 'after-init-hook
          (lambda ()
            (require 'god-mode)
            (define-key god-local-mode-map (kbd "<escape>")
              (lambda ()
                (interactive)
                (execute-kbd-macro (kbd "C-g"))))
            (define-key god-local-mode-map (kbd "i") 'god-mode-all)))

;;isearch integration
(add-hook 'after-init-hook
          (lambda ()
            (require 'god-mode-isearch)
            (define-key isearch-mode-map (kbd "<escape>") 'god-mode-isearch-activate)
            (define-key god-mode-isearch-map (kbd "i") 'god-mode-isearch-disable)
            (define-key god-mode-isearch-map (kbd "<escape>") 'isearch-abort)))

(provide 'god-mode-recipe)
