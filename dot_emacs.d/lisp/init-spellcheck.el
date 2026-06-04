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
  "Enable English spellchecking."
  (interactive)
  (setq-local jinx-languages "en_US")
  (setq-local ispell-complete-word-dict custom/en-wordlist)
  (when (bound-and-true-p jinx-mode)
    (jinx--load-dicts)
    (jinx--cleanup))
  (message "Welcome"))

;; sudo pacman -S hunspell-de
(defun switch-ger ()
  "Enable German spellchecking."
  (interactive)
  (setq-local jinx-languages "de_DE")
  (setq-local ispell-complete-word-dict custom/de-wordlist)
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
   (gfm-mode . jinx-mode)
   (jinx-mode . switch-eng))
  :bind
  (("M-$" . jinx-correct))
  :config
  (with-eval-after-load 'evil
    (evil-global-set-key 'normal (kbd "z=") #'jinx-correct)))

(provide 'init-spellcheck)
