;;; init-rust.el --- Rust setup -*- lexical-binding: t -*-

(use-package rust-mode
  :ensure t
  :init
  (setq rust-mode-treesitter-derive t))

;; https://github.com/emacs-rustic/rustic#tree-sitter
(use-package rustic
  :ensure t
  :after rust-mode
  :config
  (setq rustic-lsp-setup-p nil
        rustic-format-on-save nil
        rustic-cargo-bin "cargo"
        rustic-lsp-client nil)
  (remove-hook 'rustic-mode-hook #'rustic-setup-lsp)
  (with-eval-after-load 'flycheck
    (push 'rustic-clippy flycheck-checkers))
  (add-hook 'rustic-mode-hook #'flycheck-mode)
  :custom
  (rustic-cargo-use-last-stored-arguments t))

(provide 'init-rust)
;;; init-rust.el ends here
