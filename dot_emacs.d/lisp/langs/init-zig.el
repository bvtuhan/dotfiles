;;; init-zig.el --- Zig setup -*- lexical-binding: t -*-

(use-package zig-ts-mode
  :vc (:url "https://codeberg.org/meow_king/zig-ts-mode"
            :rev :newest)
  :config
  ;; You could also use :mode here.
  (add-to-list 'auto-mode-alist '("\\.zig\\'" . zig-ts-mode)))

(provide 'init-zig)
;;; init-zig.el ends here
