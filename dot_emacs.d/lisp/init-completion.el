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
  (electric-pair-inhibit-predicate
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

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

;; keybindings are defined in `init-general.el'
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
  (global-corfu-mode 1))

(use-package corfu-popupinfo
  :after corfu
  :ensure nil
  :hook (corfu-mode . corfu-popupinfo-mode)
  :custom
  (corfu-popupinfo-delay '(0.25 . 0.1))
  (corfu-popupinfo-hide nil)
  :config
  (corfu-popupinfo-mode))

(use-package corfu-terminal
  :if (not (display-graphic-p))
  :ensure t
  :config
  (corfu-terminal-mode))

;; for some reason, this will stay within this file
(use-package eshell
  :ensure nil
  :hook
  (eshell-mode . corfu-mode)
  :custom
  (eshell-scroll-to-bottom-on-input t)
  (eshell-kill-processes-on-exit t))

;;             UI
;;              │
;;            Corfu
;;              │
;;              ▼
;; completion-at-point-functions
;;              │
;;    ┌─────────┼──────────┐
;;    ▼         ▼          ▼
;;  Eglot    cape-file  cape-dabbrev
;;    │
;;    ▼
;;   LSP
;; completion-at-point-functions
(use-package cape
  :custom
  (cape-dabbrev-buffer-function #'current-buffer)
  :init
  (defun custom/latex-completion-setup ()
    (add-hook 'completion-at-point-functions #'cape-file 80 t)
    (add-hook 'completion-at-point-functions #'cape-tex 90 t))

  (defun custom/prog-completion-setup ()
    (add-hook 'completion-at-point-functions #'cape-file 80 t)
    (add-hook 'completion-at-point-functions #'cape-dabbrev 90 t))

  (defun custom/sly-completion-setup ()
    (setq-local completion-at-point-functions
                (list
                 #'sly-complete-filename-maybe
                 (cape-capf-super
                  #'sly-complete-symbol
                  #'cape-dabbrev))))

  (add-hook 'LaTeX-mode-hook #'custom/latex-completion-setup)
  (add-hook 'prog-mode-hook #'custom/prog-completion-setup)
  (add-hook 'sly-mode-hook #'custom/sly-completion-setup t)
  :config
  (with-eval-after-load 'eglot
    (advice-add #'eglot-completion-at-point
                :around #'cape-wrap-nonexclusive)))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides
   '((file (styles partial-completion)))))

(provide 'init-completion)
;;; init-completion.el ends here
