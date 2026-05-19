;;; init-doom-modeline.el --- Custom doom-modeline setup -*- lexical-binding: t -*-

(use-package doom-modeline
  :ensure t
  :hook ((after-init . doom-modeline-mode)
         (doom-modeline-mode . size-indication-mode)
         (doom-modeline-mode . column-number-mode))
  :init
  (unless after-init-time
    (setq-default mode-line-format nil))
  (setq projectile-dynamic-mode-line nil)
  (setq doom-modeline-bar-width 3
        doom-modeline-github nil
        doom-modeline-mu4e nil
        doom-modeline-persp-name nil
        doom-modeline-minor-modes nil
        doom-modeline-major-mode-icon nil
        doom-modeline-check 'simple
        doom-modeline-buffer-file-name-style 'relative-from-project
        doom-modeline-buffer-encoding 'nondefault
        doom-modeline-default-eol-type
        (if (memq system-type '(windows-nt ms-dos cygwin))
            1
          0)
        doom-modeline-icon nil)
  :config
  (setq find-file-visit-truename t)
  (setq inhibit-compacting-font-caches t)
  (defvar mouse-wheel-down-event nil)
  (defvar mouse-wheel-up-event nil)
  (add-to-list 'doom-modeline-mode-alist '(dashboard-mode . dashboard))
  (doom-modeline-def-modeline 'my-line
    '(bar modals matches buffer-info buffer-position selection-info)
    '(buffer-encoding lsp major-mode process vcs check)))

(provide 'init-doom-modeline)
;;; init-doom-modeline.el ends here
