;;; init.el --- Vanilla Emacs Config -*- lexical-binding: t -*-

(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-general) ; this must be loaded first
(require 'init-evil)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(blink-cursor-mode 0)
(setq make-backup-files nil)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq initial-major-mode 'text-mode)

;; HACK: https://github.com/minad/consult/discussions/853
(require 'display-line-numbers)
(defun display-line-numbers--turn-on ()
  "Turn on `display-line-numbers-mode'."
  (unless (or (minibufferp) (eq major-mode 'pdf-view-mode))
    (display-line-numbers-mode)))
(setq display-line-numbers-type 'relative)

(global-display-line-numbers-mode 1)
(setq suggest-key-bindings nil)
(setq native-comp-async-report-warnings-errors nil)
(setq auto-save-default t)
(setq select-enable-clipboard t)
(setq echo-keystrokes 0.1)
(setq read-process-output-max (* 1024 1024)
      gc-cons-threshold 100000000)
(setq native-comp-async-report-warnings-errors nil)
(byte-compile-disable-warning 'obsolete)
(setq ad-redefinition-action 'accept)
(setq suggest-key-bindings nil)
(save-place-mode 1)
(global-auto-revert-mode 1)
(setq ring-bell-function 'ignore)
(setq-default indent-tabs-mode nil
              tab-width 4
              c-basic-offset 4 ;; reset in init-langs.el
              c-default-style "linux"
              fill-column 70
              word-wrap t
              truncate-lines t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(dirvish org-draw))
 '(package-vc-selected-packages
   '((org-draw :url "https://github.com/larrasket/org-draw")
     (edraw :url "https://github.com/misohena/el-easydraw")
     (dirvish :url "https://github.com/latiagertrutis/dirvish" :rev
              :newest :lisp-dir ".")
     (yellowbeans-theme :url
                        "https://github.com/bvtuhan/yellowbeans-theme-emacs"))))

;; theme
(use-package yellowbeans-theme
  :vc (:url "https://github.com/bvtuhan/yellowbeans-theme-emacs"
            :rev :newest)
  :config
  (load-theme 'yellowbeans t))

;; font
(defun my/set-font ()
  "Changing the font yeah."
  (if (find-font (font-spec :family "Iosevka Fixed"))
      (set-face-attribute 'default nil :family "Iosevka Fixed" :height 120)
    (set-face-attribute 'default nil :family "monospace" :height 120)))

(my/set-font)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(with-eval-after-load 'project
  (add-to-list 'project-vc-extra-root-markers "Cargo.toml"))

(require 'init-completion)
(require 'init-dape)
(require 'init-dired)
(require 'init-doom-modeline)
(require 'init-eglot)
;; (require 'init-lsp-mode)
(require 'init-evil)
(require 'init-flycheck)
(require 'init-general)
(require 'init-hl-todo)
(require 'init-langs) ;; goto this file to enable/disable languages
(require 'init-misc)
(require 'init-org)
(require 'init-remote)
(require 'init-spellcheck)

(when (eq system-type 'windows-nt)
  (require 'init-windows))

(provide 'init)
;;; init.el ends here
