;;; init-clojure.el --- Clojure setup -*- lexical-binding: t -*-

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

(provide 'init-clojure)
;;; init-clojure.el ends here
