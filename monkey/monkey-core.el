(defvar-local monkey--state)

(defvar monkey--movements-alist nil)

(defmacro define-monkey-movement (name))

(defun monkey-apply-movement (transform)
  )

(defun monkey-mode--setup ()
  )

(defun monkey-mode--teardown ()
  (setq monkey-mode--map nil))

(define-minor-mode monkey-mode
  "swing on trees like a monkey"
  :global t
  :lighter monkey-mode--lighter
  (if monkey-mode (monkey-mode--setup) (monkey-mode--teardown)))

(add-to-list 'emulation-mode-map-alists 'monkey-mode--map)

(provide 'monkey-core)
