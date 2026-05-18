;;; init-common-lisp.el --- Common Lisp setup -*- lexical-binding: t -*-

(use-package sly
  :ensure t
  :init
  (setq inferior-lisp-program "sbcl")
  :hook ((lisp-mode . sly-editing-mode)
         (sly-mode . (lambda ()
                       (unless (sly-connected-p)
                         (save-window-excursion
                           (sly)))))
         (sly-mode . eldoc-mode))
  :bind (:map sly-mode-map
              ("C-c C-z" . sly)
              ("C-c C-c" . sly-compile-defun)
              ("C-c C-k" . sly-compile-and-load-file)
              ("C-c C-e" . sly-eval-last-expression)
              ("C-c C-r" . sly-eval-region))
  :config
  (setq sly-mrepl-history-file-name
        (expand-file-name "sly-mrepl-history" user-emacs-directory)
        sly-kill-without-query-p t
        sly-net-coding-system 'utf-8-unix
        sly-complete-symbol-function 'sly-simple-completions))

(provide 'init-common-lisp)
;;; init-common-lisp.el ends here
