;; Setup straight.el and use-package
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; General configs
(use-package emacs
  :config
  (setq create-lockfiles nil
	custom-file (expand-file-name "custom.el" user-emacs-directory)
	tab-always-indent 'complete
	completion-ignore-case t
	read-file-name-completion-ignore-case t
	read-buffer-completion-ignore-case t
	completion-styles '(flex basic))
  (fset 'yes-or-no-p 'y-or-n-p)
  (column-number-mode)
  (electric-pair-mode)
  (global-auto-revert-mode)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (menu-bar-mode -1)
  (set-frame-font "Liberation Mono 13" nil t)
  (add-to-list 'default-frame-alist '(fullscreen . maximized))
  (add-to-list 'default-frame-alist '(cursor-type . bar)))

;; Keep ~/.emacs.d clean
(use-package no-littering
  :init
  (setq no-littering-etc-directory
	(expand-file-name "litter/etc" user-emacs-directory)
	no-littering-var-directory
	(expand-file-name "litter/var" user-emacs-directory))
  :config
  (no-littering-theme-backups))

;; Highly accessible themes for GNU Emacs
(use-package modus-themes
  :config
  (load-theme 'modus-vivendi-tinted t))

;; swing on trees like a monkey
;; (use-package monkey
;;   :straight nil
;;   :load-path "monkey"
;;   :config
;;   (monkey-mode))

;; Minor mode for God-like command entering
;; (use-package god-mode
;;   :demand t
;;   :bind (("<escape>" . god-mode-all))
;;   :config
;;   (setq god-exempt-major-modes nil
;; 	god-exempt-predicates nil
;; 	god-mode-enable-function-key-translation nil)
;;   (add-hook 'post-command-hook
;; 	    (lambda () (setq cursor-type (if god-local-mode 'box 'bar))))
;;   (god-mode))

;; Yet another modal editing on Emacs
;; (use-package meow
;;   :config
;;   (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
;;   (meow-motion-overwrite-define-key
;;    '("j" . meow-next)
;;    '("k" . meow-prev)
;;    '("<escape>" . ignore))
;;   (meow-leader-define-key
;;    ;; SPC j/k will run the original command in MOTION state.
;;    '("j" . "H-j")
;;    '("k" . "H-k")
;;    ;; Use SPC (0-9) for digit arguments.
;;    '("1" . meow-digit-argument)
;;    '("2" . meow-digit-argument)
;;    '("3" . meow-digit-argument)
;;    '("4" . meow-digit-argument)
;;    '("5" . meow-digit-argument)
;;    '("6" . meow-digit-argument)
;;    '("7" . meow-digit-argument)
;;    '("8" . meow-digit-argument)
;;    '("9" . meow-digit-argument)
;;    '("0" . meow-digit-argument)
;;    '("/" . meow-keypad-describe-key)
;;    '("?" . meow-cheatsheet))
;;   (meow-normal-define-key
;;    '("0" . meow-expand-0)
;;    '("9" . meow-expand-9)
;;    '("8" . meow-expand-8)
;;    '("7" . meow-expand-7)
;;    '("6" . meow-expand-6)
;;    '("5" . meow-expand-5)
;;    '("4" . meow-expand-4)
;;    '("3" . meow-expand-3)
;;    '("2" . meow-expand-2)
;;    '("1" . meow-expand-1)
;;    '("-" . negative-argument)
;;    '(";" . meow-reverse)
;;    '("," . meow-inner-of-thing)
;;    '("." . meow-bounds-of-thing)
;;    '("[" . meow-beginning-of-thing)
;;    '("]" . meow-end-of-thing)
;;    '("a" . meow-append)
;;    '("A" . meow-open-below)
;;    '("b" . meow-back-word)
;;    '("B" . meow-back-symbol)
;;    '("c" . meow-change)
;;    '("d" . meow-delete)
;;    '("D" . meow-backward-delete)
;;    '("e" . meow-next-word)
;;    '("E" . meow-next-symbol)
;;    '("f" . meow-find)
;;    '("g" . meow-cancel-selection)
;;    '("G" . meow-grab)
;;    '("h" . meow-left)
;;    '("H" . meow-left-expand)
;;    '("i" . meow-insert)
;;    '("I" . meow-open-above)
;;    '("j" . meow-next)
;;    '("J" . meow-next-expand)
;;    '("k" . meow-prev)
;;    '("K" . meow-prev-expand)
;;    '("l" . meow-right)
;;    '("L" . meow-right-expand)
;;    '("m" . meow-join)
;;    '("n" . meow-search)
;;    '("o" . meow-block)
;;    '("O" . meow-to-block)
;;    '("p" . meow-yank)
;;    '("q" . meow-quit)
;;    '("Q" . meow-goto-line)
;;    '("r" . meow-replace)
;;    '("R" . meow-swap-grab)
;;    '("s" . meow-kill)
;;    '("t" . meow-till)
;;    '("u" . meow-undo)
;;    '("U" . meow-undo-in-selection)
;;    '("v" . meow-visit)
;;    '("w" . meow-mark-word)
;;    '("W" . meow-mark-symbol)
;;    '("x" . meow-line)
;;    '("X" . meow-goto-line)
;;    '("y" . meow-save)
;;    '("Y" . meow-sync-grab)
;;    '("z" . meow-pop-selection)
;;    '("'" . repeat)
;;    '("<escape>" . ignore))
;;   (meow-global-mode))

; Completion Overlay Region FUnction
(use-package corfu
  :demand t
  :bind (:map corfu-map
	      ("<escape>" . corfu-quit)
	      ("<tab>" . corfu-next)
	      ("M-<tab>" . corfu-previous)
	      ("<return>" . corfu-complete))
  :config
  (setq corfu-cycle t
	corfu-preselect t)
  (global-corfu-mode))

;; VERTical Interactive COmpletion
(use-package vertico
  :config
  (setq vertico-cycle t)
  (vertico-mode))

;; Marginalia in the minibuffer
(use-package marginalia
  :config
  (marginalia-mode))

;; A better Emacs *help* buffer
(use-package helpful
  :bind (("C-h C-f" . helpful-callable)
	 ("C-h C-v" . helpful-variable)
	 ("C-h C-k" . helpful-key)
	 ("C-h C-p" . helpful-at-point)))

;; A minor mode to visualize blanks
(use-package whitespace
  :custom
  (whitespace-style '(face trailing empty))
  :config
  (global-whitespace-mode))

;; Colorize delimiter pairs
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; A Git Porcelain inside Emacs
(use-package magit)
