;;; $DOOMDIR/packages.el

(package! copilot
  :recipe (:host github :repo "copilot-emacs/copilot.el" :files ("*.el")))

(package! org-download)

(package! ob-rust)

(package! jinx)

(package! org-fragtog)

(package! eglot-booster
  :recipe (:host github :repo "jdtsmith/eglot-booster"))
