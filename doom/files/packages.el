;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el
;(package! beacon)              ; cursor highlighting
(package! imenu-list)          ; listing of file structure
(package! mwim)                ; ident/comment-aware cursor movements with <home>/<end>
(package! org-roam-timestamps) ; +c/mtime to PROPERTIES drawer in org-roam file
(package! org-roam-ui)         ; web ui for org-roam
(package! expand-region)       ; increase selected region by semantic units
(unpin! lsp-treemacs)          ; fix lsp-headerline-breadcrumb icons (???why)
(package! indent-bars          ; better and faster indentation (still broken in 29.1 PGTK, waiting for 30+)
  :recipe (:host github :repo "jdtsmith/indent-bars"))
(package! kubel-evil)          ; control k8s, with evil KB
(package! gptel)               ; chatgpt interface via API
(package! gptel-extensions     ; extended functionality
  :recipe (:host github :repo "kamushadenes/gptel-extensions.el"
                 :files ("gptel-extensions.el")))
(package! jenkinsfile-mode)    ; jenkinsfile support
