;;; early-init.el --- Early Initialization -*- lexical-binding: t -*-

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 64 1024 1024)   ;; 64 MB
                  gc-cons-percentage 0.1)))
(defvar default-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq file-name-handler-alist default-file-name-handler-alist)))
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars . nil) default-frame-alist)
(setq menu-bar-mode nil
      tool-bar-mode nil
      scroll-bar-mode nil
      tooltip-mode nil)
(setq frame-inhibit-implied-resize t
      frame-resize-pixelwise t)
(setq package-enable-at-startup nil)
(setq evil-want-integration t
      evil-want-keybinding nil
      evil-want-C-u-scroll t)

(provide 'early-init)
;;; early-init.el ends here
