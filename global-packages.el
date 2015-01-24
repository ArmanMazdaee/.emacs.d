;;increase selected region by semantic units.
(add-to-list 'my-packages-list 'expand-region)
(add-hook 'after-my-packages-init-hook
          (lambda ()
            (global-set-key (kbd "C-;") 'er/expand-region)))

;;enabling fast/direct cursor movement in current view
(add-to-list 'my-packages-list 'ace-jump-mode)
(add-hook 'after-my-packages-init-hook
          (lambda ()
            (global-set-key (kbd "C-c SPC") 'ace-jump-mode)))
