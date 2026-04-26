;;; yellowbeans-theme.el --- Yellowbeans color theme created by 'gremble0' ported to Emacs -*- lexical-binding: t; -*-
;;
;; Copyright (c) 2023-2026 Herman Stornes
;; Copyright (C) 2026 bvtuhan
;;
;; Author: bvtuhan <jjackson.stormm@gmail.com>
;; Maintainer: bvtuhan <jjackson.stormm@gmail.com>
;; Version: 0.0.3
;; Keywords: theme, dark, yellow, simple
;; Homepage: https://github.com/bvtuhan/yellowbeans-theme-emacs
;; Package-Requires: ((emacs "29.1"))
;; SPDX-License-Identifier: MIT
;;
;; This file is not part of GNU Emacs.
;;
;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use, copy,
;; modify, merge, publish, distribute, sublicense, and/or sell copies
;; of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
;; BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
;; ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.
;;
;;; Commentary:
;;
;;  Simple color theme featuring a dark background with yellow accents.
;;  Originally created by 'gremble0' as a Neovim color scheme, adapted
;;  for Emacs. Currently includes core Emacs faces, syntax highlighting,
;;  org-mode, markdown-mode (more in future hopefully). Contributions
;;  are welcome.
;;
;;; Code:

(deftheme yellowbeans
  "An Emacs port of gramble0's Yellowbeans theme.")

