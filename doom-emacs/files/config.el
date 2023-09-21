;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")
(setq user-full-name "Artem Timofeev")
;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(setq doom-font (font-spec :family "DejaVuSansM Nerd Font Mono" :size 13 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "DejaVuSansM Nerd Font Mono" :size 14))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Enable mouse and select-to-copy in tty
(unless (display-graphic-p)
  (xterm-mouse-mode 1)
  (setq mouse-drag-copy-region t)
)

;; Fine undo
(setq evil-want-fine-undo t)

;; FIXME Force move cursor to EOL ($)
(define-key evil-normal-state-map (kbd "$") 'evil-end-of-line)
(define-key evil-visual-state-map (kbd "$") 'evil-end-of-line)
(define-key evil-motion-state-map (kbd "$") 'evil-end-of-line)

;; FIXME Disable overwrite mode (insert key)
(define-key global-map [(insert)] nil)

;;(global-set-key (kbd "C-S-a") 'mc/edit-lines)

(global-set-key (kbd "C-M-<up>") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-M-<down>") 'mc/mark-next-like-this)

;;(map! :n "C-M-<up>" #'mc/mark-previous-like-this)
;;(map! :n "C-M-<down>" #'mc/mark-next-like-this)


;; Orgmode settings
;;(setq org-startup-with-inline-images t) ;; Render images (only works in GUI mode)
(setq company-global-modes '(not text-mode org-mode)) ;; Disable autocomplete for regular typing
(setq org-blank-before-new-entry (quote ((heading . nil) ;; Disable newlines before new list entries
                                         (plain-list-item . nil))))
(setq org-log-done 'time) ;; Insert timestamp on TODO completion
;;(setq org-log-done 'note) ;; Insert note with timestamp on TODO completion

;; org mode hook to use packages in org files
(add-hook! 'org-mode-hook
  (org-autolist-mode) ;; autolist
  ;;(org-auto-tangle-mode)
  )

(add-hook! 'after-save-hook
  (org-babel-tangle))
;;
;; ignore code block:
;; +BEGIN_SRC emacs-lisp :tangle no


(setq org-support-shift-select t)

;; Set bash as shell
(setq shell-file-name (executable-find "bash"))
