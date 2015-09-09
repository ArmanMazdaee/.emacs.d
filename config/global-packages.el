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

;;a front end, or “porcelain” for the Git version control system
(add-to-list 'my-packages-list 'magit)
(add-hook 'after-my-packages-init-hook
          (lambda ()
            (global-set-key (kbd "C-x C-z") 'magit-status)))

;;ido-mode
(add-to-list 'my-packages-list 'flx-ido)
(add-hook 'after-my-packages-init-hook
          (lambda ()
            (ido-mode 1)
            (ido-everywhere 1)
            (flx-ido-mode 1)
            (setq ido-enable-flex-matching t)
            (setq ido-use-faces nil)
            (setq ido-save-directory-list-file "~/.emacs.d/ido")
            (setq ido-use-filename-at-point 'guess)))

;;a M-x enhancement for Emacs. Built on top of Ido
(add-to-list 'my-packages-list 'smex)
(add-hook 'after-my-packages-init-hook
          (lambda ()
            (global-set-key (kbd "M-x") 'smex)))

;; ;;Offer a *visual* way to choose a window to switch to
(add-to-list 'my-packages-list 'switch-window)
(add-hook 'after-my-packages-init-hook
          (lambda ()
            (global-set-key (kbd "C-x o") 'switch-window)))
