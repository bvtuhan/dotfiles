;;; init-hdl.el --- Description -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package vhdl-mode
  :ensure nil
  :custom
  (vhdl-modify-date-on-saving nil))

;; cargo install vhdl_lang
;; cargo install vhdl_ls
;; yay -S ghdl

;; git clone --depth 1 --branch v0.88.0 \
;;           https://github.com/VHDL-LS/rust_hdl.git /tmp/rust_hdl
;; cp -a /tmp/rust_hdl/vhdl_libraries ~/.cargo/

(use-package vhdl-ext
  :hook ((vhdl-mode . vhdl-ext-mode))
  :init
  (setq vhdl-ext-feature-list
        '(font-lock
          xref
          capf
          hierarchy
          eglot
          flycheck
          beautify
          navigation
          template
          compilation
          imenu
          which-func
          hideshow
          time-stamp
          ports))
  :custom
  (vhdl-ext-eglot-set-server 've-rust-hdl)
  :config
  (vhdl-ext-mode-setup))

(provide 'init-hdl)
;;; init-hdl.el ends here
