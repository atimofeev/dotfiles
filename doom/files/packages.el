;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el
(package! beacon)              ; cursor highlighting
(package! imenu-list)          ; listing of file structure
(package! mwim)                ; ident/comment-aware cursor movements with <home>/<end>
(package! org-roam-timestamps) ; +c/mtime to PROPERTIES drawer in org-roam file
(package! org-roam-ui)         ; web ui for org-roam
(package! expand-region)       ; increase selected region by semantic units
(package! indent-bars
  :recipe (:host github :repo "jdtsmith/indent-bars"))
(unpin! lsp-treemacs)          ; fix lsp-headerline-breadcrumb icons (???why)
