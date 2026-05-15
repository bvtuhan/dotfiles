;;; init-remote.el --- Description -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package tramp
  :ensure nil ;; built-in
  :defer t ;; do not load it during startup
  :config
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
  (add-to-list 'tramp-remote-path "/home/debian/.cargo/bin"))


;; keybindings are defined in `init-general.el'
(use-package crdt
  :ensure t
  :defer t
  :commands (crdt-share-buffer
             crdt-stop-share-buffer
             crdt-connect
             crdt-disconnect
             crdt-list-buffers
             crdt-switch-to-buffer
             crdt-list-users
             crdt-follow-user
             crdt-stop-follow
             crdt-goto-user
             crdt-goto-next-user
             crdt-goto-prev-user
             crdt-list-sessions
             crdt-stop-session
             crdt-kill-user
             crdt-copy-url)
  :custom
  ;; (crdt-default-port 6530)
  (crdt-username user-full-name))


(provide 'init-remote)
;;; init-remote.el ends here
