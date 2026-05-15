;;; init-langs.el --- Custom language setup -*- lexical-binding: t -*-

;; Notes for language specific configurations:
;; 1. ':hook (X-mode . eglot-ensure)' or `(x-ts-mode . eglot-ensure)'
;;    autostarts the lsp in buffer. Avoid it.
;; 2. For custom languages that eglot does not have out-of-box
;;    support, you have to edit :config in 'init-eglot.el':
;;      (add-to-list 'eglot-server-programs
;;                   '((zig-mode zig-ts-mode) . ("zls"))))
;; 3. To be able to replace your custom buffer-mode (eg. external
;;    zig tree sitter, you have to replace the default buffer mode
;;    that emacs utilizes:
;;    (use-package zig-ts-mode
;;     :config (add-to-list 'auto-mode-alist '("\\.zig\\'" . zig-ts-mode)))

(use-package treesit
  :ensure nil
  :when (treesit-available-p)
  :custom
  (treesit-font-lock-level 4)
  :config
  (add-to-list 'treesit-extra-load-path
               (expand-file-name "tree-sitter/" user-emacs-directory))

  ;; Extra grammar sources not always built in.
  (setq treesit-language-source-alist
        '((bash       "https://github.com/tree-sitter/tree-sitter-bash")
          (c          "https://github.com/tree-sitter/tree-sitter-c")
          (zig        "https://github.com/tree-sitter-grammars/tree-sitter-zig" "master" "src")
          (cpp        "https://github.com/tree-sitter/tree-sitter-cpp")
          (css        "https://github.com/tree-sitter/tree-sitter-css")
          (go         "https://github.com/tree-sitter/tree-sitter-go")
          (html       "https://github.com/tree-sitter/tree-sitter-html")
          (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
          (json       "https://github.com/tree-sitter/tree-sitter-json")
          (python     "https://github.com/tree-sitter/tree-sitter-python")
          (rust       "https://github.com/tree-sitter/tree-sitter-rust")
          (toml       "https://github.com/tree-sitter/tree-sitter-toml")
          (tsx        "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
          (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
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

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :hook ((markdown-mode . (lambda ()
                            (setq-local indent-tabs-mode nil)
                            (setq-local fill-column 80)
                            (setq-local comment-fill-column 80))))
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do)))


;; Hook example
;; :hook ((prog-mode . hl-todo-mode)
;;        (markdown-mode . hl-todo-mode)
;;        (org-mode . hl-todo-mode)
;;        (some-mode-hook . hl-todo-mode))

(use-package rust-mode
  :ensure t
  :init
  (setq rust-mode-treesitter-derive t))

;; https://github.com/emacs-rustic/rustic#tree-sitter
(use-package rustic
  :ensure t
  :after (rust-mode)
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

;; init
(with-eval-after-load 'elisp-mode
  ;; binds
  (define-key emacs-lisp-mode-map (kbd "C-c C-c") #'elisp-eval-region-or-buffer)

  ;; hook (runs everytime)
  (add-hook 'emacs-lisp-mode-hook (lambda ()
                                    (setq-local indent-tabs-mode nil)
                                    (setq-local fill-column 80)
                                    (setq-local comment-fill-column 80)
                                    (eldoc-mode 1)
                                    (setq-local lexical-binding t)))
  ;; config (runs once)

  (my/leader-keys
    :keymaps 'emacs-lisp-mode-map
    "c e" '(elisp-eval-region-or-buffer)))

(use-package zig-ts-mode
  :vc (:url "https://codeberg.org/meow_king/zig-ts-mode"
            :rev :newest)
  :config
  (add-to-list 'auto-mode-alist '("\\.zig\\'" . zig-ts-mode)))

(with-eval-after-load 'python-ts-moded
  (setq python-indent-offset 4))

(use-package autoinsert
  :ensure nil
  :init
  (auto-insert-mode 1)
  :config
  (setq auto-insert-query nil)
  (defun my/title-from-file-name (file-name)
    "Convert FILE-NAME into a nice Org title."
    (string-join
     (mapcar #'capitalize
             (split-string
              (file-name-sans-extension file-name)
              "[-_]+" t))
     " "))

  (define-auto-insert
    "\\.org\\'"
    (lambda ()
      (let* ((file-name (file-name-nondirectory buffer-file-name))
             (title (my/title-from-file-name file-name)))
        (insert
         "#+title: " title "\n"
         "#+author:    bvtuhan\n"
         "#+email:     jjackson.stormm@gmail.com\n"))))

  (define-auto-insert
    "\\.el\\'"
    (lambda ()
      (let* ((file-name (file-name-nondirectory buffer-file-name))
             (feature-name (file-name-sans-extension file-name)))
        (insert
         ";;; " file-name " --- Description -*- lexical-binding: t; -*-\n\n"
         ";;; Commentary:\n\n"
         ";;; Code:\n\n"
         "\n"
         "(provide '" feature-name ")\n"
         ";;; " file-name " ends here\n")))))

(provide 'init-langs)
