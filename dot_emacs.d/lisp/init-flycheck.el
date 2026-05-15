;;; init-flycheck.el --- Flycheck as main checker -*- lexical-binding: t -*-

(use-package flycheck
  :ensure t
  :hook
  (prog-mode . flycheck-mode)
  :bind
  (:map flycheck-mode-map
        ("M-n" . flycheck-next-error)
        ("M-p" . flycheck-previous-error))
  :custom
  (flycheck-check-syntax-automatically '(save mode-enabled))
  :config
  (my/leader-keys
    "c w" '(delete-trailing-whitespace :which-key "Delete trailing whitespace")
    "c x" '(flycheck-list-errors :which-key "List errors")))

(use-package flycheck-posframe
  :ensure t
  :after flycheck
  :hook
  (flycheck-mode . flycheck-posframe-mode))

(use-package flycheck-eglot
  :ensure t
  :after (flycheck eglot)
  :config
  (global-flycheck-eglot-mode 1))

(provide 'init-flycheck)
;;; init-flycheck.el ends here
