# README

A small cheat sheet for my understanding how **Emacs** works

## **Common `use-package` Keyword Pairs**

### **`:init`**

Executed **before the package is loaded**, usually for setting variables.

```elisp
(use-package vertico
  :init
  (vertico-mode))
```

---

### **`:config`** (Important)

Executed **after** the package is loaded.

```elisp
(use-package magit
  :config
  (setq magit-display-buffer-function
        #'magit-display-buffer-fullframe-status-v1))
```

---

### **`:hook`**

Used instead of `add-hook`. Adds functions to mode hooks.

```elisp
(use-package python
  :hook (python-mode . my-python-setup))
```

Multiple hooks:

```elisp
:hook ((prog-mode . display-line-numbers-mode)
       (text-mode . flyspell-mode))
```

---

### **`:bind`**

Creates keybindings.

```elisp
:bind ("C-c g" . magit-status)
```

Or within keymaps:

```elisp
:bind (:map org-mode-map
            ("C-c c" . org-capture))
```

---

### **`:custom`** (Important)

Sets variables (like `setq`, but cleaner and integrates with Customize).

```elisp
:custom
(company-idle-delay 0.1)
(company-minimum-prefix-length 1)
```

---

### **`:commands`**

Autoloads commands without loading the package immediately.

```elisp
:commands (flycheck-mode flycheck-list-errors)
```

---

### **`:after`**

Load this package only after another package.

```elisp
:after (org)
```

---

### **`:mode`**

Associates file patterns with major modes.

```elisp
:mode ("\\.py\\'" . python-mode)
```

---

### **`:ensure`**

Automatically installs the package if needed.

```elisp
:ensure t
```
---

## `use-package` + `with-eval-after-load` Combination

With `use-package` you can just install the package. You do not have to make any
configuration.

`with-eval-after-load` runs its body whenever the package that you have installed via `use-package`
is loaded.

So this:

```eslip
(use-package rustic
  :ensure t
  :config
  (setq rustic-lsp-client 'eglot))
```

and this:

```elisp
(use-package rustic
  :ensure t)

(with-eval-after-load 'rustic
  (setq rustic-lsp-client 'eglot))
```

_conceptually_ is almost the same thing.

### Emulate the keyword pairs of `use-package` in `with-eval-after-load` / `require`

| `use-package` keyword | Rough manual equivalent                              |
|-----------------------|------------------------------------------------------|
| `:init`               | Top-level code **before** `(require 'pkg)`          |
| `:config`             | `(with-eval-after-load 'pkg ...)`                   |
| `:hook (m . f)`       | `(add-hook 'm-hook #'f)`                            |
| `:bind`               | `global-set-key` / `keymap-set` / `define-key`      |
| `:mode ("\\.x\\'" . m)` | `(add-to-list 'auto-mode-alist '("\\.x\\'" . m))` |
| `:custom (var val)`   | `(customize-set-variable 'var val)` or `(setq var val)` |
| `:commands (foo)`     | `(autoload 'foo "pkg-file" nil t)` (or rely on autoloads) |
| `:after other`        | `(with-eval-after-load 'other (require 'pkg) ...)`  |

So this `use-package` configuration:

```elsip
(use-package rustic
  :ensure t
  :mode ("\\.rs\\'" . rustic-mode)
  :hook (rustic-mode . eglot-ensure)
  :custom
  (rustic-lsp-client 'eglot)
  :bind
  (:map rustic-mode-map
        ("C-c C-c" . rustic-compile))
  :config
  (message "Rustic loaded!"))
```

Can be written in `with-eval-after-load`:

```elisp
;; install could be manual, via package-list-packages, straight.el, etc.
;; assume rustic is installed

;; 1) :mode
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rustic-mode))

;; 2) :init  (code that must run before rustic loads)
;; (often not needed for rustic, but for other packages:)
;; (setq some-variable t)

;; 3) everything that would be under :config / :hook / :bind
(with-eval-after-load 'rustic
  ;; :custom
  (setq rustic-lsp-client 'eglot)

  ;; :hook (rustic-mode . eglot-ensure)
  (add-hook 'rustic-mode-hook #'eglot-ensure)

  ;; :bind (:map rustic-mode-map ("C-c C-c" . rustic-compile))
  (define-key rustic-mode-map (kbd "C-c C-c") #'rustic-compile)

  ;; :config body
  (message "Rustic loaded!"))
```

Or you can also use `require` to configure it:

```elisp
;; Load the package immediately
(require 'rustic)

;; :custom
(setq rustic-lsp-client 'eglot)

;; :hook (rustic-mode . eglot-ensure)
(add-hook 'rustic-mode-hook #'eglot-ensure)

;; :bind (:map rustic-mode-map ("C-c C-c" . rustic-compile))
(define-key rustic-mode-map (kbd "C-c C-c") #'rustic-compile)

;; :config body
(message "Rustic loaded!")
```

## Doom Config to Vanilla Emacs

This doom configuration for `org-download` package:

```elisp
;;org-download
(use-package! org-download
  :config
  (add-hook 'dired-mode-hook #'org-download-enable))
;; Optional: Set image directory
(setq-default org-download-image-dir "./images")
;; Paste image from clipboard with Ctrl+Alt+V
(map! "C-M-v" #'org-download-clipboard)
```

can be converted in vanilla version like this:

```elisp
;; Make sure use-package is installed and required earlier in your init.el

(use-package org-download
  :ensure t
  :hook
  (dired-mode . org-download-enable)   ;; like your add-hook
  :custom
  (org-download-image-dir "./images")  ;; same as setq-default
  :bind
  ("C-M-v" . org-download-clipboard))  ;; like map!
```

Or you can use `require` / `with-eval-after-load`

```elsip
;; org-download
(require 'org-download)  ;; assuming it's installed via package.el, straight, etc.

;; Enable org-download in dired
(add-hook 'dired-mode-hook #'org-download-enable)

;; Optional: Set image directory
(setq-default org-download-image-dir "./images")

;; Paste image from clipboard with Ctrl+Alt+V
(global-set-key (kbd "C-M-v") #'org-download-clipboard)
```
