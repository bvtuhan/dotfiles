;;; init-doom-modeline.el --- Custom doom-modeline setup -*- lexical-binding: t -*-

; https://github.com/ZacJoffe/zemacs/blob/master/init.el#L1415-L1540
(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :hook (doom-modeline-mode . size-indication-mode)
  :hook (doom-modeline-mode . column-number-mode)
  :init
  (unless after-init-time
    (setq-default mode-line-format nil))
  (setq projectile-dynamic-mode-line nil
        doom-modeline-bar-width 3
        doom-modeline-buffer-file-name-style 'truncate-nil
        doom-modeline-icon nil
        doom-modeline-buffer-encoding 'nondefault
        doom-modeline-default-eol-type (if (or (eq system-type 'gnu/linux) (eq system-type 'darwin)) 0 1))
  :config
  (setq find-file-visit-truename t)
  (setq inhibit-compacting-font-caches t)
  (doom-modeline-def-modeline 'my-line
    '(bar modals matches buffer-info buffer-position selection-info)
    '(buffer-encoding lsp major-mode process vcs check))
  (defun setup-custom-doom-modeline ()
     (doom-modeline-set-modeline 'my-line 'default))
  (add-hook 'doom-modeline-mode-hook 'setup-custom-doom-modeline))

(provide 'init-doom-modeline)
;;; init-doom-modeline.el ends here

