;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Includes
(load! "pconfig.el")

;; whoami
(setq user-full-name "bvtuhan"
      user-mail-address "jjackson.stormm@gmail.com")

;; default cc-mode smh
(setq c-basic-offset 4)
(setq c-ts-mode-indent-offset 4)

;; flycheck 
(global-flycheck-mode +1)

;; no start message
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq initial-major-mode 'text-mode)

;; quieter UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(blink-cursor-mode 0)
(setq display-line-numbers-type 'relative)

;; evil
(setq evil-insert-state-cursor 'box) 

;; behavior
(setq suggest-key-bindings nil)
(setq native-comp-async-report-warnings-errors nil)
(setq org-startup-with-inline-images t)
(setq auto-save-default t)
(setq select-enable-clipboard t)
(setq echo-keystrokes 0.1)

;; convenience
(save-place-mode 1)
(global-auto-revert-mode 1)

;; org
(add-hook 'org-mode-hook #'turn-on-auto-fill)
(add-hook 'org-mode-hook #'hl-todo-mode)
(setq org-directory "~/org/")
(setq org-agenda-files '("~/org/agenda.org"))
(setq org-latex-pdf-process
      '("latexmk -pdflua -interaction=nonstopmode -shell-escape -bibtex %f"))
(setq org-cite-export-processors
      '((latex biblatex)))
(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))

;; cite cheat sheet:
;; [cite:@alan1938]         ; \autocite{alan1938}
;; [cite/text:@alan1938]    ; \textcite{alan1938}
;; [cite/author:@alan1938]  ; \citeauthor{alan1938}
(add-to-list 'org-latex-classes
             '("article"
               "\\documentclass[11pt,a4paper]{article}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage[english]{babel}
\\usepackage{fixltx2e}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{rotating}
\\usepackage[normalem]{ulem}
\\usepackage{amsmath}
\\usepackage{textcomp}
\\usepackage{marvosym}
\\usepackage{wasysym}
\\usepackage{amssymb}
\\usepackage{hyperref}
\\usepackage{mathpazo}
\\usepackage{color}
\\usepackage{enumerate}
\\usepackage[inline]{enumitem}
\\definecolor{bg}{rgb}{0.95,0.95,0.95}
\\tolerance=1000
      [NO-DEFAULT-PACKAGES]
      [PACKAGES]
      [EXTRA]
\\linespread{1.1}
\\hypersetup{pdfborder=0 0 0}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")))

;; theme: https://github.com/bvtuhan/yellowbeans-theme-emacs
(setq doom-theme 'yellowbeans)

;; set default shell
(cond
 ((eq system-type 'windows-nt)
  (setq shell-file-name "powershell.exe"))
 (t
  (setq shell-file-name
        (or (executable-find "fish")
            (executable-find "bash")
            (executable-find "sh")))))

;; custom-font
(if (find-font (font-spec :family "Iosevka Fixed"))
    (setq doom-font (font-spec :family "Iosevka Fixed" :size 16))
  (setq doom-font (font-spec :family "monospace" :size 16)))

;; keybindings
(global-set-key (kbd "M-m") 'shell-command)
(map! "C-/" #'comment-dwim)
(after! pdf-view
  (map! :map pdf-view-mode-map
        :n "i" #'org-noter-insert-note))

;;; tramp remote ssh connection
(after! tramp
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
  (add-to-list 'tramp-remote-path "/home/debian/.cargo/bin"))

;;; eglot lsp

;; probably cargo-cult tweaks but anyway
(setq read-process-output-max (* 1024 1024)
      process-adaptive-read-buffering nil
      gc-cons-percentage 0.2
      gc-cons-threshold (* 100 1024 1024))

;; please do not autoload it in programming buffers
;; flycheck is adequate in most cases
(advice-add #'lsp! :override #'ignore)

;; rustic mode overwrites the default lsp settings,
;; need to explicitly disable the lsp
(after! rustic
  (setq rustic-lsp-setup-p nil
        rustic-cargo-bin "cargo"
        rustic-lsp-client nil)
  (remove-hook 'rustic-mode-hook #'rustic-setup-lsp)
  (add-hook 'rustic-mode-hook #'flycheck-mode)
  (with-eval-after-load 'flycheck
    (push 'rustic-clippy flycheck-checkers)))

;; some tweaks
;; note that eglot does not invent settings, 
;; it passes them directly to language servers.
(after! eglot
  (use-package! eglot-booster
    :config
    (setq eglot-booster-io-only t)
    (eglot-booster-mode 1))
  (setq eglot-autoshutdown nil
        eglot-workspace-configuration
        ;; for rust-analyzer see https://rust-analyzer.github.io/manual.html
        ;; "completion.autoimport.enable", "inlayHints", "cargo.checkOnSave"
        '(:rust-analyzer
          (:completion (:autoimport (:enable t))
           :inlayHints (:enable t)
           :cargo (:checkOnSave t))))

  ;; disable eglot semantic tokens, tree-sitter is sufficient
  ;; also enable the inlay hints becuase i mean why not
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (eglot-inlay-hints-mode)
              (eglot-semantic-tokens-mode -1)))

  (add-hook 'before-save-hook #'eglot-format-buffer))
