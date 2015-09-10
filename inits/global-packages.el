;;increase selected region by semantic units.
(require-package 'expand-region)
(add-hook 'after-my-packages-init-hook
          (lambda ()
            (global-set-key (kbd "C-;") 'er/expand-region)))

;;enabling fast/direct cursor movement in current view
(require-package 'ace-jump-mode)
(add-hook 'after-my-packages-init-hook
          (lambda ()
            (global-set-key (kbd "C-c SPC") 'ace-jump-mode)))

;;a front end, or “porcelain” for the Git version control system
(require-package 'magit)
(add-hook 'after-my-packages-init-hook
          (lambda ()
            (global-set-key (kbd "C-x C-z") 'magit-status)))

;;ido-mode
(require-package 'flx-ido)
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
(require-package 'smex)
(add-hook 'after-my-packages-init-hook
          (lambda ()
            (global-set-key (kbd "M-x") 'smex)))

;; ;;Offer a *visual* way to choose a window to switch to
(require-package 'switch-window)
(add-hook 'after-my-packages-init-hook
          (lambda ()
            (global-set-key (kbd "C-x o") 'switch-window)))
