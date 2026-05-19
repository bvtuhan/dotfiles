;;; init-elisp.el --- Emacs Lisp setup -*- lexical-binding: t -*-

(with-eval-after-load 'elisp-mode
  ;; Binds.
  ;; (define-key emacs-lisp-mode-map
  ;;             (kbd "C-c C-c")
  ;;             #'elisp-eval-region-or-buffer)

  ;; Hook.
  (add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (setq-local indent-tabs-mode nil)
              (setq-local fill-column 80)
              (setq-local comment-fill-column 80)
              (eldoc-mode 1)
              (setq-local lexical-binding t)))

  ;; Leader keys.
  ;; (my/leader-keys
  ;;   :keymaps 'emacs-lisp-mode-map
  ;;   "c e" '(elisp-eval-region-or-buffer))
  )

(provide 'init-elisp)
;;; init-elisp.el ends here
