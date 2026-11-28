;;; init.el --- Vanilla Emacs Config -*- lexical-binding: t -*-

(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (unless (package-read-all-archive-contents)
    (package-refresh-contents)))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-evil)
(require 'init-general)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(blink-cursor-mode 0)
(setq make-backup-files nil)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq initial-major-mode 'text-mode)
(setq find-file-visit-truename t) ;; follow always the actual target file

;; HACK: https://github.com/minad/consult/discussions/853
(defun my/enable-line-numbers ()
  "Turn on `display-line-numbers-mode' in editing buffers."
  (display-line-numbers-mode 1))

(setq display-line-numbers-type 'relative)
(dolist (hook '(prog-mode-hook text-mode-hook conf-mode-hook))
  (add-hook hook #'my/enable-line-numbers))

;; Runtime UI, scrolling, and IO optimizations
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t
      redisplay-skip-fontification-on-input t
      fast-but-imprecise-scrolling t
      auto-window-vscroll nil
      scroll-conservatively 101
      scroll-margin 0
      cursor-in-non-selected-windows nil
      highlight-nonselected-windows nil
      vc-handled-backends '(Git)
      auto-revert-check-vc-info nil)

;; Temporarily raise GC threshold in minibuffer to prevent Vertico/Consult stutters
(add-hook 'minibuffer-setup-hook
          (lambda () (setq gc-cons-threshold most-positive-fixnum)))
(add-hook 'minibuffer-exit-hook
          (lambda () (setq gc-cons-threshold (* 64 1024 1024))))

(setq suggest-key-bindings nil
      native-comp-async-report-warnings-errors nil
      auto-save-default t
      select-enable-clipboard t
      echo-keystrokes 0.1
      read-process-output-max (* 4 1024 1024)
      ad-redefinition-action 'accept)
(byte-compile-disable-warning 'obsolete)
(add-hook 'emacs-startup-hook
          (lambda ()
            (save-place-mode 1)
            (global-auto-revert-mode 1)))
(setq ring-bell-function 'ignore)
(setq c-default-style "linux"
      c-basic-offset 4)
(setq-default indent-tabs-mode nil
              tab-width 4
              fill-column 70
              word-wrap t
              truncate-lines t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ace-window adaptive-wrap apheleia cape centaur-tabs cider citar
                clojure-ts-mode consult copilot corfu-terminal crdt dape
                dired-sidebar dired-subtree diredfl dirvish doom-modeline edraw
                evil-collection evil-goggles evil-org evil-tex flycheck-eglot
                flycheck-posframe general hl-todo jinx marginalia orderless
                org-contrib org-download org-draw org-fragtog org-noter
                pdf-tools rustic sly undo-fu undo-fu-session uniline verilog-ext
                vertico vhdl-ext yasnippet-snippets yellowbeans-theme zig-mode))
 '(package-vc-selected-packages
   '((yellowbeans-theme :url "https://github.com/bvtuhan/yellowbeans-theme-emacs"))))

;; theme, to update, use `package-vc-upgrade'
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
(require 'init-flycheck)
(require 'init-hl-todo)
(require 'init-langs) ;; goto this file to enable/disable languages
(require 'init-misc)
(require 'init-org)
(require 'init-remote)
(require 'init-spellcheck)

(provide 'init)
;;; init.el ends here
