;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; == GENERAL SETTINGS ==
(setq
 user-full-name "Artem Timofeev"
 doom-font (font-spec :family "DejaVuSansM Nerd Font Mono" :size 13 :weight 'semi-light)
 doom-theme 'doom-one
 shell-file-name (executable-find "bash") ;; use bash shell
 evil-want-fine-undo t ;; undo in small steps
 display-line-numbers-type t ;; show line numbers
 mouse-drag-copy-region t ;; select-to-copy with mouse
 confirm-kill-emacs nil ;; quit without prompt
 company-global-modes '(not text-mode org-mode markdown-mode) ;; disable autocomplete for plain text
 global-auto-revert-non-file-buffers t ;; auto-update non-file buffers (e.g. file listing)
 scroll-margin 3 ;; add margin to cursor while scrolling
 treemacs-project-follow-mode t ;; treemacs: show currently opened project
 imenu-list-focus-after-activation t ;; imenu-list: window auto-focus
 imenu-list-auto-resize t ;; imenu-list: windown auto-size (is it working?)
 imenu-auto-rescan t ;; imenu-list: auto-refresh
 imenu-auto-rescan-maxout (* 1024 1024) ;; imenu-list: limit auto-refresh to max filesize
;; imenu--rescan-item '("" . -99) ;; imenu-list: removes `rescan' item. not sure if this is needed
)
(unless (display-graphic-p)
  (xterm-mouse-mode 1) ;; enable mouse in CLI mode
)
(beacon-mode 1) ;; cursor highlight on big movements or between windows
(global-auto-revert-mode 1) ;; auto-update changed files

;; == ORG-MODE ==
(setq
 org-directory "~/org/" ;; org-agenda and other org tools will work upon this dir
 org-support-shift-select t ;; enable select with S-<arrows>
 org-startup-folded "content" ;; startup with everything unfolded except lowest sub-sections
;; org-startup-with-inline-images t ;; Render images (only GUI mode)
 org-blank-before-new-entry (quote ((heading . nil) ;; no empty lines on betwen new list entries
                                    (plain-list-item .nil)))
)
(add-hook! 'after-save-hook (org-babel-tangle)) ;; export org code blocks on save
(add-hook! 'org-mode-hook
  (display-line-numbers-mode 0) ;; disable lines numbers for org-mode
  (org-autolist-mode) ;; autolist
)

;; == GENERAL KEYMAPS ==
;; Multiple cursors VSCode-like behavior; C-g to exit
(global-set-key (kbd "C-M-<up>") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-M-<down>") 'mc/mark-next-like-this)
(unbind-key "<insertchar>" overwrite-mode) ;; disable overwrite mode on Insert key
(map! :leader
      (:prefix ("t". "toggle")
       :desc "Treemacs"   "t" #'treemacs ;; open project tree
       :desc "imenu-list" "i" #'imenu-list-smart-toggle ;; open file overview
       ))

;; == BUFFER KEYMAPS ==
(map! :leader
      (:prefix ("b". "buffer")
       :desc "New buffer"         "n"       #'evil-buffer-new
       :desc "Save buffer"        "s"       #'save-buffer
       :desc "Switch buffer"      "b"       #'consult-buffer
       :desc "Next buffer"        "<right>" #'next-buffer
       :desc "Previous buffer"    "<left>"  #'previous-buffer
       :desc "Kill buffer"        "d"       #'kill-current-buffer
       :desc "Kill other buffers" "k"       #'doom/kill-other-buffers
       :desc "Kill all buffers"   "K"       #'doom/kill-all-buffers))

;; == EVIL-WINDOWS KEYMAPS ==
(map! :leader
      (:prefix ("w". "window")
       :desc "New window, up"           "n"             #'evil-window-new
       :desc "New window, left"         "N"             #'evil-window-vnew

       :desc "Split view, right"        "s"             #'evil-window-split
       :desc "Split view, down"         "v"             #'evil-window-vsplit
       ;; uses same buffer

       :desc "Select LEFT window"       "<left>"        #'evil-window-left
       :desc "Select DOWN window"       "<down>"        #'evil-window-down
       :desc "Select UP window"         "<up>"          #'evil-window-up
       :desc "Select RIGHT window"      "<right>"       #'evil-window-right

       :desc "Move window LEFT"         "S-<left>"      #'+evil/window-move-left
       :desc "Move window DOWN"         "S-<down>"      #'+evil/window-move-down
       :desc "Move window UP"           "S-<up>"        #'+evil/window-move-up
       :desc "Move window RIGHT"        "S-<right>"     #'+evil/window-move-right

       :desc "Maximize window"          "m m"           #'doom/window-maximize-buffer
       ;; close all other windows
       :desc "Maximize vertically"      "m v"           #'doom/window-maximize-vertically
       ;; close all windows UP/DOWN
       :desc "Maximize horizontally"    "m s"           #'doom/window-maximize-horizontally
       ;; close all windown LEFT/RIGHT

       :desc "Close window"             "c"             #'evil-window-delete
       :desc "Kill buffer & window"     "d"             #'kill-buffer-and-window))
