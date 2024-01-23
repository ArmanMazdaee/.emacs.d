;; -*- lexical-binding: t -*-
(require 'cl-lib)
(require 'monkey-node)

(cl-defstruct (monkey-lexical-node
	       (:include monkey-node)
	       (:constructor monkey-node-lexical--create)
	       (:copier nil))
  "Node for lexical tree, based on the thing framework of emacs")

(put 'paragraph 'forward-op 'forward-paragraph)
(put 'paragraph 'beginning-op (lambda ()
				(backward-paragraph)
				(while (looking-at-p "[[:space:]]*$")
				  (forward-line))))
(put 'buffer 'bounds-of-thing-at-point
     (lambda () (cons (point-min) (point-max))))

(defvar monkey-lexical-hierarchical-list
  '(char word symbol line paragraph buffer)
  "List of symbols to be used with thing-at-point and similar functions by
monkey lexical tree. Each value of list should be a substring of next one.")

(cl-defmethod monkey-node-parent ((node monkey-lexical-node))
  (save-mark-and-excursion
    (let ((name (monkey-node-name node))
	  (start (monkey-node-start node))
	  (end (monkey-node-end node)))
      (goto-char end)
      (cl-dolist (thing
		  (cdr (member name monkey-node-lexical-hierarchical-list)))
	(if-let ((parent-bound (bounds-of-thing-at-point thing))
		 (parent-start (car parent-bound))
		 (parent-end (cdr parent-bound))
		 ((<= parent-start start))
		 ((>= parent-end end)))
	    (cl-return (monkey-node-lexical--create :name thing
						    :start parent-start
						    :end parent-end)))))))

(cl-defmethod monkey-node-previous-sibling ((node monkey-lexical-node))
  (save-mark-and-excursion
    (goto-char (monkey-node-start node))
    (if-let ((thing (monkey-node-name node))
	     (parent (monkey-node-parent node))
	     (parent-start (monkey-node-start parent))
	     (parent-end (monkey-node-end parent))
	     ((or (forward-thing thing -1)
		  (thing-at-point thing)))
	     (bound (bounds-of-thing-at-point thing))
	     (start (car bound))
	     (end (cdr bound))
	     ((<= parent-start start))
	     ((>= parent-end end)))
	(monkey-node-lexical--create :name thing
				     :start start
				     :end end))))

(cl-defmethod monkey-node-next-sibling ((node monkey-lexical-node))
  (save-mark-and-excursion
    (goto-char (monkey-node-end node))
    (if-let ((thing (monkey-node-name node))
	     (parent (monkey-node-parent node))
	     (parent-start (monkey-node-start parent))
	     (parent-end (monkey-node-end parent))
	     ((or (forward-char)
		  (thing-at-point thing)
		  (forward-thing thing)
		  (thing-at-point thing)))
	     (bound (bounds-of-thing-at-point thing))
	     (start (car bound))
	     (end (cdr bound))
	     ((<= parent-start start))
	     ((>= parent-end end)))
	(monkey-node-lexical--create :name thing
				     :start start
				     :end end))))

(cl-defmethod monkey-node-first-child ((node monkey-lexical-node))
  (save-mark-and-excursion
    (let ((name (monkey-node-name node))
	  (start (monkey-node-start node))
	  (end (monkey-node-end node))
	  child)
      (cl-dolist (thing monkey-node-lexical-hierarchical-list)
	(if (eq name thing)
	    (cl-return child))
	(goto-char start)
	(if-let ((bound (or (bounds-of-thing-at-point thing)
			    (progn (forward-thing thing)
				   (bounds-of-thing-at-point thing))))
		 ((<= start (car bound)))
		 ((>= end (cdr bound))))
	    (setq child (monkey-node-lexical--create :name thing
						     :start (car bound)
						     :end (cdr bound))))))))

(cl-defmethod monkey-node-last-child ((node monkey-lexical-node))
  (save-mark-and-excursion
    (let ((name (monkey-node-name node))
	  (start (monkey-node-start node))
	  (end (monkey-node-end node))
	  child)
      (cl-dolist (thing monkey-node-lexical-hierarchical-list child)
	(if (eq name thing)
	    (cl-return child))
	(goto-char end)
	(cl-flet ((check ()
		    (if-let ((bound (bounds-of-thing-at-point thing))
			     ((<= start (car bound)))
			     ((>= end (cdr bound))))
			bound)))
	  (if-let (bound (or (check) (progn (forward-thing thing -1) (check))))
	      (setq child (monkey-node-lexical--create :name thing
						       :start (car bound)
						       :end (cdr bound)))))))))

(provide 'monkey-lexical)
