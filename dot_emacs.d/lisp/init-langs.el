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
               (expand-file-name "tree-sitter/" user-emacs-directory)))

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
;;  (prog-mode . hl-todo-mode) gets auto.
;;  extended to  (add-hook prog-mode-hook ...)
;; :hook ((prog-mode . hl-todo-mode)
;;        (markdown-mode . hl-todo-mode)
;;        (org-mode . hl-todo-mode)
;;        (some-mode. hl-todo-mode))

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


(use-package zig-ts-mode
  :vc (:url "https://codeberg.org/meow_king/zig-ts-mode"
            :rev :newest)
  :config
  ;; you could have used :mode (see clojure example)
  (add-to-list 'auto-mode-alist '("\\.zig\\'" . zig-ts-mode)))

;;; functional programming yeah

;; elisp
(with-eval-after-load 'elisp-mode
  ;; binds (global-set-key is also okay)
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

;; common-lisp
(use-package sly
  :ensure t
  :init
  (setq inferior-lisp-program "sbcl")
  :hook ((lisp-mode . sly-editing-mode)
         (sly-mode . (lambda ()
                       (unless (sly-connected-p)
                         (save-window-excursion (sly)))))
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

;; clojure
(use-package clojure-ts-mode
  :ensure t
  :mode (("\\.clj\\'"  . clojure-ts-mode)
         ("\\.cljs\\'" . clojure-ts-clojurescript-mode)
         ("\\.cljc\\'" . clojure-ts-clojurec-mode)
         ("\\.edn\\'"  . clojure-ts-mode)))

(use-package cider
  :ensure t
  :after clojure-ts-mode
  :hook ((clojure-ts-mode . cider-mode)
         (clojure-ts-clojurescript-mode . cider-mode)
         (clojure-ts-clojurec-mode . cider-mode)
         (cider-mode . eldoc-mode)
         (cider-repl-mode . eldoc-mode))
  :config
  (setq cider-repl-pop-to-buffer-on-connect 'display-only
        cider-preferred-build-tool 'clojure-cli
        cider-repl-display-help-banner nil
        cider-repl-use-pretty-printing t
        cider-repl-use-clojure-font-lock t
        cider-repl-result-prefix ";; => "
        cider-repl-history-file
        (expand-file-name "cider-repl-history" user-emacs-directory)
        cider-repl-history-size 1000
        cider-repl-wrap-history nil
        cider-print-options '(("length" 100))
        cider-font-lock-dynamically '(macro core function var deprecated)
        cider-overlays-use-font-lock t
        nrepl-hide-special-buffers t
        nrepl-log-messages nil
        cider-prompt-for-symbol nil
        cider-completion-annotations-include-ns 'always
        cider-stacktrace-default-filters '(tooling dup)))

(provide 'init-langs)
