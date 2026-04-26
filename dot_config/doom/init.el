;;; init.el -*- lexical-binding: t; -*-

(doom! :input
       :completion
       (corfu +dabbrev +icons +orderless)
       (vertico +icons)

       :ui
       doom                ; what makes DOOM look the way it does
       doom-dashboard      ; a nifty splash screen for Emacs
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       modeline          ; snazzy, Atom-inspired modeline, plus API
       ophints           ; highlight the region an operation acts on
       (popup +defaults)   ; tame sudden yet inevitable temporary windows
       (vc-gutter +pretty) ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       workspaces        ; tab emulation, persistence & separate workspaces

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       (format +onsave)  ; automated prettiness
       snippets          ; my elves. They type so I don't have to

       :emacs
       (dired +dirvish +icons)
       electric          ; smarter, keyword-based electric-indent
       undo              ; persistent, smarter undo for your inevitable mistakes
       vc                ; version-control and Emacs, sitting in a tree

       :term
       eshell            ; the elisp shell that works everywhere
       vterm             ; the best terminal emulation in Emacs

       :checkers
       (syntax +childframe)
       (spell +hunspell) ; tasing you for misspelling mispelling

       :tools
       (lsp +eglot)
       tree-sitter
       debugger
       direnv
       editorconfig
       (eval +overlay)     
       (lookup +docsets +dictionary)
       magit
       pdf

       :os
       (:if (featurep :system 'macos) macos)  ; improve compatibility with macOS
       tty                                    ; improve the terminal Emacs experience

       :lang
       (cc +lsp +tree-sitter)
       (emacs-lisp)
       (latex +lsp)
       (org +roam2 +forge +noter)
       (python +lsp +tree-sitter +pyright)
       (rust +lsp +tree-sitter)
       (sh +powershell +fish +bash +lsp)
       (zig +lsp +tree-sitter)   
       (common-lisp +lsp +tree-sitter)

       :email
       ;;(mu4e +org +gmail)
       ;;notmuch
       ;;(wanderlust +gmail)

       :app
       ;;calendar
       ;;emms
       ;;everywhere        ; *leave* Emacs!? You must be joking
       ;;irc               ; how neckbeards socialize
       ;;(rss +org)        ; emacs as an RSS reader

       :config
       ;;literate
       (default +bindings +smartparens))

