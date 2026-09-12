;;; init-hl-todo.el --- Custom hl-todo setup -*- lexical-binding: t -*-

(use-package hl-todo
  :hook ((prog-mode . hl-todo-mode)
         (markdown-mode . hl-todo-mode)
         (org-mode . hl-todo-mode)
         (LaTeX-mode . hl-todo-mode))
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(
          ("TODO" warning bold)
          ("MEMORIZE" warning bold)
          ("WIP" font-lock-keyword-face bold)
          ("REVIEW" font-lock-keyword-face bold)
          ("NOTSURE" font-lock-keyword-face bold)
          ("NOTE" success bold)
          ("SOLUTION" success bold)
          ("GOOD" success bold)
          ("XXX" font-lock-constant-face bold)
          ("HACK" font-lock-constant-face bold)
          ("TRICK" font-lock-constant-face bold)
          ("DEPRECATED" font-lock-doc-face bold)
          ("DELETEME" error bold)
          ("PROBLEM" error bold)
          ("BAD" error bold)
          ("KILLME" error bold)
          ("BUG" error bold)
          ("FIXME" error bold)))
  (global-hl-todo-mode 1))

(provide 'init-hl-todo)
;;; init-hl-todo.el ends here
