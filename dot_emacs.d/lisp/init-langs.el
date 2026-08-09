;;; init-langs.el --- Load language setup -*- lexical-binding: t -*-

;; Notes for language specific configurations:
;; 1. ':hook (X-mode . eglot-ensure)' or `(x-ts-mode . eglot-ensure)'
;;    autostarts the lsp in buffer. Avoid it.
;; 2. For custom languages that eglot does not have out-of-box
;;    support, you have to edit :config in 'init-eglot.el':
;;      (add-to-list 'eglot-server-programs
;;                   '((zig-mode zig-ts-mode) . ("zls"))))
;; 3. To be able to replace your custom buffer-mode, replace the
;;    default buffer mode that Emacs utilizes:
;;    (use-package zig-ts-mode
;;      :config
;;      (add-to-list 'auto-mode-alist '("\\.zig\\'" . zig-ts-mode)))

(add-to-list 'load-path (expand-file-name "lisp/langs" user-emacs-directory))

(require 'init-markdown)
(require 'init-rust)
(require 'init-elisp)
(require 'init-common-lisp)
(require 'init-tex)
(require 'init-zig)
(require 'init-hdl)

(provide 'init-langs)
;;; init-langs.el ends here
