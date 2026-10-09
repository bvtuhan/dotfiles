;;; init-dired.el --- Dired and Dirvish setup -*- lexical-binding: t -*-

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :custom
  ;; (dired-kill-when-opening-new-dired-buffer t)
  (dired-listing-switches "-algho --group-directories-first")
  (dired-dwim-target t)
  (dired-auto-revert-buffer #'dired-buffer-stale-p)
  (dired-recursive-copies 'always)
  (dired-recursive-deletes 'top)
  (dired-create-destination-dirs 'ask)
  (dired-clean-confirm-killing-deleted-buffers nil)
  :config
  (when (and (eq system-type 'darwin)
             (executable-find "gls"))
    (setq insert-directory-program "gls"))
  (general-define-key
   :states 'normal
   :keymaps 'dired-mode-map
   "h"     #'dired-up-directory
   "l"     #'dired-find-file
   "j"     #'dired-next-line
   "k"     #'dired-previous-line
   "q"     #'quit-window))

(use-package dired-aux
  :ensure nil
  :custom
  (dired-vc-rename-file t))

(use-package dired-x
  :ensure nil
  :hook (dired-mode . dired-omit-mode)
  :config
  (setq dired-omit-verbose nil
        dired-omit-files
        (concat dired-omit-files
                "\\|^\\.DS_Store\\'"
                "\\|^flycheck_.*"
                "\\|^\\.project\\(?:ile\\)?\\'"
                "\\|^\\.\\(?:svn\\|git\\)\\'"
                "\\|^\\.ccls-cache\\'"
                "\\|\\(?:\\.js\\)?\\.meta\\'"
                "\\|\\.\\(?:elc\\|o\\|pyo\\|swp\\|class\\)\\'"))

  (when-let* ((open-cmd (cond ((eq system-type 'darwin) "open")
                              ((eq system-type 'gnu/linux) "xdg-open")
                              ((eq system-type 'windows-nt) "start"))))
    (setq dired-guess-shell-alist-user
          `(( "\\.\\(?:docx\\|pdf\\|djvu\\|eps\\)\\'" ,open-cmd)
            ( "\\.\\(?:jpe?g\\|png\\|gif\\|xpm\\)\\'" ,open-cmd)
            ( "\\.\\(?:mp4\\|mkv\\|avi\\|flv\\|rm\\|rmvb\\|ogv\\)\\(?:\\.part\\)?\\'" ,open-cmd)
            ( "\\.\\(?:mp3\\|flac\\)\\'" ,open-cmd)
            ( "\\.html?\\'" ,open-cmd)
            ( "\\.csv\\'" ,open-cmd))))

  (general-define-key
   :states 'normal
   :keymaps 'dired-mode-map
   "." #'dired-omit-mode))

(use-package diredfl
  :hook (dired-mode . diredfl-mode))

(use-package nerd-icons
  :config
  (unless (display-graphic-p)
    (setq nerd-icons-color-icons nil)))

;; please rm -rf ~/.emacs.d/elpa/dirvish first
;; main upstream is back
(use-package dirvish
  :custom
  (dirvish-cache-dir (expand-file-name "dirvish/" user-emacs-directory))
  (dirvish-reuse-session 'open)
  (dirvish-attributes
   '(nerd-icons file-time file-size collapse subtree-state vc-state))
  (dirvish-hide-details '(dirvish dirvish-side))
  (dirvish-hide-cursor '(dirvish dirvish-side))
  :config
  (dirvish-override-dired-mode)
  (general-define-key
   :states '(normal visual)
   :keymaps 'dirvish-mode-map
   "?"       #'dirvish-dispatch
   "q"       #'dirvish-quit
   "b"       #'dirvish-quick-access
   "f"       #'dirvish-file-info-menu
   "+"       #'dired-create-directory
   "c"       #'find-file
   "C"       #'dired-do-copy
   "R"       #'dired-do-rename
   "d"       #'dired-flag-file-deletion
   "m"       #'dired-mark
   "u"       #'dired-unmark
   "x"       #'dired-do-flagged-delete
   "p"       #'dirvish-yank
   "h"       #'dired-up-directory
   "l"       #'dired-find-file
   "<left>"  #'dired-up-directory
   "<right>" #'dired-find-file
   "TAB"     #'dirvish-subtree-toggle
   "gh"      #'dirvish-subtree-up
   "gl"      #'dirvish-subtree-toggle
   "[h"      #'dirvish-history-go-backward
   "]h"      #'dirvish-history-go-forward
   "M-b"     #'dirvish-history-go-backward
   "M-f"     #'dirvish-history-go-forward
   "z"       #'dirvish-history-jump
   "S"       #'dirvish-quicksort
   "F"       #'dirvish-layout-toggle
   "M-n"     #'dirvish-narrow
   "M-m"     #'dirvish-mark-menu
   "M-s"     #'dirvish-setup-menu
   "M-e"     #'dirvish-emerge-menu
   "[e"      #'dirvish-emerge-next-group
   "]e"      #'dirvish-emerge-previous-group
   "y l"     #'dirvish-copy-file-true-path
   "y n"     #'dirvish-copy-file-name
   "y p"     #'dirvish-copy-file-path
   "y r"     #'dirvish-copy-remote-path
   "y y"     #'dired-do-copy
   "s s"     #'dirvish-symlink
   "s S"     #'dirvish-relative-symlink
   "s h"     #'dirvish-hardlink))

(use-package autorevert
  :ensure nil
  :hook (dired-mode . auto-revert-mode)
  :custom
  (auto-revert-verbose nil))

(use-package dired-subtree
  :ensure t
  :commands (dired-subtree-toggle dired-subtree-cycle)
  :config
  (setq dired-subtree-line-prefix " ")
  (setq dired-subtree-use-backgrounds nil))

(use-package dired-sidebar
  :ensure t
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :commands (dired-sidebar-toggle-sidebar
             dired-sidebar-show-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode 1))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix "__"
        dired-sidebar-use-term-integration nil
        dired-sidebar-use-custom-font t)

  (with-eval-after-load 'evil
    (evil-define-key 'normal dired-sidebar-mode-map
      "l" 'dired-sidebar-find-file
      "h" 'dired-sidebar-up-directory
      (kbd "RET") 'dired-sidebar-find-file)))

(provide 'init-dired)
;;; init-dired.el ends here
