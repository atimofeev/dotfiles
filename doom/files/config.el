;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "Artem Timofeev")
(setq doom-font (font-spec :family "DejaVuSansM Nerd Font Mono" :size 13 :weight 'semi-light))
(setq doom-theme 'doom-one)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")

(setq shell-file-name (executable-find "bash")) ;; use bash shell
(setq evil-want-fine-undo t) ;; undo in small steps
;; Multiple cursors VSCode-like behavior; C-g to exit
;; Had to unbind these:
;; gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['']"
;; gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['']"
(global-set-key (kbd "C-M-<up>") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-M-<down>") 'mc/mark-next-like-this)
;; Auto update open files which were externally changed
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)
;; Enable cursor line highlight
(beacon-mode 1)

(unless (display-graphic-p)
  (xterm-mouse-mode 1) ;; enable mouse
  (setq mouse-drag-copy-region t) ;; mouse select-to-copy
)

(setq org-support-shift-select t)
;;(setq org-startup-with-inline-images t) ;; Render images (only GUI mode)
(setq company-global-modes '(not text-mode org-mode)) ;; Disable autocomplete for regular typing
(setq org-blank-before-new-entry (quote ((heading . nil) ;; Disable newlines before new list entries
                                         (plain-list-item . nil))))
(setq org-log-done 'time) ;; Insert timestamp on TODO completion
;;(setq org-log-done 'note) ;; Insert note with timestamp on TODO completion
(add-hook! 'org-mode-hook
  (org-autolist-mode)) ;; autolist
(add-hook! 'after-save-hook
  (org-babel-tangle)) ;; generate config file from .org on save
