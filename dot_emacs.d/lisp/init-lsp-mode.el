;;; init-lsp-mode.el --- Description -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; DEPRECATED: Currently using `eglot' (see `init-eglot.el')

(defun my/lsp-format-buffer-or-region ()
  (interactive)
  (if (use-region-p)
      (lsp-format-region (region-beginning) (region-end))
    (lsp-format-buffer)))

(defun my/lsp-mode-setup ()
  (setq-local eldoc-documentation-strategy
              #'eldoc-documentation-compose)
  (lsp-inlay-hints-mode 1))

(use-package lsp-mode
  :ensure t

  :hook
  ((zig-mode . lsp-deferred)
   (zig-ts-mode . lsp-deferred)
   (rust-mode . lsp-deferred)
   (rust-ts-mode . lsp-deferred)
   (lsp-mode . my/lsp-mode-setup))

  :init
  (setq lsp-keymap-prefix "C-c l"
        lsp-zig-zls-executable "zls"
        lsp-rust-analyzer-completion-auto-import-enable t
        lsp-rust-analyzer-cargo-watch-enable t)

  :custom
  (lsp-keep-workspace-alive t)
  (lsp-idle-delay 0.1) ;; change this 0.3 if it causes overhead
  (lsp-enable-xref t)
  (lsp-log-io nil)
  (lsp-log-max nil)
  (lsp-diagnostics-provider :flycheck)
  (lsp-inlay-hint-enable t)
  (lsp-completion-enable-additional-text-edit t)
  (lsp-completion-provider :none)
  (lsp-completion-enable t)

  :config
  (my/leader-keys
    "c"   '(:ignore t :which-key "code")

    "ca" '(lsp-execute-code-action
           :which-key "LSP execute code action")
    "cr" '(lsp-rename
           :which-key "LSP rename")
    "cf" '(my/lsp-format-buffer-or-region
           :which-key "Format buffer/region")

    "cd" '(xref-find-definitions
           :which-key "Jump to definition")
    "cD" '(xref-find-references
           :which-key "Jump to references")
    "ci" '(lsp-find-implementation
           :which-key "Find implementations")
    "ck" '(eldoc-doc-buffer
           :which-key "Jump to documentation")

    "cs" '(lsp-workspace-shutdown
           :which-key "Shutdown LSP server")
    "cR" '(lsp-workspace-restart
           :which-key "Restart LSP server")

    "cc" '(compile
           :which-key "Compile")
    "cC" '(recompile
           :which-key "Recompile")
    "cw" '(delete-trailing-whitespace
           :which-key "Delete trailing whitespace")
    "cx" '(flycheck-list-errors
           :which-key "List errors"))

  (general-nmap
    :states 'motion
    "gr" #'xref-find-references
    "gd" #'xref-find-definitions
    "gi" #'lsp-find-implementation
    "K"  #'eldoc-doc-buffer))

(provide 'init-lsp-mode)
;;; init-lsp-mode.el ends here
