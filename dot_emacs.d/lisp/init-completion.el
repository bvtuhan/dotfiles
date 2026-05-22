;;; init-completion.el --- Custom completion setup -*- lexical-binding: t -*-

;; Notes
;; We are using Corfu + Cape + CAPF (all my homies hate `company')
;; Main completion hook is:
;; `(add-hook 'completion-at-point-functions #'X-complete-at-point DEPTH(t/nil) LOCAL(t/nil))'
;; Some languages like common-lisp and clojure provide at-point completion without
;; any lsp requirement. You can directly hook `completion-at-point-functions' within
;; the corresponding package. For instance (see `init-langs.el'):
;; (use-package cider
;;   :ensure t
;;   :after clojure-ts-mode
;;   :hook ((clojure-ts-mode . cider-mode)
;;          (cider-mode . eldoc-mode)
;;          (cider-mode . (lambda ()
;;                          (add-hook 'completion-at-point-functions
;;                                    #'cider-complete-at-point
;;                                    nil
;;                                    t)))
;;          (cider-repl-mode . eldoc-mode))

(use-package electric
  :ensure nil
  :init
  (electric-pair-mode 1)
  :custom
  (electric-pair-delete-adjacent-pairs t)
  (show-paren-delay 0)
  :config
  (setq electric-pair-inhibit-predicate
        (lambda (char)
          (or (minibufferp)
              (electric-pair-default-inhibit char)))))

(use-package yasnippet
  :init
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :after yasnippet)

(use-package vertico
  :init
  (vertico-mode 1)
  :general
  (:keymaps 'vertico-map
            "C-j" #'vertico-next
            "C-k" #'vertico-previous)
  :custom
  (vertico-resize nil)
  (vertico-count 17)
  (vertico-cycle t)
  :config
  (require 'vertico-directory)
  (define-key vertico-map (kbd "DEL") #'vertico-directory-delete-char)
  (define-key vertico-map (kbd "<backspace>") #'vertico-directory-delete-char)
  (define-key vertico-map (kbd "M-DEL") #'vertico-directory-delete-word)
  (add-hook 'rfn-eshadow-update-overlay-hook #'vertico-directory-tidy))

(use-package savehist
  :ensure nil
  :init
  (savehist-mode 1))

(use-package consult)

(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.1)
  (corfu-quit-at-boundary t)
  (corfu-quit-no-match t)
  (corfu-preview-current nil)
  (corfu-preselect 'prompt)
  :init
  (global-corfu-mode 1)
  :config
  (corfu-popupinfo-mode 1)
  (setq corfu-popupinfo-delay 0.5
        tab-always-indent 'complete)
  (general-define-key
   :keymaps 'corfu-map
   "C-j"      #'corfu-next
   "C-k"      #'corfu-previous
   "<escape>" #'corfu-quit
   "RET"      #'corfu-insert
   "TAB"      #'corfu-insert
   "<tab>"    #'corfu-insert))

(defun custom/latex-setup ()
  (add-hook 'completion-at-point-functions #'cape-file t t)
  (add-hook 'completion-at-point-functions #'cape-tex t t))

(defun custom/prog-completion-setup ()
  (add-hook 'completion-at-point-functions #'cape-file t t)
  (add-hook 'completion-at-point-functions #'cape-dabbrev t t))

;; completion-at-point-functions
(use-package cape
  :init
  (add-hook 'LaTeX-mode-hook #'custom/latex-setup)
  (add-hook 'prog-mode-hook #'custom/prog-completion-setup)
  ;; Testing cape-dict
  ;; (add-hook 'text-mode-hook
  ;;           (lambda ()
  ;;             (remove-hook 'completion-at-point-functions
  ;;                          #'ispell-completion-at-point
  ;;                          t)
  ;;             (add-hook 'completion-at-point-functions #'cape-dict t t)
  ;;             (add-hook 'completion-at-point-functions #'cape-dabbrev t t)))
  ;; nah, ispell-completion-at-point is at finest
  )


(use-package undo-fu
  :after evil
  :custom
  (undo-limit 6710886400)
  (undo-strong-limit 100663296)
  (undo-outer-limit 1006632960))

(use-package undo-fu-session
  :after undo-fu
  :init
  (undo-fu-session-global-mode 1)
  :custom
  (undo-fu-session-incompatible-files
   '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'")))

(use-package vundo
  :custom
  (vundo-compact-display t))

(provide 'init-completion)
;;; init-completion.el ends here
