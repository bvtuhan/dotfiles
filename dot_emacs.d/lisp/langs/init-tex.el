;;; init-tex.el --- Description -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(use-package tex
  :ensure auctex
  :defer t
  :custom
  (TeX-parse-self t)
  (TeX-auto-save t)
  (TeX-source-correlate-mode t)
  (TeX-source-correlate-method 'synctex)
  (TeX-master t)
  (TeX-engine 'luatex)
  :config
  (add-to-list 'TeX-command-list
               '("LatexMk"
                 "latexmk -pdflua -interaction=nonstopmode -shell-escape -bibtex %s"
                 TeX-run-TeX nil t
                 :help "Run latexmk with LuaLaTeX"))
  (add-to-list 'TeX-command-list
               '("LuaLatexMk"
                 "latexmk -lualatex -file-line-error -interaction=nonstopmode -shell-escape -synctex=1 %s"
                 TeX-run-TeX nil t
                 :help "Run latexmk with LuaLaTeX"))
  (add-hook 'LaTeX-mode-hook (lambda () (setq-local TeX-command-default "LuaLatexMk"))))

(use-package latex
  :ensure auctex
  :defer t
  :custom
  (TeX-electric-sub-and-superscript t)
  (LaTeX-item-indent -2)
  (LaTeX-indent-level 2))

(use-package preview
  :ensure auctex
  :defer t
  :hook (LaTeX-mode . LaTeX-preview-setup))

(use-package adaptive-wrap
  :ensure t
  :hook (LaTeX-mode . adaptive-wrap-prefix-mode))

(use-package reftex
  :ensure nil
  :defer t
  :hook (LaTeX-mode . turn-on-reftex)
  :custom
  (reftex-plug-into-AUCTeX t)
  (reftex-cite-format '((?a . "\\autocite[]{%l}")
                        (?c . "\\cite[]{%l}")
                        (?p . "\\parencite[]{%l}")
                        (?t . "\\textcite[]{%l}"))))

(use-package bibtex
  :ensure nil
  :defer t
  :custom
  (bibtex-dialect 'biblatex))

(use-package evil-tex
  :ensure t
  :defer t
  :hook (LaTeX-mode . evil-tex-mode))

(use-package citar
  :ensure t
  :hook
  ((org-mode . citar-capf-setup)
   (LaTeX-mode . citar-capf-setup))
  :custom
  (org-cite-insert-processor 'citar)
  (org-cite-follow-processor 'citar)
  (org-cite-activate-processor 'citar)
  :config
  (add-to-list 'savehist-additional-variables 'citar-history))

;; some custom scripts
(defun bibtex-paste ()
  "Add the yanked BibTeX entry to the references.bib file located in the current working directory."
  (interactive)
  (when (not (file-exists-p "references.bib"))
    (make-empty-file "references.bib"))
  (let ((file-path "references.bib")
        (text-to-append (current-kill 0)))
    (write-region (concat "\n" text-to-append) nil file-path t)))

(provide 'init-tex)
;;; init-tex.el ends here
