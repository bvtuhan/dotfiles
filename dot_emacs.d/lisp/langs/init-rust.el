;;; init-rust.el --- Rust setup -*- lexical-binding: t -*-

;; https://github.com/emacs-rustic/rustic#tree-sitter
(use-package rustic
  :ensure t
  :after rust-mode
  :custom
  (rustic-cargo-use-last-stored-arguments t)
  :config
  (setq rustic-lsp-setup-p nil
        rustic-format-on-save nil
        rustic-cargo-bin "cargo"
        rustic-cargo-bin-remote "/usr/bin/cargo"
        rustic-lsp-client nil)
  (remove-hook 'rustic-mode-hook #'rustic-setup-lsp)
  (with-eval-after-load 'flycheck
    (push 'rustic-clippy flycheck-checkers)))

(provide 'init-rust)
;;; init-rust.el ends here
