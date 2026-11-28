;;; init-eglot.el --- Custom eglot setup -*- lexical-binding: t -*-

;; Notes for eglot
;; 1. For custom languages that eglot does not have out-of-box
;;    support, you have to edit :config in 'init-eglot.el':
;;      (add-to-list 'eglot-server-programs
;;                   '((zig-mode zig-ts-mode) . ("zls"))))
;;    Note that you have to create separate 'add-to-list' for
;;    each individual binary.

(use-package eglot
  :ensure nil
  :commands
  (eglot
   eglot-ensure
   eglot-shutdown
   eglot-reconnect
   eglot-code-actions
   eglot-rename
   eglot-format
   eglot-format-buffer)

  :custom
  (eglot-autoshutdown nil)
  (eglot-sync-connect nil)
  (eglot-events-buffer-config '(:size 0 :format full))
  (eglot-send-changes-idle-time 0.1)
  (eglot-extend-to-xref t)
  (eglot-confirm-server-edits nil)

  :config
  (fset #'jsonrpc--log-event #'ignore)

  (setq eglot-semantic-token-modifiers
        (remove "static" eglot-semantic-token-modifiers))

  (setq eglot-ignored-server-capabilities
        (cons :documentOnTypeFormattingProvider
              eglot-ignored-server-capabilities))

  ;; custom lsp binaries
  (add-to-list 'eglot-server-programs
               '((zig-mode zig-ts-mode) . ("zls"))))


(provide 'init-eglot)
;;; init-eglot.el ends here
