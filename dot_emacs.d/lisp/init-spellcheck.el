;;; init-spellcheck.el --- Spellcheck Setup -*- lexical-binding: t -*-

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
   "~/.local/share/dict/en_US.words" ;; this should be for Windows
   "/usr/share/dict/words"
   "/usr/dict/words"))

(defvar custom/de-wordlist
  (find-first-custom-dir
   "/usr/share/dict/ngerman"
   "/usr/share/dict/german"
   "/usr/share/dict/de_DE"
   "~/.local/share/dict/de_DE.words" ;; this should be for Windows
   "/usr/share/dict/words"))

(setq-default cape-dict-file custom/en-wordlist)

;; NOTE: Jinx uses hunspell backend.
;; It has nothing to do with the
;; custom dictionaries defined above.
;; sudo pacman -S hunspell-en_us
(defun switch-eng ()
  "Switch spell checking and completion to English."
  (interactive)
  (setq-local ispell-complete-word-dict custom/en-wordlist)
  (jinx-languages "en_US")
  (message "Welcome"))

;; sudo pacman -S hunspell-de
(defun switch-ger ()
  "Switch spell checking and completion to German."
  (interactive)
  (setq-local ispell-complete-word-dict custom/de-wordlist)
  (jinx-languages "de_DE")
  (message "Willkommen"))

(use-package jinx
  :ensure t
  :custom
  (jinx-languages "en_US")
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

(provide 'init-spellcheck)
