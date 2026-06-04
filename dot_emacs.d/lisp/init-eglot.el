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
  (eglot-send-changes-idle-time 0.1)
  (eglot-extend-to-xref t)
  (eglot-confirm-server-edits '((eglot-rename . nil)
                                (t . diff)))
  :config
  (fset #'jsonrpc--log-event #'ignore)

  ;; custom lsp binaries
  (add-to-list 'eglot-server-programs
               '((zig-mode zig-ts-mode) . ("zls")))

  ;; custom settings for lsp
  (setq eglot-workspace-configuration
        '(:rust-analyzer
          (:completion (:autoimport (:enable t))
                       :inlayHints (:enable t)
                       :cargo (:checkOnSave t))))

  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (setq-local eldoc-documentation-strategy
                          #'eldoc-documentation-compose)
              (eglot-inlay-hints-mode 1)))

  (my/leader-keys
    "c"   '(:ignore t :which-key "code")

    "ca" '(eglot-code-actions :which-key "LSP execute code action")
    "cr" '(eglot-rename :which-key "LSP rename")
    "cf" '(eglot-format :which-key "Format buffer/region")

    "cd" '(xref-find-definitions :which-key "Jump to definition")
    "cD" '(xref-find-references :which-key "Jump to references")
    "ci" '(eglot-find-implementation :which-key "Find implementations")
    "ck" '(eldoc-doc-buffer :which-key "Jump to documentation")

    "cc" '(compile :which-key "Compile")
    "cC" '(recompile :which-key "Recompile")
    "cw" '(delete-trailing-whitespace :which-key "Delete trailing whitespace")
    "cx" '(flycheck-list-errors :which-key "List errors"))


  (general-nmap
    :states 'motion
    "gr" #'xref-find-references
    "gd" #'xref-find-definitions
    "gi" #'eglot-find-implementation
    "K"  #'eldoc-doc-buffer))

(provide 'init-eglot)
