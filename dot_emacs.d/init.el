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
 '(package-selected-packages nil)
 '(package-vc-selected-packages
   '((yellowbeans-theme :url
                        "https://github.com/bvtuhan/yellowbeans-theme-emacs"))))

;; theme
(use-package yellowbeans-theme
  :vc (:url "https://github.com/bvtuhan/yellowbeans-theme-emacs"
            :rev :newest)
  :config
  (load-theme 'yellowbeans t))

;; font
(defun my/set-font ()
  (if (find-font (font-spec :family "Iosevka Fixed"))
      (set-face-attribute 'default nil :family "Iosevka Fixed" :height 130)
    (set-face-attribute 'default nil :family "monospace" :height 130)))

(my/set-font)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package ace-window)

;; formatter
(add-hook 'before-save-hook #'delete-trailing-whitespace)
(use-package apheleia
  :ensure t
  :config
  (setf (alist-get 'clang-format apheleia-formatters)
        '("clang-format" "--style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never}"))
  (apheleia-global-mode +1))

;;; spell checker
;; sudo pacman -S enchant hunspell hunspell-en_us words pkgconf hunspell-de

;; let cape uses custom directory
(defun find-first-custom-dir (&rest files)
  "returns the first dictionary file"
  (seq-find #'file-readable-p files))

;; TODO: Add here Windows dir
(defvar custom/en-wordlist
  (find-first-custom-dir
   "/usr/share/dict/american-english"
   "/usr/share/dict/usa"
   "/usr/share/dict/words"
   "/usr/dict/words"))

;; TODO: Add here Windows dir
(defvar custom/de-wordlist
  (find-first-custom-dir
   "/usr/share/dict/ngerman"
   "/usr/share/dict/german"
   "/usr/share/dict/de_DE"
   "/usr/share/dict/words"))
(setq-default cape-dict-file custom/en-wordlist)

;; NOTE: Jinx uses hunspell backend.
;; It has nothing to do with the
;; custom dictionaries defined above.
(defun switch/eng ()
  (interactive)
  (setq-local jinx-languages "en_US")
  (setq-local cape-dict-file custom/en-wordlist)
  (when (bound-and-true-p jinx-mode)
    (jinx--load-dicts)
    (jinx--cleanup))
  (message "Welcome"))

;; sudo pacman -S hunspell-de
(defun switch/ger ()
  (interactive)
  (setq-local jinx-languages "de_DE")
  (setq-local cape-dict-file custom/de-wordlist)
  (when (bound-and-true-p jinx-mode)
    (jinx--load-dicts)
    (jinx--cleanup))
  (message "Willkommen"))

(use-package jinx
  :ensure t
  :hook
  ((prog-mode . jinx-mode)
   (org-mode . jinx-mode)
   (latex-mode . jinx-mode)
   (LaTeX-mode . jinx-mode)
   (markdown-mode . jinx-mode)
   (gfm-mode . jinx-mode))
  :bind
  (("M-$" . jinx-correct))
  :config
  (with-eval-after-load 'evil
    (evil-global-set-key 'normal (kbd "z=") #'jinx-correct)))



(require 'init-org)
(require 'init-dired)
(require 'init-completion)
(require 'init-doom-modeline)
(require 'init-hl-todo)
(require 'init-flycheck)
(require 'init-eglot)
(require 'init-langs)
(require 'init-dape)
(require 'init-misc)

(provide 'init)
;;; init.el ends here
