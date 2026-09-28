;;; init-scripts.el --- Custom Helper Scripts -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun bibtex-paste ()
  "Add the yanked BibTeX entry to the references.bib file located in the current working directory."
  (interactive)
  (when (not (file-exists-p "references.bib"))
    (make-empty-file "references.bib"))
  (let ((file-path "references.bib")
        (text-to-append (current-kill 0)))
    (write-region (concat "\n" text-to-append) nil file-path t)))


(provide 'init-scripts)
;;; init-scripts.el ends here
