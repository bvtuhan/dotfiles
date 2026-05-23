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
    :states 'motion
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

  (defun custom/open-eshell-horizontal ()
    (interactive)
    (split-window-below)
    (other-window 1)
    (eshell))

  (my/leader-keys
    "SPC" '(custom/open-eshell-horizontal :which-key "Open eshell in a vertical window")
    "."   '(find-file :which-key "Find file")
    ","   '(consult-buffer :which-key "Switch buffer")
    ":"   '(execute-extended-command :which-key "M-x")
    "/"   '(consult-ripgrep :which-key "Fuzzy search")

    "s"   '(:ignore t :which-key "search")
    "ss" '(consult-line :which-key "Search current buffer")
    "sS" '(consult-line-multi :which-key "Search all buffers")
    "so" '(consult-outline :which-key "Search outline")
    "si" '(consult-imenu :which-key "Search imenu")
    "sI" '(consult-imenu-multi :which-key "Search imenu all buffers")

    "sp" '((lambda ()
             (interactive)
             (consult-ripgrep
              (if-let ((project (project-current)))
                  (project-root project)
                default-directory)))
           :which-key "Search project")

    "sd" '((lambda ()
             (interactive)
             (consult-ripgrep
              (read-directory-name "Search directory: ")))
           :which-key "Search directory"
           )

    "sg" '(consult-grep :which-key "Grep")
    "sf" '(consult-find :which-key "Find file in directory")
    "sF" '(consult-locate :which-key "Locate file")

    "sr" '(consult-ripgrep :which-key "Ripgrep")
    "sk" '(consult-keep-lines :which-key "Keep matching lines")
    "su" '(consult-focus-lines :which-key "Focus matching lines")

    "sh" '(consult-history :which-key "Search minibuffer history")
    "sm" '(consult-mark :which-key "Search marks")
    "sM" '(consult-global-mark :which-key "Search global marks")
    "sR" '(consult-register :which-key "Search registers")

    "sc" '(consult-command :which-key "Search commands")
    "se" '(consult-isearch-history :which-key "Search isearch history")
    "sy" '(consult-yank-pop :which-key "Search kill ring")

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
             (find-file user-emacs-directory))
           :which-key "Open private configuration in new window")
    "fP" '((lambda ()
             (interactive)
             (find-file-other-window user-emacs-directory)
             (find-file user-emacs-directory))
           :which-key "Open private configuration")

    "fn" '((lambda ()
             (interactive)
             (find-file-other-window "~/notes/"))
           :which-key "Locate private notes")

    "fc" '((lambda ()
             (interactive)
             (find-file "~/cs-doom-log/"))
           :which-key "Open ~/cs-doom-log/")

    "w" '(evil-window-map :which-key "window")

    "d"   '(:ignore t :which-key "debug")
    "dd" '(dape :which-key "Start debugger")
    "db" '(dape-breakpoint-toggle :which-key "Toggle breakpoint")
    "dB" '(dape-breakpoint-remove-all :which-key "Remove all breakpoints")
    "dc" '(dape-continue :which-key "Continue")
    "dn" '(dape-next :which-key "Next")
    "ds" '(dape-step-in :which-key "Step in")
    "do" '(dape-step-out :which-key "Step out")
    "dr" '(dape-restart :which-key "Restart")
    "dq" '(dape-quit :which-key "Quit")
    "dD" '(dape-disconnect-quit :which-key "Disconnect")
    "di" '(dape-info :which-key "Info")
    "dR" '(dape-repl :which-key "REPL")
    "dx" '(dape-evaluate-expression :which-key "Evaluate")
    "dw" '(dape-watch-dwim :which-key "Watch")

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

  (general-unbind '(motion insert) "C-z"))

(provide 'init-general)
;;; init-general.el ends here
