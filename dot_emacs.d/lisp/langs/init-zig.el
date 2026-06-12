;;; init-zig.el --- Description -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package zig-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.\\(zig\\|zon\\)\\'" . zig-mode)))


(provide 'init-zig)
;;; init-zig.el ends here
