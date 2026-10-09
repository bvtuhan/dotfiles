;;; init-flycheck.el --- Flycheck as main checker -*- lexical-binding: t -*-

(use-package flycheck
  :ensure t
  :hook
  (prog-mode . flycheck-mode)
  :bind
  (("M-n" . flycheck-next-error) ;; this is overwritten by sly
   ("M-N" . flycheck-previous-error))
  :custom
  (flycheck-check-syntax-automatically '(save mode-enabled))
  :config
  (global-flycheck-eglot-mode 1))

(use-package flycheck-posframe
  :ensure t
  :after flycheck
  :hook
  (flycheck-mode . flycheck-posframe-mode)
  :config
  (with-eval-after-load 'evil
    (evil-define-key 'normal flycheck-mode-map
      (kbd "g h") #'flycheck-display-error-at-point)))

(provide 'init-flycheck)
;;; init-flycheck.el ends here
