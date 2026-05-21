;;; init-markdown.el --- Markdown setup -*- lexical-binding: t -*-

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init
  (setq markdown-command "multimarkdown")
  :hook ((markdown-mode . (lambda ()
                            (visual-line-mode)
                            (setq-local indent-tabs-mode nil)
                            (setq-local fill-column 80)
                            (setq-local comment-fill-column 80)
                            (auto-fill-mode 1))))
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do)))

(provide 'init-markdown)
;;; init-markdown.el ends here
