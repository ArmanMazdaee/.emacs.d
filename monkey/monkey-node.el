;; -*- lexical-binding: t -*-
(require 'cl-lib)

(cl-defstruct (monkey-node (:constructor nil)
			   (:copier nil))
  "Base struct for other nodes to include"
  (name nil :read-only t :type string :documentation "name of the node")
  (start nil :read-only t :type integer :documentation "start of the node")
  (end nil :read-only t :type integer :documentation "end of the node"))

(cl-defgeneric monkey-node-parent (node)
  "Return the parent of the node, nil if node is root")

(cl-defgeneric monkey-node-previous-sibling (node)
  "Return the previous sibling of the node, nil if node is first child")

(cl-defgeneric monkey-node-next-sibling (node)
  "Return the next sibling of the node, nil if node is last child")

(cl-defgeneric monkey-node-first-child (node)
  "Return the first child of the node, nil if node is a leaf")

(cl-defgeneric monkey-node-last-child (node)
  "Return the last child of the node, nil if node is a leaf")

(defun monkey-node-named-p (node &optional name)
  "Return t if the node name is not empty, nil otherwise"
  (if name
      (string= name (monkey-node-name node))
    (string-empty-p (monkey-node-name node))))

(defun monkey-node-contain-p (node start &optional end)
  "Return t if start is after start of the node, nil otherwise"
  (and (<= (monkey-node-start node) start)
       (or (not end)
	   (>= (monkey-node-end node) end))))

(defun monkey-node-root-p (node)
  "Return t if the node name is not empty, nil otherwise"
  (not (monkey-node-parent node)))

(defun monkey-node-leaf-p (node)
  "Return t if the node has no child, nil otherwise"
  (not (monkey-node-first-child node)))

(defun monkey-node-first-sibling-p (node)
  "Return t if the node is the first child of its parent, nil otherwise"
  (not (monkey-node-previous-sibling node)))

(defun monkey-node-last-sibling-p (node)
  "Return t if the node is the first child of its parent, nil otherwise"
  (not (monkey-node-next-sibling node)))

(defun monkey-node-root (node)
  "Return the root of the node"
  (named-let rfunc ((rnode node))
    (if-let ((parent (monkey-node-parent rnode)))
	(rfunc parent)
      rnode)))

(defun monkey-node-depth (node)
  "Return the distance of the node, from the root"
  (named-let rfunc ((rnode node)
		    (depth 0))
    (if-let ((parent (monkey-node-parent rnode)))
	(rfunc parent (+1 depth))
      depth)))

(defun monkey-node-descendant-on (node start end)
  "Return the smallest descendant of node, containing the region"
  (named-let rfunc ((rnode node))
    (cond ((not (monkey-node-contain-p rnode start end)) nil)
	  ((monkey-node-leaf-p rnode) rnode)
	  (t (let ((child (monkey-node-first-child rnode)))
	       (while (not (monkey-node-contain-p child start end))
		 (setq child (monkey-node-next-sibling child)))
	       (rfunc child))))))

(defun monkey-node-named-descendant-on (node start end &optional name)
  "Return the smallest named descendant of node, containing the region"
  (named-let rfunc ((rnode (monkey-node-descendant-on node start end)))
    (cond ((not rnode) nil)
	  ((monkey-node-named rnode name) rnode)
	  ((equal rnode node) nil)
	  (t (rfunc (monkey-node-parent rnode))))))

(defun monkey-node-descendant-at (node pos)
  "Return the smallest descendant of node at the pos"
  (monkey-node-descendant-on node pos nil))

(defun monkey-node-named-descendant-at (node pos &optional name)
  "Return the smallest named descendant of node at the pos"
  (monkey-node-named-descendant-on node pos nil name))

(defun monkey-node-next (node)
  "Return the next node with the same depth"
  (named-let rfunc ((rnode node)
		    (height 0))
    (let ((next (monkey-node-next-sibling rnode))
	  (child (monkey-node-first-child rnode)))
      (cond ((and (= height 0) next) next)
	    ((and (= height 1) child) child)
	    ((and (> height 1) child) (rfunc child (1- height)))
	    ((and (> height 0) next) (rfunc next height))
	    (t (while (and rnode (monkey-node-last-sibling-p rnode))
		 (setq rnode (monkey-node-parent rnode))
		 (setq height (1+ height)))
	       (if rnode
		   (rfunc (monkey-node-next-sibling rnode) height)
		 nil))))))

(defun monkey-node-next-named (node &optional name)
  "Return the next named node with the same depth"
  (named-let rfunc ((rnode node))
    (if-let ((next (monkey-node-next rnode)))
	(if (monkey-node-named-p next name)
	    next
	  (rfunc next))
      nil)))

(defun monkey-node-previous (node)
  "Return the previous node with the same depth"
  (named-let rfunc ((rnode node)
		    (height 0))
    (let ((previous (monkey-node-previous-sibling rnode))
	  (child (monkey-node-last-child rnode)))
      (cond ((and (= height 0) previous)
	     previous)
	    ((and (= height 1) child)
	     child)
	    ((and (> height 1) child)
	     (rfunc child (1- height)))
	    ((and (> height 0) previous)
	     (rfunc previous height))
	    (t
	     (while (and rnode (monkey-node-first-sibling-p rnode))
	       (setq rnode (monkey-node-parent rnode))
	       (setq height (1+ height)))
	     (if rnode
		 (rfunc (monkey-node-previous-sibling rnode) height)
	       nil))))))

(defun monkey-node-previous-named (node &optional name)
  "Return the previous named node with the same depth"
  (named-let rfunc ((rnode node))
    (if-let ((previous (monkey-node-previous rnode)))
	(if (monkey-node-named-p previous name)
	    previous
	  (rfunc previous))
      nil)))

(provide 'monkey-node)
