;;For installing some require packages
(require 'require-package)

;;add flake8 and jedi
(require-package 'python-environment)
(require-package 'company-jedi)
(require 'flycheck-recipe)

(defun python-set-dev-venv ()
  "set buffer local varibale that describe virtual environment
   that will use for install development dependences"
  (interactive)
  (require 'python-environment)
  (let* ((python-version (shell-command-to-string "python --version"))
         (start (string-match "\\([[:digit:]]+.[[:digit:]]+\\)" python-version))
         (ver (match-string 0 python-version)))
    (setq-local python-environment-default-root-name ver)
    (setq-local jedi:environment-root ver))
  (setq-local flycheck-python-flake8-executable
              (python-environment-bin "flake8"))
  (when (fboundp 'jedi:stop-server)
    (jedi:stop-server)))

(defun python-install-dev-deps ()
  "install development dependences in the
   development virtual environment"
  (interactive)
  (python-set-dev-venv)
  (unless (python-environment-exists-p)
    (python-environment-make-block
     nil
     (append
      python-environment-virtualenv
      (list "--python" (executable-find "python")))))
  (jedi:install-server-block)
  (python-environment-run-block
   (list "pip" "install" "--upgrade" "flake8"))
  (python-set-dev-venv))

(add-hook 'python-mode-hook
          (lambda ()
            (python-set-dev-venv)
            (add-to-list (make-local-variable 'company-backends) 'company-jedi)
            (flycheck-mode)))

;;add virtual environment support
(require-package 'pyvenv)
(add-hook 'pyvenv-post-activate-hooks 'python-set-dev-venv)
(add-hook 'pyvenv-post-deactivate-hooks 'python-set-dev-venv)

(provide 'python-mode-recipe)
