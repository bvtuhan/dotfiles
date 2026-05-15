;;; init-general.el --- Custom keybindings setup -*- lexical-binding: t -*-

;; THIS FILE DEFINES GLOBAL BINDINGS
;; LOCAL BINDINGS MAY OVERWRITE THESE
;; SO BE CAREFUL

;; Notes for custom bindings
;;
;; 1.For plugin-specific mappings, use this:
;;   (general-define-key
;;   :states 'normal <WHICH EVIL_MODE>
;;   :keymaps 'x-mode-map <X is the plugin>
;;   "z=" #'x-func))
;;   But the common-practice is to define the
;;   package-local keybindings inside use-package
;;   function. The main problem is that if we bind
;;   'x-func' here, the package for x must have been
;;   loaded at that point. If it is not the case, then
;;   the general would crash. So use this instead:
;;   (use-package x
;;     :bind ;; normal-emacs binding for fallback
;;     (("M-$" . x-func))
;;     :config
;;     (with-eval-after-load 'evil
;;       (evil-global-set-key 'normal (kbd "z=") #'x-func)))

(use-package which-key
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3))

(global-set-key (kbd "<escape>") 'keyboard-quit)
(with-eval-after-load 'transient
  (define-key transient-map (kbd "<escape>") 'transient-quit-one))

(use-package general
  :config
  (general-evil-setup t)

  ;; GLOBAL KEYBINDINGS HERE
  (general-nmap
    "gr" #'xref-find-references
    "gd" #'xref-find-definitions
    "K"  #'eldoc-doc-buffer)

  (general-define-key
   "M-m" 'shell-command
   "C-/" 'comment-dwim
   )

  ;; doom migration
  (general-create-definer my/leader-keys
    :states '(normal visual motion)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")

  (my/leader-keys
    "SPC" '(find-file :which-key "Find file")
    "."   '(find-file :which-key "Find file")
    ","   '(switch-to-buffer :which-key "Switch buffer")
    ":"   '(execute-extended-command :which-key "M-x")

    "b" '(:ignore t :which-key "Buffer")
    "bb" '(consult-buffer :which-key "consult-buffer")
    "b[" '(previous-buffer :which-key "Previous buffer")
    "b]" '(next-buffer :which-key "Next buffer")
    "bd" '(kill-current-buffer :which-key "Kill buffer")
    "bk" '(kill-current-buffer :which-key "Kill buffer")
    "bl" '(evil-switch-to-windows-last-buffer :which-key "Switch to last buffer")
    "br" '(revert-buffer-no-confirm :which-key "Revert buffer")
    "bK" '(kill-other-buffers :which-key "Kill other buffers")

    "f" '(:ignore t :which-key "file")
    "ff" '(find-file :which-key "Find file")
    "fs" '(save-buffer :which-key "Save file")

    "w" '(evil-window-map :which-key "window")

    "d"   '(:ignore t :which-key "debug")
    "d d" '(dape :which-key "Start debugger")
    "d b" '(dape-breakpoint-toggle :which-key "Toggle breakpoint")
    "d B" '(dape-breakpoint-remove-all :which-key "Remove all breakpoints")
    "d c" '(dape-continue :which-key "Continue")
    "d n" '(dape-next :which-key "Next")
    "d s" '(dape-step-in :which-key "Step in")
    "d o" '(dape-step-out :which-key "Step out")
    "d r" '(dape-restart :which-key "Restart")
    "d q" '(dape-quit :which-key "Quit")
    "d D" '(dape-disconnect-quit :which-key "Disconnect")
    "d i" '(dape-info :which-key "Info")
    "d R" '(dape-repl :which-key "REPL")
    "d x" '(dape-evaluate-expression :which-key "Evaluate")
    "d w" '(dape-watch-dwim :which-key "Watch")

    "q" '(:ignore t :which-key "quit")
    "qq" '(save-buffers-kill-terminal :which-key "Quit Emacs"))

  (general-define-key
   :states 'motion
   "?" '+consult-line

   ;; window management
   "C-w C-u" 'tab-bar-history-back
   "C-w u" 'tab-bar-history-back

   "C-w a" 'ace-window
   "C-w C-w" 'ace-window
   "C-w w" 'ace-window

   "C-w d" 'evil-window-delete
   "C-w C-l" 'evil-window-right
   "C-w C-h" 'evil-window-left)

  (general-unbind '(motion insert) "C-z")
  )

(provide 'init-general)
;;; init-general.el ends here
