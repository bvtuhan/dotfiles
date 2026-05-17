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
   "C-/" 'comment-dwim)

  ;; doom migration
  (general-create-definer my/leader-keys
    :states '(normal visual motion)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")

  (my/leader-keys
    "SPC" '(find-file :which-key "Find file")
    "."   '(find-file :which-key "Find file")
    ","   '(consult-buffer :which-key "Switch buffer")
    ":"   '(execute-extended-command :which-key "M-x")
    "/"   '(consult-ripgrep :which-key "Fuzzy search")

    "s"   '(:ignore t :which-key "search")

    "s s" '(consult-line :which-key "Search current buffer")
    "s S" '(consult-line-multi :which-key "Search all buffers")
    "s o" '(consult-outline :which-key "Search outline")
    "s i" '(consult-imenu :which-key "Search imenu")
    "s I" '(consult-imenu-multi :which-key "Search imenu all buffers")

    "s p" '((lambda ()
              (interactive)
              (consult-ripgrep
               (if-let ((project (project-current)))
                   (project-root project)
                 default-directory)))
            :which-key "Search project")

    "s d" '((lambda ()
              (interactive)
              (consult-ripgrep
               (read-directory-name "Search directory: ")))
            :which-key "Search directory"
            )

    "s g" '(consult-grep :which-key "Grep")
    "s f" '(consult-find :which-key "Find file in directory")
    "s F" '(consult-locate :which-key "Locate file")

    "s r" '(consult-ripgrep :which-key "Ripgrep")
    "s k" '(consult-keep-lines :which-key "Keep matching lines")
    "s u" '(consult-focus-lines :which-key "Focus matching lines")

    "s h" '(consult-history :which-key "Search minibuffer history")
    "s m" '(consult-mark :which-key "Search marks")
    "s M" '(consult-global-mark :which-key "Search global marks")
    "s R" '(consult-register :which-key "Search registers")

    "s c" '(consult-command :which-key "Search commands")
    "s e" '(consult-isearch-history :which-key "Search isearch history")
    "s y" '(consult-yank-pop :which-key "Search kill ring")

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
    "fs" '(save-buffer :which-key "Save buffer")
    "fS" '((lambda ()
             (interactive)
             (save-some-buffers t))
           :which-key "Save all buffers")
    "fp" '((lambda ()
             (interactive)
             (dired-x-find-file user-emacs-directory))
           :which-key "Open private configuration in new window")
    "fP" '((lambda ()
             (interactive)
             (dired-x-find-file-other-window user-emacs-directory)
             (find-file user-emacs-directory))
           :which-key "Open private configuration")

    "fn" '((lambda ()
             (interactive)
             (dired-x-find-file-other-window "~/notes/"))
           :which-key "Locate private notes")

    "fc" '((lambda ()
             (interactive)
             (find-file "~/cs-doom-log/"))
           :which-key "Open ~/cs-doom-log/")

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

    "l"  '(:ignore t :wk "live share/collab")
    "lb" '(crdt-switch-to-buffer :wk "switch to shared buffer")
    "lc" '(crdt-connect :wk "connect to session")
    "ld" '(crdt-disconnect :wk "disconnect")
    "lf" '(crdt-follow-user :wk "follow user's cursor")
    "lF" '(crdt-stop-follow :wk "stop following")
    "lg" '(crdt-goto-user :wk "goto user's cursor")
    "li" '(crdt-list-buffers :wk "list shared buffers")
    "lk" '(crdt-kill-user :wk "kick user")
    "ll" '(crdt-list-sessions :wk "list sessions")
    "ls" '(crdt-share-buffer :wk "share current buffer")
    "lS" '(crdt-stop-share-buffer :wk "stop sharing buffer")
    "lu" '(crdt-list-users :wk "list users")
    "lx" '(crdt-stop-session :wk "stop session")
    "ly" '(crdt-copy-url :wk "copy session URL")
    "l]" '(crdt-goto-next-user :wk "next user's cursor")
    "l[" '(crdt-goto-prev-user :wk "previous user's cursor")

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
