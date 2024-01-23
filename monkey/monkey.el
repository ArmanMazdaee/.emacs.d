(require 'monkey-keymap)
(require 'monkey-command)

(define-key monkey-keymap-global-map
	    [escape] 'monkey-command-escape)

(monkey-keymap-bind command
  ("<escape>" . monkey-command-escape)
  ("SPC" . monkey-command-god-keys)
  ("`" . execute-extended-command)
  ("f" . monkey-command-backward)
  ("j" . monkey-command-forward)
  ("d" . monkey-command-upward)
  ("k" . monkey-command-first-downward)
  ("l" . monkey-command-last-downward)
  ("g" . monkey-command-insert)
  ("h" . monkey-command-append)
  (";" . monkey-command-exchange-point-and-mark)
  ("w" . monkey-command-jump-to-lexical-tree-word-node)
  ("e" . monkey-command-jump-to-lexical-tree-symbol-node)
  ("i" . monkey-command-jump-to-lexical-tree-line-node)
  ("b" . monkey-command-jump-to-lexical-tree-buffer-node))

(provide 'monkey)
