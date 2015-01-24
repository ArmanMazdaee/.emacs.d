;;disable backup and
(setq backup-inhibited t)
(setq auto-save-default nil)

;;enter just y-or-n insted of yes-or-no
(fset 'yes-or-no-p 'y-or-n-p)

;;set default tab setting
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;;show line and column numbers in mode line
(line-number-mode 1)
(column-number-mode 1)

;;delete all whitespaces at the end of a file before save file
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;highlight current line
(global-hl-line-mode)

(delete-selection-mode t)
(global-visual-line-mode t)

;;indent after yanking code
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
