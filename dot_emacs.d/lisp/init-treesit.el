;;; init-treesit.el --- Tree-sitter setup -*- lexical-binding: t -*-

(use-package treesit
  :ensure nil
  :when (treesit-available-p)
  :custom
  (treesit-font-lock-level 4)
  :config
  (add-to-list 'treesit-extra-load-path
               (expand-file-name "tree-sitter/" user-emacs-directory))
  (setq treesit-language-source-alist
        '((bash       "https://github.com/tree-sitter/tree-sitter-bash")
          (c          "https://github.com/tree-sitter/tree-sitter-c")
          (zig        "https://github.com/tree-sitter-grammars/tree-sitter-zig" "master" "src")
          (cpp        "https://github.com/tree-sitter/tree-sitter-cpp")
          (go         "https://github.com/tree-sitter/tree-sitter-go")
          (json       "https://github.com/tree-sitter/tree-sitter-json")
          (python     "https://github.com/tree-sitter/tree-sitter-python")
          (rust       "https://github.com/tree-sitter/tree-sitter-rust")
          (toml       "https://github.com/tree-sitter/tree-sitter-toml")
          (yaml       "https://github.com/ikatyang/tree-sitter-yaml"))))

(use-package treesit-auto
  :ensure t
  :after treesit
  :when (treesit-available-p)
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode 1))

(setq c-basic-offset 4)
(setq c-ts-mode-indent-offset 4)

(provide 'init-treesit)
;;; init-treesit.el ends here
