;;; init-org.el --- Custom org setup -*- lexical-binding: t -*-

(defun my/org-setup-auto-fill ()
  (setq-local fill-column 70)
  (auto-fill-mode 1))

(use-package org
  :ensure nil

  :hook ((org-mode . my/org-setup-auto-fill)
         (org-mode . hl-todo-mode)
         (org-mode . visual-line-mode))

  :custom
  (org-directory "~/org/")
  (org-agenda-files '("~/org/"))
  (org-default-notes-file "~/org/notes.org")
  (org-indirect-buffer-display 'current-window)
  (org-enforce-todo-dependencies t)
  (org-fontify-done-headline t)
  (org-fontify-quote-and-verse-blocks t)
  (org-fontify-whole-heading-line t)
  (org-hide-leading-stars t)
  (org-startup-indented t)
  (org-startup-folded nil)
  (org-tags-column 0)
  (org-image-actual-width nil)
  (org-refile-targets '((nil :maxlevel . 3)
                        (org-agenda-files :maxlevel . 3)))
  (org-refile-use-outline-path 'file)
  (org-outline-path-complete-in-steps nil)

  :config
  (defun fragtog/render-all ()
    (interactive)
    (require 'org-fragtog)
    (if (bound-and-true-p org-fragtog-mode)
        (progn
          (org-fragtog-mode -1)
          (org-clear-latex-preview (point-min) (point-max))
          (message "org-fragtog disabled"))
      (org-fragtog-mode 1)
      (org-latex-preview '(16))
      (message "org-fragtog enabled")))

  (define-key org-mode-map (kbd "C-c p") #'fragtog/render-all)
  (require 'org-tempo)
  (require 'oc-csl)
  (setq org-agenda-span 10
        org-return-follows-link t
        org-src-tab-acts-natively t
        org-src-preserve-indentation t
        org-export-with-smart-quotes t
        org-edit-src-content-indentation 0
        org-confirm-babel-evaluate nil
        org-src-window-setup 'current-window
        org-startup-with-inline-images t)
  (setq org-format-latex-options
        (plist-put org-format-latex-options :scale 1.5))
  (setq org-latex-listings 'minted
        org-latex-packages-alist '(("" "minted"))
        org-latex-pdf-process
        '("latexmk -pdflua -interaction=nonstopmode -shell-escape -bibtex %f")
        org-cite-export-processors '((latex biblatex)))
  (unless (boundp 'org-latex-classes)
    (setq org-latex-classes nil))
  (add-to-list
   'org-latex-classes
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

  (setq org-todo-keywords
        '((sequence "TODO(t)" "PROJ(p)" "LOOP(r)" "STRT(s)" "WAIT(w)" "HOLD(h)" "IDEA(i)"
                    "|"
                    "DONE(d)" "KILL(k)")
          (sequence "[ ](T)" "[-](S)" "[?](W)"
                    "|"
                    "[X](D)")
          (sequence "|"
                    "OKAY(o)" "YES(y)" "NO(n)")))

  (setq org-todo-keyword-faces
        '(("[-]"  . warning)
          ("STRT" . warning)
          ("[?]"  . warning)
          ("WAIT" . warning)
          ("HOLD" . warning)
          ("PROJ" . font-lock-doc-face)
          ("NO"   . error)
          ("KILL" . error)))

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (C . t)
     (shell . t)))

  (dolist (abbrev '(("github"    . "https://github.com/%s")
                    ("youtube"   . "https://youtube.com/watch?v=%s")
                    ("google"    . "https://google.com/search?q=%s")
                    ("wikipedia" . "https://en.wikipedia.org/wiki/%s")))
    (add-to-list 'org-link-abbrev-alist abbrev)))

(use-package evil-org
  :after org
  :hook ((org-mode . evil-org-mode)
         (evil-org-mode . evil-normalize-keymaps)))

(use-package org-download
  :ensure t
  :after org
  :hook (org-mode . org-download-enable)
  :bind (:map org-mode-map ("C-M-v" . org-download-clipboard))
  :config
  (setq-default org-download-image-dir "./images"))

(use-package org-fragtog
  :ensure t
  :defer t
  :after org
  :config
  (setq org-preview-latex-image-directory
        (expand-file-name "org-latex-preview/" temporary-file-directory)))

(use-package org-noter
  :defer t
  :after (pdf-view)
  :commands (org-noter org-noter-insert-note)
  :bind (:map pdf-view-mode-map
              ("C-c n i" . org-noter-insert-note))
  :config
  (with-eval-after-load 'evil
    (evil-define-key 'normal pdf-view-mode-map
      (kbd "i") #'org-noter-insert-note)))

(provide 'init-org)
;;; init-org.el ends here