;; define color palette
(let ((yellowbeans-bg "#151515")
      (yellowbeans-fg "#cccccc")
      (yellowbeans-black-1 "#101010")
      (yellowbeans-black-2 "#1c1c1c")
      (yellowbeans-black-4 "#282828")
      (yellowbeans-black-5 "#303030")
      (yellowbeans-gray-1 "#333333")
      (yellowbeans-gray-2 "#606060")
      (yellowbeans-gray-3 "#777777")
      (yellowbeans-white-1 "#aaaaaa")
      (yellowbeans-white-2 "#888888")
      (yellowbeans-gold-yellow "#e1b655")
      (yellowbeans-dark-yellow "#d4aa55")
      (yellowbeans-olive-green "#9aae6b")
      (yellowbeans-moss-green "#7c9081")
      (yellowbeans-morningglory-blue "#8fbfdc")
      (yellowbeans-shipcove-blue "#8197bf")
      (yellowbeans-sky-blue "#7187bf")
      (yellowbeans-perano-blue "#b0d0f0")
      (yellowbeans-hoki-blue "#526779")
      (yellowbeans-dove-blue "#a9b1d6")
      (yellowbeans-lavender-purple "#b6a6ff")
      (yellowbeans-bad "#f22b2b")
      (yellowbeans-bad-bg "#503030")
      (yellowbeans-neutral "#ffa500")
      (yellowbeans-neutral-bg "#6B572A")
      (yellowbeans-good "#b3e27c")
      (yellowbeans-good-bg "#2e3127"))

  ;; background hard code
  (custom-theme-set-variables 'yellowbeans '(frame-background-mode 'dark))

  ;; styling
  (custom-theme-set-faces
   'yellowbeans

   ;; core faces
   `(default ((t (:foreground ,yellowbeans-fg :background ,yellowbeans-bg)))) ;; normal text and the background
   `(cursor ((t (:background ,yellowbeans-fg :foreground ,yellowbeans-bg)))) ;; cursor color opposite to default
   `(region ((t (:background ,yellowbeans-gray-1)))) ;; visual mode and selection
   `(line-number ((t (:foreground ,yellowbeans-gray-2))))
   `(line-number-current-line ((t (:foreground ,yellowbeans-fg :weight bold))))
   `(show-paren-match ((t (:foreground ,yellowbeans-gold-yellow :background ,yellowbeans-black-4 :weight bold))))
   `(show-paren-mismatch ((t (:foreground ,yellowbeans-bad :weight bold))))
   `(isearch ((t (:background ,yellowbeans-gray-1 :foreground ,yellowbeans-fg :weight bold))))
   `(lazy-highlight ((t (:background ,yellowbeans-black-4))))
   `(hl-line ((t (:background ,yellowbeans-black-2 :extend t))))
   `(mode-line ((t (:background ,yellowbeans-black-2 :foreground ,yellowbeans-fg :box nil))))
   `(mode-line-inactive ((t (:background ,yellowbeans-black-2 :foreground ,yellowbeans-white-1 :box nil))))
   `(fringe ((t (:background ,yellowbeans-bg :foreground ,yellowbeans-gray-2))))

   `(highlight ((t (:background ,yellowbeans-neutral-bg))))
   `(success ((t (:foreground ,yellowbeans-good :weight bold))))
   `(warning ((t (:foreground ,yellowbeans-neutral :weight bold))))
   `(tooltip ((t (:foreground ,yellowbeans-fg :background ,yellowbeans-black-4))))

   ;; syntax highlighting
   `(font-lock-builtin-face ((t (:foreground ,yellowbeans-gold-yellow :weight bold))))
   `(font-lock-comment-face ((t (:foreground ,yellowbeans-gray-2 :slant italic))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,yellowbeans-gray-2 :slant italic))))
   `(font-lock-string-face ((t (:foreground ,yellowbeans-olive-green))))
   `(font-lock-doc-face ((t (:foreground ,yellowbeans-gray-2 :slant italic))))
   `(font-lock-doc-markup-face ((t (:foreground ,yellowbeans-gray-2 :slant italic))))
   `(font-lock-keyword-face ((t (:foreground ,yellowbeans-gold-yellow :weight bold))))
   `(font-lock-function-name-face ((t (:foreground ,yellowbeans-perano-blue))))
   `(font-lock-variable-name-face ((t (:foreground ,yellowbeans-lavender-purple))))
   `(font-lock-type-face ((t (:foreground ,yellowbeans-shipcove-blue))))
   `(font-lock-constant-face ((t (:foreground ,yellowbeans-moss-green))))
   `(font-lock-preprocessor-face ((t (:foreground ,yellowbeans-moss-green))))
   `(font-lock-warning-face ((t (:foreground ,yellowbeans-neutral))))
   `(font-lock-negation-char-face ((t (:foreground ,yellowbeans-gold-yellow :weight bold))))
   `(font-lock-function-call-face ((t (:inherit font-lock-function-name-face))))
   `(font-lock-number-face ((t (:inherit font-lock-constant-face))))
   `(font-lock-operator-face ((t (:inherit font-lock-keyword-face))))
   `(font-lock-property-name-face ((t (:foreground ,yellowbeans-dove-blue))))
   `(font-lock-property-use-face ((t (:foreground ,yellowbeans-dove-blue))))
   `(font-lock-bracket-face ((t (:foreground ,yellowbeans-hoki-blue))))
   `(font-lock-delimiter-face ((t (:foreground ,yellowbeans-hoki-blue))))
   `(font-lock-punctuation-face ((t (:foreground ,yellowbeans-white-2))))
   `(font-lock-escape-face ((t (:foreground ,yellowbeans-neutral :weight bold))))
   `(font-lock-regexp-face ((t (:inherit font-lock-string-face))))
   `(font-lock-label-face ((t (:foreground ,yellowbeans-neutral))))
   `(font-lock-macro-name-face ((t (:foreground ,yellowbeans-shipcove-blue))))
   `(font-lock-preprocessor-face ((t (:foreground ,yellowbeans-shipcove-blue))))

   ;; compilation
   `(compilation-column-face ((t (:foreground ,yellowbeans-gold-yellow))))
   `(compilation-enter-directory-face ((t (:foreground ,yellowbeans-moss-green))))
   `(compilation-error-face ((t (:foreground ,yellowbeans-bad :weight bold :underline t))))
   `(compilation-face ((t (:foreground ,yellowbeans-fg))))
   `(compilation-info-face ((t (:foreground ,yellowbeans-sky-blue))))
   `(compilation-info ((t (:foreground ,yellowbeans-olive-green :underline t))))
   `(compilation-leave-directory-face ((t (:foreground ,yellowbeans-olive-green))))
   `(compilation-line-face ((t (:foreground ,yellowbeans-gold-yellow))))
   `(compilation-line-number ((t (:foreground ,yellowbeans-gold-yellow))))
   `(compilation-message-face ((t (:foreground ,yellowbeans-dove-blue))))
   `(compilation-warning-face ((t (:foreground ,yellowbeans-neutral :weight bold :underline t))))
   `(compilation-mode-line-exit ((t (:foreground ,yellowbeans-moss-green :weight bold))))
   `(compilation-mode-line-fail ((t (:foreground ,yellowbeans-bad :weight bold))))
   `(compilation-mode-line-run ((t (:foreground ,yellowbeans-gold-yellow :weight bold))))

   ;; completions
   `(completions-annotations ((t (:foreground ,yellowbeans-fg))))
   `(completions-common-part ((t (:foreground ,yellowbeans-morningglory-blue :weight bold))))
   `(completions-first-difference ((t (:foreground ,yellowbeans-fg))))
   `(completions-group-title ((t (:foreground ,yellowbeans-moss-green :weight bold))))
   `(completions-group-separator ((t (:foreground ,yellowbeans-moss-green :strike-through t))))
   `(completions-highlight ((t (:background ,yellowbeans-black-2))))

   ;; eglot
   `(eglot-highlight-symbol-face
     ((t (:inherit font-lock-variable-name-face :weight bold))))
   `(eglot-mode-line
     ((t (:inherit font-lock-constant-face :weight bold))))

   ;; flymake
   `(flymake-error ((t (:underline (:color ,yellowbeans-bad :style wave)))))
   `(flymake-note ((t (:underline (:color ,yellowbeans-good :style wave)))))
   `(flymake-warning ((t (:underline (:color ,yellowbeans-neutral :style wave)))))


   ;; flyspell
   `(flyspell-duplicate ((t (:underline (:color ,yellowbeans-neutral :style wave)))))
   `(flyspell-incorrect ((t (:underline (:color ,yellowbeans-bad :style wave)))))

   ;; org
   `(org-document-title ((t (:foreground ,yellowbeans-gold-yellow :weight bold :height 1.4))))
   `(org-document-info ((t (:foreground ,yellowbeans-morningglory-blue))))
   `(org-document-info-keyword ((t (:foreground ,yellowbeans-gray-2 :slant italic))))

   `(org-level-1 ((t (:foreground ,yellowbeans-gold-yellow :weight bold :height 1.2))))
   `(org-level-2 ((t (:foreground ,yellowbeans-morningglory-blue :weight bold :height 1.1))))
   `(org-level-3 ((t (:foreground ,yellowbeans-olive-green :weight bold))))
   `(org-level-4 ((t (:foreground ,yellowbeans-lavender-purple :weight bold))))
   `(org-level-5 ((t (:foreground ,yellowbeans-shipcove-blue :weight bold))))
   `(org-level-6 ((t (:foreground ,yellowbeans-moss-green :weight bold))))
   `(org-level-7 ((t (:foreground ,yellowbeans-gold-yellow))))
   `(org-level-8 ((t (:foreground ,yellowbeans-white-1))))

   `(org-ellipsis ((t (:foreground ,yellowbeans-gray-3))))
   `(org-hide ((t (:foreground ,yellowbeans-bg))))

   `(org-code ((t (:foreground ,yellowbeans-shipcove-blue))))
   `(org-verbatim ((t (:foreground ,yellowbeans-perano-blue))))
   `(org-block ((t (:foreground ,yellowbeans-fg :background ,yellowbeans-black-2 :extend t))))
   `(org-block-begin-line ((t (:foreground ,yellowbeans-gray-2 :background ,yellowbeans-black-2 :slant italic :extend t))))
   `(org-block-end-line ((t (:foreground ,yellowbeans-gray-2 :background ,yellowbeans-black-2 :slant italic :extend t))))
   `(org-meta-line ((t (:foreground ,yellowbeans-gray-2 :slant italic))))
   `(org-document-info-keyword ((t (:foreground ,yellowbeans-gray-2 :slant italic))))
   `(org-special-keyword ((t (:foreground ,yellowbeans-gray-2 :slant italic))))

   `(org-quote ((t (:foreground ,yellowbeans-white-1 :background ,yellowbeans-black-2 :slant italic :extend t))))
   `(org-verse ((t (:foreground ,yellowbeans-white-1 :background ,yellowbeans-black-2 :slant italic :extend t))))

   `(org-link ((t (:foreground ,yellowbeans-olive-green :underline t))))
   `(org-date ((t (:foreground ,yellowbeans-moss-green :underline t))))
   `(org-footnote ((t (:foreground ,yellowbeans-lavender-purple :underline t))))

   `(org-table ((t (:foreground ,yellowbeans-olive-green))))
   `(org-formula ((t (:foreground ,yellowbeans-perano-blue))))

   `(org-tag ((t (:foreground ,yellowbeans-white-2 :weight bold))))
   `(org-property-value ((t (:foreground ,yellowbeans-white-1))))
   `(org-column ((t (:background ,yellowbeans-black-2))))
   `(org-column-title ((t (:background ,yellowbeans-black-2 :underline t :weight bold))))

   `(org-todo ((t (:foreground ,yellowbeans-neutral :weight bold))))
   `(org-done ((t (:foreground ,yellowbeans-good :weight bold))))
   `(org-headline-done ((t (:foreground ,yellowbeans-gray-3))))
   `(org-warning ((t (:foreground ,yellowbeans-bad :weight bold))))
   `(org-upcoming-deadline ((t (:foreground ,yellowbeans-neutral :weight bold))))
   `(org-deadline-announce ((t (:foreground ,yellowbeans-neutral))))
   `(org-deadline-close ((t (:foreground ,yellowbeans-good))))
   `(org-scheduled ((t (:foreground ,yellowbeans-moss-green))))
   `(org-scheduled-today ((t (:foreground ,yellowbeans-good :weight bold))))
   `(org-scheduled-previously ((t (:foreground ,yellowbeans-neutral))))
   `(org-imminent-deadline ((t (:foreground ,yellowbeans-bad :weight bold))))

   `(org-agenda-date ((t (:foreground ,yellowbeans-morningglory-blue :weight bold))))
   `(org-agenda-date-today ((t (:foreground ,yellowbeans-gold-yellow :weight bold :height 1.1))))
   `(org-agenda-date-weekend ((t (:foreground ,yellowbeans-white-1 :weight bold))))
   `(org-agenda-structure ((t (:foreground ,yellowbeans-lavender-purple :weight bold))))
   `(org-agenda-done ((t (:foreground ,yellowbeans-gray-3))))
   `(org-time-grid ((t (:foreground ,yellowbeans-moss-green))))

   `(org-checkbox ((t (:foreground ,yellowbeans-morningglory-blue :weight bold))))
   `(org-checkbox-statistics-todo ((t (:foreground ,yellowbeans-neutral :weight bold))))
   `(org-checkbox-statistics-done ((t (:foreground ,yellowbeans-good :weight bold))))

   `(org-priority ((t (:foreground ,yellowbeans-bad :weight bold))))
   `(org-sexp-date ((t (:foreground ,yellowbeans-moss-green))))

   ;; doom-modeline
   `(doom-modeline ((t (:inherit mode-line))))
   `(doom-modeline-inactive ((t (:inherit mode-line-inactive))))
   `(doom-modeline-emphasis ((t (:foreground ,yellowbeans-morningglory-blue :weight bold))))
   `(doom-modeline-highlight ((t (:foreground ,yellowbeans-lavender-purple))))
   `(doom-modeline-buffer-path ((t (:foreground ,yellowbeans-white-2))))
   `(doom-modeline-buffer-file ((t (:foreground ,yellowbeans-fg :weight bold))))
   `(doom-modeline-buffer-modified ((t (:foreground ,yellowbeans-gold-yellow :weight bold))))
   `(doom-modeline-buffer-major-mode ((t (:foreground ,yellowbeans-morningglory-blue :weight bold))))
   `(doom-modeline-buffer-minor-mode ((t (:foreground ,yellowbeans-gray-2))))
   `(doom-modeline-project-parent-dir ((t (:foreground ,yellowbeans-white-2))))
   `(doom-modeline-project-dir ((t (:foreground ,yellowbeans-shipcove-blue :weight bold))))
   `(doom-modeline-project-root-dir ((t (:foreground ,yellowbeans-fg))))
   `(doom-modeline-project-name ((t (:foreground ,yellowbeans-morningglory-blue :weight bold))))
   `(doom-modeline-panel ((t (:foreground ,yellowbeans-bg :background ,yellowbeans-gold-yellow))))
   `(doom-modeline-host ((t (:foreground ,yellowbeans-lavender-purple :slant italic))))
   `(doom-modeline-input-method ((t (:foreground ,yellowbeans-neutral :weight bold))))
   `(doom-modeline-debug ((t (:foreground ,yellowbeans-neutral))))
   `(doom-modeline-info ((t (:foreground ,yellowbeans-perano-blue))))
   `(doom-modeline-warning ((t (:foreground ,yellowbeans-gold-yellow :weight bold))))
   `(doom-modeline-urgent ((t (:foreground ,yellowbeans-bad :weight bold))))
   `(doom-modeline-notification ((t (:foreground ,yellowbeans-neutral))))
   `(doom-modeline-unread-number ((t (:foreground ,yellowbeans-fg :weight bold))))
   `(doom-modeline-bar ((t (:background ,yellowbeans-gold-yellow))))
   `(doom-modeline-bar-inactive ((t (:background ,yellowbeans-black-4))))
   `(doom-modeline-evil-emacs-state ((t (:foreground ,yellowbeans-lavender-purple :weight bold))))
   `(doom-modeline-evil-insert-state ((t (:foreground ,yellowbeans-olive-green :weight bold))))
   `(doom-modeline-evil-motion-state ((t (:foreground ,yellowbeans-morningglory-blue :weight bold))))
   `(doom-modeline-evil-normal-state ((t (:foreground ,yellowbeans-perano-blue :weight bold))))
   `(doom-modeline-evil-operator-state ((t (:foreground ,yellowbeans-lavender-purple :weight bold))))
   `(doom-modeline-evil-visual-state ((t (:foreground ,yellowbeans-gold-yellow :weight bold))))
   `(doom-modeline-evil-replace-state ((t (:foreground ,yellowbeans-bad :weight bold))))

   `(doom-modeline-overwrite ((t (:foreground ,yellowbeans-bad :weight bold))))
   `(doom-modeline-workspace-name ((t (:foreground ,yellowbeans-lavender-purple))))
   `(doom-modeline-persp-name ((t (:foreground ,yellowbeans-perano-blue :weight bold))))
   `(doom-modeline-persp-buffer-not-in-persp ((t (:foreground ,yellowbeans-white-2 :slant italic))))
   `(doom-modeline-repl-success ((t (:foreground ,yellowbeans-good :weight bold))))
   `(doom-modeline-repl-warning ((t (:foreground ,yellowbeans-gold-yellow :weight bold))))
   `(doom-modeline-vcs-default ((t (:foreground ,yellowbeans-white-2))))
   `(doom-modeline-lsp-success ((t (:foreground ,yellowbeans-good :weight bold))))
   `(doom-modeline-lsp-warning ((t (:foreground ,yellowbeans-gold-yellow :weight bold))))
   `(doom-modeline-lsp-error ((t (:foreground ,yellowbeans-bad :weight bold))))
   `(doom-modeline-lsp-running ((t (:foreground ,yellowbeans-neutral))))
   `(doom-modeline-battery-charging ((t (:foreground ,yellowbeans-good))))
   `(doom-modeline-battery-full ((t (:foreground ,yellowbeans-good))))
   `(doom-modeline-battery-normal ((t (:foreground ,yellowbeans-white-2))))
   `(doom-modeline-battery-warning ((t (:foreground ,yellowbeans-gold-yellow :weight bold))))
   `(doom-modeline-battery-critical ((t (:foreground ,yellowbeans-bad :weight bold))))
   `(doom-modeline-battery-error ((t (:foreground ,yellowbeans-bad :weight bold))))
   `(doom-modeline-time ((t (:foreground ,yellowbeans-gray-3))))
   `(doom-modeline-compilation ((t (:foreground ,yellowbeans-neutral :weight bold))))
   
   ;; markdown
   `(markdown-header-face ((t (:foreground ,yellowbeans-gold-yellow :weight bold))))
   `(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.2))))
   `(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.1))))
   `(markdown-header-face-3 ((t (:inherit markdown-header-face))))
   `(markdown-header-face-4 ((t (:inherit markdown-header-face))))
   `(markdown-header-face-5 ((t (:inherit markdown-header-face))))
   `(markdown-header-face-6 ((t (:inherit markdown-header-face))))
   `(markdown-bold-face ((t (:weight bold))))
   `(markdown-italic-face ((t (:slant italic))))
   `(markdown-inline-code-face ((t (:foreground ,yellowbeans-shipcove-blue))))
   `(markdown-code-face ((t (:background ,yellowbeans-black-2))))
   `(markdown-pre-face ((t (:inherit markdown-code-face))))
   `(markdown-link-face ((t (:foreground ,yellowbeans-olive-green))))
   `(markdown-url-face ((t (:foreground ,yellowbeans-shipcove-blue))))))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-directory load-file-name)))

(provide-theme 'yellowbeans)
;;; yellowbeans-theme.el ends here
