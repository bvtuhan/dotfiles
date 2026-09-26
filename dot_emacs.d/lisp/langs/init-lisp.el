;;; init-lisp.el --- Description -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; Use M-n (sbl-next-note for diagnostic)
(use-package sly
  :ensure t
  :hook ((lisp-mode . sly-editing-mode)
         (sly-mode . (lambda ()
                       (unless (sly-connected-p)
                         (sly)))))
  :bind
  (("M-N" . 'sly-previous-note))
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

(with-eval-after-load 'elisp-mode
  (setq elisp-flymake-byte-compile-load-path load-path)
  (setq-default
   apropos-do-all t)
  (setq lisp-indent-offset nil)
  (add-hook
   'emacs-lisp-mode-hook
   (lambda ()
     (setq-local indent-tabs-mode nil)
     (setq-local tab-width 8)
     (setq-local fill-column 80)
     (setq-local comment-fill-column 80)
     (setq-local lexical-binding t)
     (setq-local outline-regexp "[ \t]*;;;\\(;*\\**\\) [^ \t\n]")
     (setq-local outline-level
                 (lambda ()
                   (save-excursion
                     (looking-at outline-regexp)
                     (length (match-string 1)))))

     (eldoc-mode 1)
     (outline-minor-mode 1)
     (imenu-add-menubar-index)))
  (add-hook
   'lisp-interaction-mode-hook
   (lambda ()
     (setq-local indent-tabs-mode nil)
     (setq-local tab-width 8)
     (setq-local fill-column 80)
     (eldoc-mode 1)))

  (define-key emacs-lisp-mode-map (kbd "C-c C-b") #'eval-buffer)
  (define-key emacs-lisp-mode-map (kbd "C-c C-c") #'eval-defun)
  (define-key emacs-lisp-mode-map (kbd "C-c C-e") #'eval-last-sexp)
  (define-key emacs-lisp-mode-map (kbd "C-c C-r") #'eval-region)
  (define-key emacs-lisp-mode-map (kbd "C-c C-l") #'load-library)
  (define-key emacs-lisp-mode-map (kbd "C-c C-z") #'ielm)
  (define-key emacs-lisp-mode-map (kbd "C-c g f") #'find-function)
  (define-key emacs-lisp-mode-map (kbd "C-c g v") #'find-variable)
  (define-key emacs-lisp-mode-map (kbd "C-c g l") #'find-library)
  (define-key lisp-interaction-mode-map (kbd "C-c C-b") #'eval-buffer)
  (define-key lisp-interaction-mode-map (kbd "C-c C-c") #'eval-defun)
  (define-key lisp-interaction-mode-map (kbd "C-c C-e") #'eval-last-sexp)
  (define-key lisp-interaction-mode-map (kbd "C-c C-r") #'eval-region)
  (define-key lisp-interaction-mode-map (kbd "C-c C-z") #'ielm))

(provide 'init-lisp)
;;; init-lisp.el ends here
