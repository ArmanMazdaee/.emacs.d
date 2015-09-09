;;disable toolbar and scrollbar
(tool-bar-mode -1)
(scroll-bar-mode -1)

;;set font
(set-frame-font "Inconsolata-14")

;;install and enable sanityinc-tomorrow theme
(add-to-list 'my-packages-list 'color-theme-sanityinc-tomorrow)
(add-hook 'after-my-packages-init-hook
          (lambda ()
            (load-theme 'sanityinc-tomorrow-night t)))
