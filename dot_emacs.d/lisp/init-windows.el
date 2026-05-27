;;; init-windows.el --- Description -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(let ((msys-paths
       '("C:/msys64/ucrt64/bin"
         "C:/msys64/usr/bin")))

  (setenv "PATH"
          (concat (mapconcat #'identity msys-paths ";")
                  ";"
                  (getenv "PATH")))

  (dolist (p msys-paths)
    (add-to-list 'exec-path p)))

(setq
 read-process-output-max (* 1024 1024)
 process-adaptive-read-buffering nil
 process-connection-type nil)

(setq
 auto-mode-case-fold nil
 inhibit-compacting-font-caches t
 fast-but-imprecise-scrolling t
 jit-lock-defer-time 0.05)

(when (boundp 'w32-pipe-read-delay)
  (setq w32-pipe-read-delay 0))

(when (boundp 'w32-pipe-buffer-size)
  (setq w32-pipe-buffer-size (* 256 1024)))

(when (boundp 'w32-get-true-file-attributes)
  (setq w32-get-true-file-attributes 'local))

(provide 'init-windows)
;;; init-windows.el ends here
