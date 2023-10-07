;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;; == GENERAL SETTINGS ==
(setq
 user-full-name "Artem Timofeev"
 doom-font (font-spec :family "DejaVuSansM Nerd Font Mono" :size 15 :weight 'semi-light)
 doom-theme 'doom-one
 display-line-numbers-type t                                     ; show line numbers
 mouse-drag-copy-region t                                        ; select-to-copy with mouse
 confirm-kill-emacs nil                                          ; quit without prompt
 company-global-modes '(not text-mode org-mode markdown-mode)    ; disable autocomplete for plain text
 scroll-margin 3                                                 ; add margin to cursor while scrolling
 projectile-project-search-path '("~/repos/")                    ;
 global-auto-revert-non-file-buffers t                           ; auto-update non-file buffers (e.g. Dired)
)
(global-auto-revert-mode 1)                                      ; auto-update changed files
(beacon-mode 1)                                                  ; cursor highlight on big movements or between windows

(global-set-key (kbd "C-M-<up>")   'mc/mark-previous-like-this)  ; spawn additional cursor above; C-g to exit
(global-set-key (kbd "C-M-<down>") 'mc/mark-next-like-this)      ; spawn additional cursor below
(unbind-key "<insertchar>" overwrite-mode)                       ; disable overwrite mode on Insert key
(map! :leader
      (:prefix ("t". "toggle")
       :desc "vterm popup"              "s"     #'+vterm/toggle  ; open shell popup
       :desc "vterm window"             "S"     #'+vterm/here    ; open shell in current window
       ))

;;; == CUSTOM FUNCTIONS ==

(evil-define-command custom/write-and-sync (file &optional bang)
  "Write the current buffer and then execute doom sync."
  :repeat nil
  (interactive "<f><!>")
  (evil-write nil nil nil file bang)
  (doom/reload))

(evil-define-command custom/write-and-quit (file &optional bang)
  "Write the current buffer and then kill buffer."
  :repeat nil
  (interactive "<f><!>")
  (evil-write nil nil nil file bang)
  (kill-current-buffer))

(evil-define-command custom/kill-buffer (&optional bang)
  "Kill buffer. With bang '!' - kill without prompt."
  :repeat nil
  (interactive "<!>")
  (if bang
      (progn
        (set-buffer-modified-p nil)))
  (kill-current-buffer))

(defun aborn/backward-kill-word ()
  "Customize/Smart backward-kill-word."
  (interactive)
  (let* ((cp (point))
         (backword)
         (end)
         (space-pos)
         (backword-char (if (bobp)
                            ""           ;; cursor in begin of buffer
                          (buffer-substring cp (- cp 1)))))
    (if (equal (length backword-char) (string-width backword-char))
        (progn
          (save-excursion
            (setq backword (buffer-substring (point) (progn (forward-word -1) (point)))))
          (setq ab/debug backword)
          (save-excursion
            (when (and backword          ;; when backword contains space
                       (s-contains? " " backword))
              (setq space-pos (ignore-errors (search-backward " ")))))
          (save-excursion
            (let* ((pos (ignore-errors (search-backward-regexp "\n")))
                   (substr (when pos (buffer-substring pos cp))))
              (when (or (and substr (s-blank? (s-trim substr)))
                        (s-contains? "\n" backword))
                (setq end pos))))
          (if end
              (kill-region cp end)
            (if space-pos
                (kill-region cp space-pos)
              (backward-kill-word 1))))
      (kill-region cp (- cp 1)))         ;; word is non-english word
    ))

(defun custom/align-comments (beginning end)
  "Align comments within marked region.
Comment syntax detection is automatic"
  (interactive "*r")
  (align-regexp beginning end (concat "\\(\\s-*\\)" (regexp-quote comment-start))))

;;; == BUFFER KEYMAPS ==
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

;;; == DOOM-MODELINE ==
(use-package! doom-modeline
  :config
  (display-time-mode 1)        ; show time in modeline
  :custom
  (display-time-24hr-format t) ; show time in 24h format
  ;; disable modal icons and set custom evil-state tags to make them more noticeable
  (doom-modeline-modal-icon nil)
  (evil-normal-state-tag   (propertize "[Normal]"))
  (evil-emacs-state-tag    (propertize "[Emacs]" ))
  (evil-insert-state-tag   (propertize "[Insert]"))
  (evil-motion-state-tag   (propertize "[Motion]"))
  (evil-visual-state-tag   (propertize "[Visual]"))
  (evil-operator-state-tag (propertize "[Operator]"))
  )

;; setting up custom FG/BG colors to further increace visibility of evil-state
(defun setup-doom-modeline-evil-states ()
  (set-face-attribute 'doom-modeline-evil-normal-state   nil :background "lawngreen" :foreground "black")
  (set-face-attribute 'doom-modeline-evil-emacs-state    nil :background "orange"    :foreground "black")
  (set-face-attribute 'doom-modeline-evil-insert-state   nil :background "red2"      :foreground "white")
  (set-face-attribute 'doom-modeline-evil-motion-state   nil :background "blue"      :foreground "white")
  (set-face-attribute 'doom-modeline-evil-visual-state   nil :background "gray80"    :foreground "black")
  (set-face-attribute 'doom-modeline-evil-operator-state nil :background "blueviolet"))
(add-hook 'doom-modeline-mode-hook 'setup-doom-modeline-evil-states)

;;; == ELFEED ==
(setq elfeed-goodies/entry-pane-size 0.5)
(setq elfeed-feeds  '(("https://www.reddit.com/r/linux.rss" reddit linux)
                     ("https://www.reddit.com/r/commandline.rss" reddit commandline)
                     ("https://www.reddit.com/r/emacs.rss" reddit emacs)
                     ("https://www.gamingonlinux.com/article_rss.php" gaming linux)
                     ("https://hackaday.com/blog/feed/" hackaday linux)
                     ("https://opensource.com/feed" opensource linux)
                     ("https://linux.softpedia.com/backend.xml" softpedia linux)
                     ("https://itsfoss.com/feed/" itsfoss linux)
                     ("https://www.zdnet.com/topic/linux/rss.xml" zdnet linux)
                     ("https://www.phoronix.com/rss.php" phoronix linux)
                     ("http://feeds.feedburner.com/d0od" omgubuntu linux)
                     ("https://www.computerworld.com/index.rss" computerworld linux)
                     ("https://www.networkworld.com/category/linux/index.rss" networkworld linux)
                     ("https://www.techrepublic.com/rssfeeds/topic/open-source/" techrepublic linux)
                     ("https://betanews.com/feed" betanews linux)
                     ("http://lxer.com/module/newswire/headlines.rss" lxer linux)
                     ("http://highscalability.com/blog/rss.xml" highscal sysdes)
                     ("https://blog.acolyer.org/feed/" mornpaper sysdes)
                     ("https://www.infoq.com/architecture-design/rss" infoq sysdes)
                     ("https://dzone.com/devops-tutorials-tools-news/list.rss" dzone devops)
                     ("https://devops.com/feed/" devops)
                     ("https://thenewstack.io/feed/" newstack devops)
                     ("http://feeds.arstechnica.com/arstechnica/index" arstech tech)
                     ("https://techcrunch.com/feed/" techcrunch tech)))
(evil-define-key 'normal elfeed-show-mode-map
  (kbd "S-<down>") 'elfeed-goodies/split-show-next
  (kbd "S-<up>") 'elfeed-goodies/split-show-prev)
(evil-define-key 'normal elfeed-search-mode-map
  (kbd "S-<down>") 'elfeed-goodies/split-show-next
  (kbd "S-<up>") 'elfeed-goodies/split-show-prev)

;;; == EMACS TTY ==
(unless (display-graphic-p)
  (xterm-mouse-mode 1)                               ; enable mouse in TTY mode
  (setq lsp-headerline-breadcrumb-icons-enable nil)  ; these icons are PNG
;;  (map! :after evil-org                            ; TTY resolves 'C-backspace' into 'C-h'
;;        :map evil-org-mode-map                     ; if your terminal does not support it
;;        :i "C-h" nil)                              ; enable these lines for hack. define-key too ↴
;;  (define-key evil-insert-state-map (kbd "C-h") 'aborn/backward-kill-word)
)

;;; == EVIL MODE ==
;(define-key evil-motion-state-map ";" #'evil-ex)                                    ; swap : and ;
;(define-key evil-motion-state-map ":" #'evil-snipe-repeat)
(setq evil-want-fine-undo t)                                                         ; undo in small steps
(global-set-key          (kbd "C-<backspace>")     'aborn/backward-kill-word)        ; smarter C-backspace
(define-key evil-ex-completion-map (kbd "C-v")     'evil-paste-after)                ; C-v to paste
(define-key evil-ex-search-keymap  (kbd "C-v")     'evil-paste-after)
(define-key evil-normal-state-map  (kbd "C-v")     'evil-paste-after)
(define-key evil-insert-state-map  (kbd "C-v")     'yank)
(define-key evil-emacs-state-map   (kbd "C-v")     'evil-paste-after)
(define-key global-map             [home]          'mwim-beginning-of-code-or-line)  ; go to line beginning or to identation
(define-key evil-motion-state-map  [home]          'mwim-beginning-of-code-or-line)
(define-key global-map             [end]           'mwim-end)                        ; go to end of code or end of line
(define-key evil-motion-state-map  [end]           'mwim-end)
(global-set-key                    (kbd "<prior>") 'evil-scroll-up)                  ; rebind PgUp/PgDn to evil scroll functions
(global-set-key                    (kbd "<next>")  'evil-scroll-down)

;; these commands go after ':' (evil-ex)
(evil-ex-define-cmd "W"  'evil-write)                                      ; write with sticky shift
(evil-ex-define-cmd "ww" 'custom/write-and-sync)                           ; write file and perform 'doom sync'
(evil-ex-define-cmd "wq" 'custom/write-and-quit)                           ; write file and kill buffer
(evil-ex-define-cmd "q"  'custom/kill-buffer)                              ; kill buffer instead of killing emacs; :q! - kill without prompt

(use-package! highlight-indent-guides
  :defer t
  :custom
  (highlight-indent-guides-auto-odd-face-perc 0)
  (highlight-indent-guides-auto-even-face-perc 0)
  :config
  (highlight-indent-guides-auto-set-faces) ; FIXME indent glitches (not working)
  )

;;; == IMENU-LIST ==
(use-package! imenu-list
  :defer t
  :config
  (setq
   imenu-list-focus-after-activation t    ; window auto-focus
   imenu-list-auto-resize t               ; windown auto-size (is it working?)
   imenu-auto-rescan t                    ; auto-refresh
   imenu-auto-rescan-maxout (* 1024 1024) ; limit auto-refresh to max filesize
   )
)
(map! :leader :desc "imenu-list" "t i" #'imenu-list-smart-toggle)

;;; == LSP ==
(use-package! lsp-mode
  :defer t
  :custom
  (lsp-headerline-breadcrumb-enable t)     ; enable headerline breadcrumb
  (gc-cons-threshold (* 400 1024 1024))    ; increase GC threshold to improve perf in LSP mode
  (read-process-output-max (* 1 1024 1024))  ; handle large LSP responses
  )
(use-package! lsp-treemacs
  :after lsp-mode  ;; and treemacs
  :config (lsp-treemacs-sync-mode 1))

;;; == ORG-MODE ==
(use-package! org
  :defer t
  :custom
  (org-directory "~/org")                                     ; org-agenda and other org tools will work upon this dir
  (org-support-shift-select t)                                ; enable select with S-<arrows>
  (org-startup-folded "content")                              ; startup with everything unfolded except lowest sub-sections
  :config
  (set-popup-rule! "^\\*Org Src" :ignore t)                   ; delete popup rule for src-edit buffer
  :hook                                                       ; ^ makes popup on side instead of bottom
  (after-save . org-babel-tangle)                             ; export org code blocks on save
  (org-src-mode . evil-insert-state)                          ; enter code block editing with insert mode
  (org-mode . (lambda ()
    (display-line-numbers-mode 0)                             ; disable lines numbers for org-mode
    (highlight-regexp ":tangle no" 'error)                    ; highlight :tangle no
    (map! :leader "TAB" #'org-fold-show-subtree)              ; unfold subsections on SPC-TAB
    (sp-local-pair 'org-mode "=" "=" :actions '(insert wrap)) ; auto-pair = and ~
    (sp-local-pair 'org-mode "~" "~" :actions '(insert wrap))
    ))
  )

;;; == ORG-ROAM ==
(use-package! org-roam
  :defer t
  :config
  (setq org-roam-directory org-directory ; org-dir = org-roam-dir
        org-roam-index-file (concat org-directory "README.org") ; org-roam main file
        ;org-template-dir (concat org-directory "templates/") ; templates dir for org-roam nodes
        org-roam-capture-templates
        '(("d" "default-uncat" plain "* Overview\n%?"
           :target (file+head "uncat/${slug}.org" "#+title: ${title}\n#+filetags: uncat\n")
           :unnarrowed t)
          ("t" "tech" plain "* Overview\n%?\n* Main section\n\n* Postscript\n"
           :target (file+head "tech/${slug}.org" "#+title: ${title}\n#+filetags: tech\n")
           :unnarrowed t)
          ("s" "stash" plain "* Overview\n%?"
           :target (file+head "stash/${slug}.org" "#+title: ${title}\n#+filetags: stash\n")
           :unnarrowed t)
          ("m" "money" plain "* Overview\n%?"
           :target (file+head "money/${slug}.org" "#+title: ${title}\n#+filetags: money\n")
           :unnarrowed t)
          ("w" "work" plain "* Overview\n%?"
           :target (file+head "work/${slug}.org" "#+title: ${title}\n#+filetags: work\n")
           :unnarrowed t)
          ("h" "health" plain "* Overview\n%?"
           :target (file+head "health/${slug}.org" "#+title: ${title}\n#+filetags: health\n")
           :unnarrowed t)
          ("l" "leisure" plain "* Overview\n%?"
           :target (file+head "leisure/${slug}.org" "#+title: ${title}\n#+filetags: leisure\n")
           :unnarrowed t)
          )
        )
  )
(use-package! org-roam-timestamps
  :after org-roam
  :config (org-roam-timestamps-mode 1))
(map! :leader :desc "org-roam backlinks" "t o" #'org-roam-buffer-toggle)

(use-package! org-roam-ui
    :after org-roam
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

;;; == TREEMACS ==
(use-package! treemacs
  :defer t
  :config
  (setq treemacs-width 28)         ; adjust window width
  (treemacs-follow-mode 1)         ; follow files
  (treemacs-project-follow-mode 1) ; follow projects
)
(map! :leader :desc "treemacs" "t t" #'treemacs)

;;; == EVIL-WINDOWS KEYMAPS ==
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
