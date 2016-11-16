;;Add autocomplete support for emacs
(require 'require-package)

(require-package 'company)

(defun company-smart-tab ()
  (interactive)
  (cond ((eq major-mode 'magit-status-mode)
         (call-interactively 'magit-section-toggle))
        (mark-active
         (indent-region (region-beginning)
                        (region-end)))
        ((looking-back "^\\s-*")
         (indent-for-tab-command))
        (t
         (company-complete-common))))


(setq company-idle-delay nil)
(add-hook 'company-mode-hook
          (lambda ()
            (define-key company-mode-map (kbd "<tab>") 'company-smart-tab)
            (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)))

(add-hook 'after-init-hook 'global-company-mode)

(setq company-backends
      '((:separate
         company-capf
         company-keywords
         company-dabbrev-code
         company-dabbrev
         company-yasnippet)))

(setq company-dabbrev-code-everywhere t)

(provide 'company-mode-recipe)
