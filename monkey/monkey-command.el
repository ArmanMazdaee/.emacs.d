(require 'monkey-node)
(require 'monkey-keymap)

(defvar-local monkey-command--primary-node nil
  "monkey primary node")

(defvar-local monkey-command--secondary-node nil
  "monkey secondary node")

(defvar-local monkey-command--mark-first-flag nil
  "monkey mark and point order")

(defun monkey-command--update-region ()
  (if (not monkey-command--primary-node)
      (deactivate-mark)
    (activate-mark)
    (if (not monkey-command--secondary-node)
	(let ((start (monkey-node-start monkey-command--primary-node))
	      (end (monkey-node-end monkey-command--primary-node)))
	  (set-mark (if monkey-command--mark-first-flag start end))
	  (goto-char (if monkey-command--mark-first-flag end start)))
      (let* ((primary-start (monkey-node-start monkey-command--primary-node))
	     (primary-end (monkey-node-end monkey-command--primary-node))
	     (secondary-start (monkey-node-start monkey-command--secondary-node))
	     (secondary-end (monkey-node-end monkey-command--secondary-node))
	     (start (min primary-start secondary-start))
	     (end (max primary-end secondary-end)))
	(set-mark (if monkey-command--mark-first-flag start end))
	(goto-char (if monkey-command--mark-first-flag end start))))))

(defun monkey-command--update-primary-node (primary)
  (setq-local monkey-command--primary-node primary)
  (unless primary
    (setq-local monkey-command--secondary-node nil)
    (setq-local monkey-command--mark-first-flag nil))
  (monkey-command--update-region))

(defun monkey-command--update-secondary-node (secondary)
  (unless monkey-command--primary-node
    (error "monkey primary node is nil"))
  (setq-local monkey-command--secondary-node secondary)
  (monkey-command--update-region))

(defun monkey-command--update-mark-first-flag (flag)
  (setq-local monkey-command--mark-first-flag flag)
  (monkey-command--update-region))

(defun monkey-command--swap-primary-secondary-nodes ()
  (when (and monkey-command--primary-node monkey-command--secondary-node)
    (let ((temp monkey-command--primary-node))
      (setq-local monkey-command--primary-node monkey-command--secondary-node
		  monkey-command--secondary-node temp))
    (monkey-command--update-region)))

(define-monkey-keymap command
  "<t>" 'undefined)

(defun monkey-command-escape ()
  "Monkey escapes to command state. If the state is already command, issue
keyboad-quit. Also it will allways update monkey-active-node to
monkey-character-node-at point"
  (interactive)
  (monkey-command--update-primary-node
   (monkey-node-at
    'character
    (if monkey-command--mark-first-flag (1- (point)) (point))))
  (monkey-command--update-secondary-node nil)
  (if (monkey-keymap-p 'command)
      (monkey-keyboard-save-excursion (execute-kbd-macro (kbd "C-g")))
    (monkey-keymap-on 'command)))

(defun monkey-command-god-keys ()
  (interactive)
  (let ((keys "")
	(modifier 'ctrl)
	(binding t))
    (while (and binding (not (commandp binding)))
      (let ((key (key-description
		  (vector (read-key (cond ((eq modifier 'ctrl)
					   (format "%s C-" keys))
					  ((eq modifier 'meta)
					   (format "%s M-" keys))
					  ((eq modifier 'ctrl-meta)
					   (format "%s C-M-" keys))
					  ((eq modifier 'none)
					   (format "%s " keys))))))))
	(cond ((and (eq modifier 'ctrl) (string= key "SPC"))
	       (setq modifier 'none))
	      ((and (eq modifier 'ctrl) (string= key "g"))
	       (setq modifier 'meta))
	      ((and (eq modifier 'ctrl) (string= key "G"))
	       (setq modifier 'ctrl-meta))
	      ((eq modifier 'ctrl)
	       (setq keys (concat keys " C-" key)))
	      ((eq modifier 'meta)
	       (setq keys (concat keys " M-" key))
	       (setq modifier 'ctrl))
	      ((eq modifier 'ctrl-meta)
	       (setq keys (concat keys " C-M-" key))
	       (setq modifier 'ctrl))
	      ((eq modifier 'none)
	       (setq keys (concat keys " " key)))))
      (setq binding (key-binding (kbd keys)))
      (when (member binding '(universal-argument digit-argument))
	(command-execute binding nil nil t)
	(setq keys "")
	(setq modifier 'ctrl)
	(setq binding t)))
    (if binding
	(command-execute binding)
      (command-execute 'undefined))))

(defun monkey-command-insert ()
  "Put the point before the selection, clear monkey-active-node, and switch to
the normal state"
  (interactive)
  (goto-char (if monkey-command--mark-first-flag (mark) (point)))
  (monkey-command--update-primary-node nil)
  (monkey-command--update-mark-first-flag nil)
  (monkey-keymap-off 'command))

(defun monkey-command-append ()
  "Put the point after the selection, clear monkey-active-node, and switch to
the normal state"
  (interactive)
  (goto-char (if monkey-command--mark-first-flag (point) (mark)))
  (monkey-command--update-primary-node nil)
  (monkey-command--update-mark-first-flag t)
  (monkey-keymap-off 'command))

(defun monkey-command-exchange-point-and-mark ()
  "Exchange the point and mark. If secondary node is not nil, also swap primary
and secondary nodes."
  (interactive)
  (monkey-command--swap-primary-secondary-nodes)
  (exchange-point-and-mark)
  (monkey-command--update-mark-first-flag
   (not monkey-command--mark-first-flag)))

(defun monkey-command--find-node-upward (node &optional name)
  (let ((parent (monkey-node-parent node)))
    (while (and parent name (not (eq name (monkey-node-name parent))))
      (setq parent (monkey-node-parent parent)))
    parent))

(defun monkey-command--find-node-first-downward (node &optional name)
  (let ((child (monkey-node-first-child node)))
    (while (and child name (not (eq name (monkey-node-name child))))
      (if-let ((new-child
		(monkey-command--find-node-first-downward child name)))
	  (setq child new-child)
	(setq child (monkey-node-next-sibling child))))
    child))

(defun monkey-command--find-node-last-downward (node &optional name)
  (let ((child (monkey-node-last-child node)))
    (while (and child name (not (eq name (monkey-node-name child))))
      (if-let ((new-child
		(monkey-command--find-node-last-downward child name)))
	  (setq child new-child)
	(setq child (monkey-node-previous-sibling child))))
    child))

(defun monkey-command--jump-command-name (tree &optional name)
  (intern (if name
	      (format "monkey-command-jump-to-%s-tree-%s-node" tree name)
	    (format "monkey-command-jump-to-%s-tree" tree))))

(defmacro define-monkey-command-jump (tree &optional name)
  `(defun ,(monkey-command--jump-command-name tree name) ()
     (interactive)
     (if-let
	 ((node (or
		 (and
		  (eq ',tree (monkey-node-tree monkey-command--primary-node))
		  (monkey-command--find-node-upward
		   monkey-command--primary-node
		   ',name))
		 (and
		  (eq ',tree (monkey-node-tree monkey-command--primary-node))
		  monkey-command--mark-first-flag
		  (monkey-command--find-node-last-downward
		   monkey-command--primary-node
		   ',name))
		 (and
		  (eq ',tree (monkey-node-tree monkey-command--primary-node))
		  (not monkey-command--mark-first-flag)
		  (monkey-command--find-node-first-downward
		   monkey-command--primary-node
		   ',name))
		 (and
		  monkey-command--mark-first-flag
		  (monkey-node-at
		   ',tree
		   (monkey-node-end monkey-command--primary-node)
		   ',name))
		 (and
		  (not monkey-command--mark-first-flag)
		  (monkey-node-at
		   ',tree
		   (monkey-node-start monkey-command--primary-node)
		   ',name)))))
	 (monkey-command--update-primary-node node))))

(define-monkey-command-jump lexical word)
(define-monkey-command-jump lexical symbol)
(define-monkey-command-jump lexical line)
(define-monkey-command-jump lexical buffer)

(defun monkey-command-upward ()
  (interactive)
  (if-let ((parent (monkey-node-parent monkey-command--primary-node)))
      (monkey-command--update-primary-node parent)))

(defun monkey-command-first-downward ()
  (interactive)
  (monkey-command--update-primary-node
   (if-let ((child (monkey-node-first-child monkey-command--primary-node)))
       child
     (monkey-node-at 'character
		     (monkey-node-start monkey-command--primary-node)))))

(defun monkey-command-last-downward ()
  (interactive)
  (monkey-command--update-primary-node
   (if-let ((child (monkey-node-last-child monkey-command--primary-node)))
       child
     (monkey-node-at 'character
		     (1- (monkey-node-end monkey-command--primary-node))))))

(defun monkey-command-backward ()
  (interactive)
  (let ((node monkey-command--primary-node)
	(depth 0))
    (while (and node (not (monkey-node-previous-sibling node)))
      (setq node (monkey-node-parent node))
      (setq depth (1- depth)))
    (setq node (monkey-node-previous-sibling node))
    (while (and node (< depth 0))
      (cond ((monkey-node-last-child node)
	     (setq node (monkey-node-last-child node))
	     (setq depth (1+ depth)))
	    ((monkey-node-previous-sibling node)
	     (setq node (monkey-node-previous-sibling node)))
	    (t
	     (while (and node (not (monkey-node-previous-sibling node)))
	       (setq node (monkey-node-parent node))
	       (setq depth (1- depth)))
	     (setq node (monkey-node-previous-sibling node)))))
    (if (and node (= depth 0))
	(monkey-command--update-primary-node node))))

(defun monkey-command-forward ()
  (interactive)
  (let ((node monkey-command--primary-node)
	(depth 0))
    (while (and node (not (monkey-node-next-sibling node)))
      (setq node (monkey-node-parent node))
      (setq depth (1- depth)))
    (setq node (monkey-node-next-sibling node))
    (while (and node (< depth 0))
      (cond ((monkey-node-first-child node)
	     (setq node (monkey-node-first-child node))
	     (setq depth (1+ depth)))
	    ((monkey-node-next-sibling node)
	     (setq node (monkey-node-next-sibling node)))
	    (t
	     (while (and node (not (monkey-node-next-sibling node)))
	       (setq node (monkey-node-parent node))
	       (setq depth (1- depth)))
	     (setq node (monkey-node-next-sibling node)))))
    (if (and node (= depth 0))
	(monkey-command--update-primary-node node))))

(provide 'monkey-command)
