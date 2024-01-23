;; -*- lexical-binding: t -*-
(require 'cl-lib)

(cl-defstruct (monkey-mode-state (:constructor nil)
				 (:copier nil))
  "Base struct for states to include")

(cl-defgeneric monkey-mode-display-state (state)
  "Update emacs to reflect the state")

(defvar-local monkey-mode--state nil
  "The active state of the monkey")

(defun monkey-mode-update-state (new-state)
  "Update the active state of the monkey"
  (when-let (monkey-mode-state-p new-state)
    (monkey-mode-display-state new-state)
    (setq monkey-mode--state new-state)))

(defvar monkey-mode-state-initiators-list nil
  "On monkey-mode-init-state each initiator will be called till one of them
return a valid state")

(defun monkey-mode-init-state ()
  "Initiate monkey mode state of the buffer"
  (named-let rfunc ((initiators monkey-mode-state-initiators-list))
    (if-let ((state (monkey-mode-update-state (funcall (car initiators)))))
	state
      (rfunc (cdr initiators)))))

(defvar-local monkey-mode--keymap nil
  "The active keymap of the monkey")

(defun monkey-mode-update-keymap (keymap)
  "Update the active keymap of the monkey-mode"
  (setq monkey-mode--keymap `((monkey-mode . ,keymap))))

(defvar-local monkey-mode--modeline " monkey-mode<>"
  "The lighter of monkey mode")

(defun monkey-mode-update-modeline (str)
  (setq monkey-mode--modeline
	(format " monkey-mode<%s>" str))
  (force-mode-line-update))

(define-minor-mode monkey-mode
  "Modal editing based on trees"
  :global t
  :lighter (:eval monkey-mode--modeline)
  (if monkey-mode
    ()))

(add-to-list 'emulation-mode-map-alists 'monkey-mode--keymap)

(provide 'monkey-mode)
