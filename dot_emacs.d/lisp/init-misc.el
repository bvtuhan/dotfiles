;;; init-misc.el --- Random stuff -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package copilot
  :bind (:map copilot-completion-map
              ("<tab>"   . copilot-accept-completion)
              ("TAB"     . copilot-accept-completion)
              ("C-TAB"   . copilot-accept-completion-by-word)
              ("C-<tab>" . copilot-accept-completion-by-word))
  :config
  (defun copilot--infer-indentation-offset ()
    (or (bound-and-true-p tab-width) 4)))

(use-package autoinsert
  :ensure nil
  :init
  (auto-insert-mode 1)
  :config
  (setq auto-insert-query nil)
  (defun my/title-from-file-name (file-name)
    (string-join
     (mapcar #'capitalize
             (split-string
              (file-name-sans-extension file-name)
              "[-_]+" t))
     " "))
  (define-auto-insert
    "\\.org\\'"
    (lambda ()
      (let* ((file-name (file-name-nondirectory buffer-file-name))
             (title (my/title-from-file-name file-name)))
        (insert
         "#+title: " title "\n"
         "#+author:    bvtuhan\n"
         "#+email:     jjackson.stormm@gmail.com\n"))))

  (define-auto-insert
    "\\.el\\'"
    (lambda ()
      (let* ((file-name (file-name-nondirectory buffer-file-name))
             (feature-name (file-name-sans-extension file-name)))
        (insert
         ";;; " file-name " --- Description -*- lexical-binding: t; -*-\n\n"
         ";;; Commentary:\n\n"
         ";;; Code:\n\n"
         "\n"
         "(provide '" feature-name ")\n"
         ";;; " file-name " ends here\n")))))

(use-package ace-window)

;; formatter
(add-hook 'before-save-hook #'delete-trailing-whitespace)
(use-package apheleia
  :ensure t
  :config
  (setf (alist-get 'clang-format apheleia-formatters)
        '("clang-format" "--style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never}"))
  (apheleia-global-mode +1)
  (add-hook 'TeX-mode-hook (lambda () (apheleia-mode -1)))
  (add-hook 'LaTeX-mode-hook (lambda () (apheleia-mode -1))))

(use-package pdf-tools
  :if (display-graphic-p)
  :defer t
  :config
  (pdf-tools-install :no-query)
  (init-latex-select-viewer))


(provide 'init-misc)
;;; init-misc.el ends here
