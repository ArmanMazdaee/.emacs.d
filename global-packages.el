;;increase selected region by semantic units.
(add-to-list 'my-packages-list 'expand-region)
(add-hook 'after-my-packages-init-hook
          (lambda ()
            (global-set-key (kbd "C-;") 'er/expand-region)))
