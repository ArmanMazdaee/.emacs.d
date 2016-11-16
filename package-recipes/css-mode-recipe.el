;;Css mode recipe

;;use two space as indent
(setq css-indent-offset 2)

;;add auto complete support
(add-hook 'css-mode-hook
          (lambda ()
            (add-to-list (make-local-variable 'company-backends) 'company-css)))


(provide 'css-mode-recipe)
