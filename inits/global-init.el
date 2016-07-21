;;Global-init contain some global configs and requiring
;;global package recipes

;;Disable backup and auto-saves
(setq backup-inhibited t)
(setq auto-save-default nil)

;;Enter just y-or-n insted of yes-or-no
(fset 'yes-or-no-p 'y-or-n-p)

;;Set default tab setting
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;;Show line and column numbers in mode line
(line-number-mode 1)
(column-number-mode 1)

;;Delete all whitespaces at the end of a file before save file
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;Highlight current line
(global-hl-line-mode)

;;Replace region with input
(delete-selection-mode t)

;;Provides support for editing by visual lines.
(global-visual-line-mode t)

;;Indent region after yanking code
(let ((indet (lambda (&optional ARG)
               (indent-region
                (save-excursion
                  (goto-char (mark))
                  (line-beginning-position))
                (point)))))
  (advice-add 'yank :after indet)
  (advice-add 'yank-pop :after indet))

;;duplicate line
(defun duplicate-line ()
  "Duplicate current line and move point to end of it"
  (interactive)
  (let ((start (line-beginning-position))
        (end (line-end-position)))
    (end-of-line)
    (insert "\n" (buffer-substring start end))))
(global-set-key (kbd "M-l") 'duplicate-line)

;;increase selected region by semantic units.
(require 'expand-region-recipe)

;;Jump to things in Emacs tree-style
(require 'avy-recipe)

;;a front end, or “porcelain” for the Git version control system
(require 'magit-recipe)

;;ido-mode
(require 'ido-mode-recipe)

;;Quickly switch windows in Emacs
(require 'ace-window-recipe)

;;Undo”(and “redo”) changes in the window configuration with the key commands
(require 'winner-mode-recipe)

;;Global auto revert mode to automaticly update changed files
(require 'auto-revert-mode-recipe)

;;Global minor mode for entering Emacs commands without modifier keys
(require 'god-mode-recipe)

(provide 'global-init)
