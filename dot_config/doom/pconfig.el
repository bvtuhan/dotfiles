;;; pconfig.el -*- lexical-binding: t; -*-
;;; $DOOMDIR/pconfig.el

(use-package! copilot
  :bind (:map copilot-completion-map
              ("<tab>"   . copilot-accept-completion)
              ("TAB"     . copilot-accept-completion)
              ("C-TAB"   . copilot-accept-completion-by-word)
              ("C-<tab>" . copilot-accept-completion-by-word))
  :config
  (defun copilot--infer-indentation-offset ()
    (or (bound-and-true-p tab-width) 4)))

(use-package! org-download
  :hook (dired-mode . org-download-enable)
  :config
  (setq-default org-download-image-dir "./images")
  (map! "C-M-v" #'org-download-clipboard))

(use-package! jinx
  :config
  (global-jinx-mode 1))

;; this thing does not work under WSL 
(use-package! org-fragtog
  :hook (org-mode . org-fragtog-mode)
  :config
  (advice-add 'org-fragtog--post-cmd :around
              (lambda (fn &rest args)
                (ignore-errors (apply fn args)))))
