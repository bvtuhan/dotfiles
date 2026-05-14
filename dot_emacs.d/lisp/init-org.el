;;; init-org.el --- Custom org setup -*- lexical-binding: t -*-

(defun my/org-setup-auto-fill ()
  (setq-local fill-column 70)
  (auto-fill-mode 1))

(use-package org
  :ensure nil
  :hook ((org-mode . my/org-setup-auto-fill)
         (org-mode . hl-todo-mode)
         (org-mode . visual-line-mode)
         (org-mode . flyspell-mode))
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
  (require 'org-tempo)
  (setq org-agenda-span 10
        org-agenda-start-on-weekday nil
        org-agenda-window-setup 'current-window
        org-return-follows-link t
        org-src-tab-acts-natively t
        org-src-preserve-indentation t
        org-edit-src-content-indentation 0
        org-confirm-babel-evaluate nil
        org-src-window-setup 'current-window
        org-startup-with-inline-images t)
  (when (boundp '+org-google-dir)
    (setq org-directory +org-google-dir
          org-agenda-files (list (format "%s/roam/agenda" +org-google-dir))))
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
  (setq org-capture-templates
        '(("t" "Personal todo" entry
           (file+headline "todo.org" "Inbox")
           "* [ ] %?\n%i\n%a"
           :prepend t)
          ("n" "Personal notes" entry
           (file+headline "notes.org" "Inbox")
           "* %u %?\n%i\n%a"
           :prepend t)
          ("j" "Journal" entry
           (file+olp+datetree "journal.org")
           "* %U %?\n%i\n%a"
           :prepend t)))
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
    (add-to-list 'org-link-abbrev-alist abbrev))
  (my/leader-keys
    :keymaps 'org-mode-map
    "m"   '(:ignore t :which-key "org")
    "m#"  '(org-update-statistics-cookies :which-key "Update cookies")
    "m'"  '(org-edit-special :which-key "Edit src block")
    "m*"  '(org-ctrl-c-star :which-key "Toggle heading")
    "m-"  '(org-ctrl-c-minus :which-key "Toggle item")
    "mA"  '(org-archive-subtree-default :which-key "Archive")
    "me"  '(org-export-dispatch :which-key "Export")
    "mo"  '(org-set-property :which-key "Set property")
    "mq"  '(org-set-tags-command :which-key "Set tags")
    "mt"  '(org-todo :which-key "Todo state")
    "mx"  '(org-toggle-checkbox :which-key "Toggle checkbox")

    "ma"  '(:ignore t :which-key "attachments")
    "maa" '(org-attach :which-key "Attach command")
    "man" '(org-attach-new :which-key "New attachment")

    "mc"  '(:ignore t :which-key "clock")
    "mci" '(org-clock-in :which-key "Clock in")
    "mco" '(org-clock-out :which-key "Clock out")
    "mcg" '(org-clock-goto :which-key "Goto clock")
    "mcc" '(org-clock-cancel :which-key "Cancel clock")

    "md"  '(:ignore t :which-key "date")
    "mdd" '(org-deadline :which-key "Deadline")
    "mds" '(org-schedule :which-key "Schedule")
    "mdt" '(org-time-stamp :which-key "Time stamp")

    "mr"  '(:ignore t :which-key "refile")
    "mrr" '(org-refile :which-key "Refile")

    "ms"  '(:ignore t :which-key "tree")
    "msn" '(org-narrow-to-subtree :which-key "Narrow to subtree")
    "msN" '(widen :which-key "Widen"))

  (general-define-key
   :states '(normal visual)
   :keymaps 'org-mode-map
   "RET" 'org-open-at-point
   "za"  'org-cycle
   "zA"  'org-shifttab
   "zM"  'outline-hide-body
   "zR"  'outline-show-all))

(use-package evil-org
  :after org
  :hook ((org-mode . evil-org-mode)
         (evil-org-mode . evil-normalize-keymaps))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(provide 'init-org)
;;; init-org.el ends here
