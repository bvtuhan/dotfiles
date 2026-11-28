;;; init-evil.el --- Custom evil setup -*- lexical-binding: t -*-

;; evil mode
(use-package evil
  :init
  (setq evil-search-module 'evil-search
        evil-ex-complete-emacs-commands nil
        evil-vsplit-window-right t
        evil-split-window-below t
        evil-shift-round nil
        evil-want-C-u-scroll t
        evil-want-integration t
        evil-want-keybinding nil
        evil-insert-state-cursor 'box
        evil-undo-system 'undo-fu
        evil-respect-visual-line-mode t
        evil-shift-width tab-width)
  :config
  (setq hl-line-sticky-flag nil)
  (global-hl-line-mode 1)
  (setq-default evil-cross-lines t)
  (advice-add 'evil-window-vsplit :override (lambda (&rest r) (split-window (selected-window) nil 'right)))
  (advice-add 'evil-window-split :override (lambda (&rest r) (split-window (selected-window) nil 'below)))
  (evil-mode))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-goggles
  :after evil
  :defer t
  :init
  (setq evil-goggles-duration 0.1
        evil-goggles-enable-change nil
        evil-goggles-enable-delete nil)
  (run-with-idle-timer 0.2 nil (lambda () (evil-goggles-mode 1))))

;; undo-fu/vundo stack
(use-package undo-fu
  :after evil
  :defer t
  :config
  (setq undo-limit 67108864 ;; 64mb.
        undo-strong-limit 100663296 ;; 96mb.
        undo-outer-limit 1006632960)) ;; 960mb.

(use-package undo-fu-session
  :defer t
  :init
  (defun my/enable-undo-fu-session-once ()
    (remove-hook 'find-file-hook #'my/enable-undo-fu-session-once)
    (undo-fu-session-global-mode 1))
  (add-hook 'find-file-hook #'my/enable-undo-fu-session-once)
  :config
  (setq undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'")))

(provide 'init-evil)
;;; init-evil.el ends here
