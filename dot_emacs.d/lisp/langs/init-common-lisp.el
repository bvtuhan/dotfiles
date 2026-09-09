;;; init-common-lisp.el --- Common Lisp setup -*- lexical-binding: t -*-

(use-package sly
  :ensure t
  :hook ((lisp-mode . sly-editing-mode)
         (sly-mode . (lambda ()
                       (unless (sly-connected-p)
                         (sly)))))
  :custom
  (inferior-lisp-program "sbcl")
  (sly-auto-start 'always)
  (sly-kill-without-query-p t)
  (sly-net-coding-system 'utf-8-unix)
  (sly-complete-symbol-function #'sly-flex-completions)
  (sly-mrepl-history-file-name
   (expand-file-name "sly-mrepl-history"
                     user-emacs-directory))
  (sly-mrepl-prevent-duplicate-history 'move)
  (sly-db-focus-debugger 'auto)
  :bind
  (:map sly-mode-map
        ("C-c C-z" . sly-mrepl)
        ("C-c C-c" . sly-compile-defun)
        ("C-c C-k" . sly-compile-and-load-file)
        ("C-c C-e" . sly-eval-last-expression)
        ("C-c C-r" . sly-eval-region)
        ("C-c C-d d" . sly-describe-symbol)
        ("C-c C-d a" . sly-arglist)
        ("M-." . sly-edit-definition)
        ("M-," . sly-pop-find-definition-stack))

  :config
  (sly-symbol-completion-mode -1))

(provide 'init-common-lisp)
;;; init-common-lisp.el ends here
