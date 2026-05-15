;;; init-dape.el --- Custom dape setup -*- lexical-binding: t -*-

(use-package dape
  :ensure t
  :commands (dape)
  :custom
  (dape-cwd-function
   (lambda ()
     (if (fboundp 'projectile-project-root)
         (or (projectile-project-root) default-directory)
       default-directory)))
  :config
  (dape-breakpoint-global-mode +1)
  (setq dape-buffer-window-arrangement 'right
        dape-inlay-hints t)
  (add-hook 'dape-display-source-hook
            #'pulse-momentary-highlight-one-line)
  (add-hook 'dape-start-hook
            (lambda ()
              (save-some-buffers t t))))

(use-package repeat
  :ensure nil
  :custom
  (repeat-mode 1))

(use-package emacs
  :ensure nil
  :custom
  (window-sides-vertical t))

(provide 'init-dape)
;;; init-dape.el ends here
