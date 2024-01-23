(defvar monkey-keymap--alist nil)

(defmacro monkey-keymap--keymap-symbol (name)
  `(intern (format "monkey-keymap--%s-map" ,name)))

(defmacro monkey-keymap--state-symbol (name)
  `(intern (format "monkey-keymap--%s-state" ,name)))

(defmacro define-monkey-keymap (name &rest rest)
  "Define a new keymap which can get activate and deactivate for each buffer.
Arguments and return value is like defvar-keymap."
  (declare (indent 1))
  (let ((state (monkey-keymap--state-symbol name))
	(keymap (monkey-keymap--keymap-symbol name)))
    `(progn
       (defvar-local ,state nil)
       (defvar-keymap ,keymap ,@rest)
       (add-to-list 'monkey-keymap--alist (cons ',state ,keymap)))))

(defmacro monkey-keymap-bind (name &rest rest)
  "Bind key sequences or commands on a monkey keymap"
  (declare (indent 1))
  (let ((keymap-name (monkey-keymap--keymap-symbol name)))
    `(dolist (binding ',rest)
       (keymap-set ,keymap-name (car binding) (cdr binding)))))

(defun monkey-keymap-p (name)
  "Return non-nil if monkey keymap named NAME is active"
  (symbol-value (monkey-keymap--state-symbol name)))

(defun monkey-keymap-on (name)
  "Enable monkey keymap named NAME"
  (set (monkey-keymap--state-symbol name) t))

(defun monkey-keymap-off (name)
  "Disable monkey keymap named NAME"
  (set (monkey-keymap--state-symbol name) nil))

(defun monkey-keymap-toggle (name)
  "Disable monkey keymap named NAME"
  (set (monkey-keymap--state-symbol name)
       (not (monkey-keymap-p name))))

(defvar-keymap monkey-keymap-global-map
  :doc "monkey global keymap")

(add-to-list 'monkey-keymap--alist
	     (cons 'monkey-mode monkey-keymap-global-map))

(defvar monkey-mode--map)

(defmacro monkey-keyboard-save-excursion (&rest rest)
  `(let ((v monkey-mode--map))
     (save-mark-and-excursion
       (unwind-protect
	   (progn
	     (setq monkey-mode--map nil)
	     ,@rest)
	 (setq monkey-mode--map v)))))

(define-minor-mode monkey-mode
  "swing on trees like a monkey"
  :global t
  (if monkey-mode
      (setq monkey-mode--map monkey-keymap--alist)
    (setq monkey-mode--map nil)))

(add-to-list 'emulation-mode-map-alists 'monkey-mode--map)

(provide 'monkey-keymap)
