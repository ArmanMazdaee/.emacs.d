(setq my-packages-recipes '())

;; (add-to-list 'my-packages-recipes
;; 	     '(:name simple
;; 		     :repo "melpa"
;; 		     :before (message "before installing sample package")
;; 		     :after (message "after installing sample package")))

(add-to-list 'my-packages-recipes
             '(:name auto-complete
                     :after (add-hook 'auto-complete-mode-hook
                                      (lambda ()
                                        (ac-set-trigger-key "TAB")
                                        (setq ac-auto-start nil)))))
