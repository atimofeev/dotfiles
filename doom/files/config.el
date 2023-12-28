;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;; == GENERAL SETTINGS ==
(setq
 user-full-name "Artem Timofeev"
 doom-font (font-spec :family "DejaVuSansM Nerd Font Mono" :size 16 :weight 'semi-light)
 doom-theme 'doom-one
 shell-file-name (executable-find "bash")                        ; use bash shell for internal needs
 display-line-numbers-type t                                     ; show line numbers
 mouse-drag-copy-region t                                        ; select-to-copy with mouse
 confirm-kill-emacs nil                                          ; quit without prompt
 company-global-modes '(not text-mode org-mode markdown-mode)    ; disable autocomplete for plain text
 scroll-margin 3                                                 ; add margin to cursor while scrolling
 mouse-wheel-scroll-amount '(3((shift) . hscroll))               ; faster mouse scrolling
 projectile-project-search-path '("~/repos/")                    ; folder for projects
 global-auto-revert-non-file-buffers t                           ; auto-update non-file buffers (e.g. Dired)
)
(global-auto-revert-mode 1)                                      ; auto-update changed files
(beacon-mode 1)                                                  ; cursor highlight on big movements or between windows
(pixel-scroll-precision-mode)                                    ; smooth scrolling
(set-frame-parameter nil 'alpha-background 96)                   ; enable true transparency
(add-to-list 'default-frame-alist '(alpha-background . 96))
(set-frame-parameter nil 'undecorated t)                         ; remove window decorations
(global-set-key (kbd "C-M-<up>")   'mc/mark-previous-like-this)  ; spawn additional cursor above; C-g to exit
(global-set-key (kbd "C-M-<down>") 'mc/mark-next-like-this)      ; spawn additional cursor below
(unbind-key "<insertchar>" overwrite-mode)                       ; disable overwrite mode on Insert key

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

(defun custom/org-save-clipboard-image ()
  "Save clipboard image to {project-root}/img/{filename}.png
Automatically insert link to image relative from current document.
Depends on xclip for clipboard and ImageMagick for conversion to image."
  (interactive)
  (let* ((project-root (magit-toplevel))
         (folder-path (concat project-root "img/"))
         (image-name (read-string "Enter image name (*.png): "))
         (image-file (concat folder-path image-name ".png"))
         (exit-status nil))
    (unless (file-exists-p folder-path)
      (make-directory folder-path))
    (setq exit-status (call-process-shell-command (format "xclip -selection clipboard -t image/png -o > %s" image-file)))
    (if (= exit-status 0)
        (progn
          (let ((current-file (buffer-file-name)))
            (if current-file
                (let* ((relative-path (file-relative-name (expand-file-name image-file) (file-name-directory current-file)))
                       (image-link (format "[[file:%s]]" relative-path)))
                  (insert image-link)))))
      (message "Failed to save clipboard image."))))

(defun custom/convert-md-links-to-org ()
  "Convert Markdown links to Org-mode links within the current selection."
  (interactive)
  (if (use-region-p)
      (let ((begin (region-beginning))
            (end (region-end)))
        (save-excursion
          (goto-char begin)
          (while (re-search-forward "\\[\\([^\[\]]+\\)\\](\\([^\[\]]+\\))" end t)
            (let ((new-end (- end (- (match-end 0) (match-beginning 0)))))
              (replace-match "[[\\2][\\1]]")
              (setq end new-end)))))
    (message "No region selected. Please select a region to convert.")))

(defun custom/find-subproject-root (pattern)
  "Finds the subproject root upon checking the top occurrence of PATTERN going up from a current dir."
  (let* ((file-dir (file-name-directory (buffer-file-name)))
         (closest-root
          (locate-dominating-file file-dir
                                  (lambda (dir)
                                    (file-exists-p (expand-file-name pattern dir))))))
    closest-root)
  )

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

;;; == CENTAUR-TABS ==
(use-package! centaur-tabs
  :hook                                                      ; hide tabs in various modes
  (vterm-mode . centaur-tabs-local-mode)
  (dired-mode . centaur-tabs-local-mode)
  (pdf-view-mode . centaur-tabs-local-mode)
  :custom
  (centaur-tabs-height 13)                                   ; reduce tab height
  (centaur-tabs-set-close-button nil)                        ; remove close button
  :config                                                    ; hide tabs in various buffers
  (centaur-tabs-group-by-projectile-project)                 ; group tabs by projects
  (dolist (prefix '(                                         ; disable tabs for select buffer names
                    "*doom" "*Async-native" "*Native-compile" "*Messages" "*scratch"
                    "*Org" "*Ilist" "*org-roam" "*httpd" "*pdflatex" "*Latex"
                    "*compilation" "*pylsp" "*yamlls" "*bash-ls" "*jsts-ls" "*ansible-ls" "*json-ls" "*docker"
                    ))
    (add-to-list 'centaur-tabs-excluded-prefixes prefix))
  (unbind-key "<tab-line> <mouse-1>" centaur-tabs-close-map) ; disable tab closing with LMB
  (define-key centaur-tabs-default-map
   (vector centaur-tabs-display-line 'mouse-2) 'centaur-tabs-do-select)
  )
(map! :leader
      "<left>" #'centaur-tabs-backward
      "<right>" #'centaur-tabs-forward
      "<up>" #'centaur-tabs-forward-group
      "<down>" #'centaur-tabs-backward-group)
(map! "C-s-<left>" #'centaur-tabs-backward
      "C-s-<right>" #'centaur-tabs-forward
      "C-s-<up>" #'centaur-tabs-forward-group
      "C-s-<down>" #'centaur-tabs-backward-group)

;;; == DIRED ==
(use-package! dired
  :defer t
  :custom
  (dired-kill-when-opening-new-dired-buffer t)  ; stop creating buffers for each dir
  )
(evil-define-key 'normal dired-mode-map
  (kbd "DEL") 'dired-up-directory               ; move up dirs with Backspace
  )

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
(define-key evil-insert-state-map  (kbd "C-y")     'evil-yank)                       ; C-y to copy in Insert state
(define-key evil-insert-state-map  (kbd "C-u")     'evil-undo)                       ; C-u to undo in Insert state
(define-key evil-insert-state-map  (kbd "C-r")     'evil-redo)                       ; C-u to undo in Insert state
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

;;; == FLYCHECK ==
(use-package! flycheck
  :defer t
  :custom
  (flycheck-relevant-error-other-file-minimum-level nil)  ; show errors from all related files
  (flycheck-dockerfile-hadolint-executable "~/.config/doom/scripts/hadolint-container.sh")
  (flycheck-markdown-markdownlint-cli-executable "~/.config/doom/scripts/markdownlintcli-container.sh")
  (flycheck-markdown-markdownlint-cli-config "~/.config/doom/.markdownlint.yaml")
  (flycheck-sh-shellcheck-executable "~/.config/doom/scripts/shellcheck-container.sh")
  :config
  (flycheck-add-next-checker 'markdown-markdownlint-cli 'textlint)
  (flycheck-add-next-checker 'textlint 'proselint)
  ;(flycheck-display-errors-funct ion #'flycheck-display-error-messages-unless-error-list) ; i need reverse of this
  )
(setq tflint-custom-config "~/.config/doom/.tflint.hcl")
(add-hook 'lsp-managed-mode-hook (lambda ()                     ; setup checkers chaining with LSP
    (when (derived-mode-p 'dockerfile-mode)(flycheck-add-next-checker 'lsp 'dockerfile-hadolint))
    (when (derived-mode-p 'sh-mode)        (flycheck-add-next-checker 'lsp 'sh-bash))  ; next one is sh-shellcheck
    (when (derived-mode-p 'sh-mode)        (flycheck-add-next-checker 'lsp 'sh-posix-bash))
    ))

(flycheck-define-checker terraform-tflint-custom
  "A custom Terraform checker using tflint.

See URL `https://github.com/wata727/tflint'."
  :command ("docker" "run" "--rm" "-i"
            "-v" (eval (concat (expand-file-name (custom/find-subproject-root "main.tf")) ":/data"))
            "-v" (eval (concat (expand-file-name tflint-custom-config) ":/.tflint.hcl"))
            "tflint-plugins" "--format=compact" "--config=/.tflint.hcl")
  :error-patterns
  ((info line-start   (optional (file-name)) ":" line ":" column ": notice - "  (message) line-end)
  (warning line-start (optional (file-name)) ":" line ":" column ": warning - " (message) line-end)
  (error line-start   (optional (file-name)) ":" line ":" column ": error - "   (message) line-end))
  :modes terraform-mode
  :next-checkers (terraform))
(add-to-list 'flycheck-checkers 'terraform-tflint-custom)

;;; == GPTEL ==
(defvar openai-api-key nil "Variable to hold OpenAI API key.")
(defun read-openai-api-key ()
  "Read API key from file and set `openai-api-key`."
  (with-temp-buffer
    (insert-file-contents "~/repos/dotfiles/doom/api.key")
    (setq openai-api-key (string-trim (buffer-string)))))

(use-package! gptel
  :defer t
  :init
  (read-openai-api-key)
  :custom
  (gptel-api-key openai-api-key)
  (gptel-default-mode 'org-mode)
  (gptel-model "gpt-4")
  )

;;; == IMENU-LIST ==
(use-package! imenu-list
  :defer t
  :custom
  (imenu-list-focus-after-activation t)    ; window auto-focus
  (imenu-list-auto-resize t)               ; windown auto-size (is it working?)
  (imenu-auto-rescan t)                    ; auto-refresh
  (imenu-auto-rescan-maxout (* 1024 1024)) ; limit auto-refresh to max filesize
  )
(map! :leader :desc "imenu-list" "t i" #'imenu-list-smart-toggle)

;;; == INDENT-BARS ==
(use-package! indent-bars
  :disabled t
  :defer t
  :hook
  (prog-mode . indent-bars-mode)
  :custom ; Minimal colorpop theme
  (indent-bars-color '(highlight :face-bg t :blend 0.15))
  (indent-bars-pattern ".")
  (indent-bars-width-frac 0.1)
  (indent-bars-pad-frac 0.1)
  (indent-bars-zigzag nil)
  (indent-bars-color-by-depth '(:regexp "outline-\\([0-9]+\\)" :blend 1)) ; blend=1: blend with BG only
  (indent-bars-highlight-current-depth '(:blend 0.5)) ; pump up the BG blend on current
  (indent-bars-display-on-blank-lines t)
  (indent-bars-treesit-support t) ; treesitter integration
  (indent-bars-no-descend-string t)
  (indent-bars-treesit-ignore-blank-lines-types '("module"))
  (indent-bars-treesit-wrap '((python argument_list parameters
                               identifier keyword_argument block
                               list list_comprehension
                               dictionary dictionary_comprehension
                               parenthesized_expression subscript)))
  )

;;; == KUBEL ==
(use-package! kubel
  :defer t
  :after vterm
  :config
  (kubel-vterm-setup)
  )
(use-package! kubel-evil
  :after kubel)

;;; == LANGUAGES ==
(add-hook 'prog-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'delete-trailing-whitespace nil t) ; remove whitespace on save
            (rainbow-delimiters-mode)                                      ; enable colored delimiters ([{
            )
          )

(use-package! terraform-mode
  :defer t
  :config
  (add-hook 'terraform-mode-hook 'terraform-format-on-save-mode)
  )
(with-eval-after-load 'apheleia
  (add-to-list 'apheleia-mode-alist '(sh-mode . shfmt)))

;;; == LSP ==
(use-package! lsp-mode
  :defer t
  :custom
  (gc-cons-threshold (* 400 1024 1024))      ; increase GC threshold to improve perf in LSP mode
  (read-process-output-max (* 1 1024 1024))  ; handle large LSP responses
  )
(use-package! lsp-treemacs
  :after lsp-mode  ;; and treemacs
  :config
  (lsp-treemacs-sync-mode 1)
  )

;;; == ORG-MODE ==
(use-package! org
  :defer t
  :custom
  (org-directory "~/repos/org")                                     ; org-agenda and other org tools will work upon this dir
  (org-support-shift-select t)                                ; enable select with S-<arrows>
  (org-startup-folded "content")                              ; startup with everything unfolded except lowest sub-sections
  (help-at-pt-display-when-idle t)                            ; show tooltips on links
  (help-at-pt-timer-delay 0.3)                                ; smaller delay before tooltips
  :config
  (set-popup-rule! "^\\*Org Src" :ignore t)                   ; delete popup rule for src-edit buffer
  :hook                                                       ; ^ makes popup on side instead of bottom
  (after-save . org-babel-tangle)                             ; export org code blocks on save
  (org-src-mode . evil-insert-state)                          ; enter code block editing with insert mode
  (org-mode . (lambda ()
    (flycheck-mode 0)                                         ; disable flycheck-mode
    (display-line-numbers-mode 0)                             ; disable lines numbers for org-mode
    (highlight-regexp ":tangle no" 'error)                    ; highlight :tangle no
    (map! :leader "TAB" #'org-fold-show-subtree)              ; unfold subsections on SPC-TAB
    ;(sp-local-pair 'org-mode "=" "=" :unless '(sp-point-before-word-p sp-point-before-same-p)) ; auto-pair = and ~
    (sp-local-pair 'org-mode "~" "~" :unless'(sp-point-before-word-p sp-point-before-same-p))
    ))
  )
(defun org-dblock-write:cover-letter (params)                 ; dynamic block to generate CL
  (let* ((position (plist-get params :position))
         (company (plist-get params :company))
         (template (with-temp-buffer
                     (insert-file-contents "~/org/templates/cover-letter.org")
                     (buffer-string))))
    (setq template (replace-regexp-in-string "%position%" position template))
    (setq template (replace-regexp-in-string "%company%" company template))
    (insert template)))

;;; == ORG-ROAM ==
(use-package! org-roam
  :defer t
  :init
  (map! :leader :desc "org-roam backlinks" "t o" #'org-roam-buffer-toggle)
  :config
  (setq org-roam-directory org-directory ; org-dir = org-roam-dir
        org-roam-index-file (concat org-directory "README.org") ; org-roam main file
        ;org-template-dir (concat org-directory "templates/") ; templates dir for org-roam nodes
        org-roam-capture-templates
        '(("d" "default-uncat" plain "* Overview\n%?"
           :target (file+head "uncat/${slug}.org" "#+title: ${title}\n#+filetags: uncat\n")
           :unnarrowed t)
          ("t" "tech" plain "* Overview\n%?"
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
  :config
  (org-roam-timestamps-mode 1)
  )

;;; == ORG ROAM UI ==
(use-package! org-roam-ui
    :after org-roam
    :custom
    (org-roam-ui-sync-theme t)
    (org-roam-ui-follow t)
    (org-roam-ui-update-on-save t)
    (org-roam-ui-open-on-start t)
    ; TODO: write comments for custom options
    )

;;; == RECENTER ON BUFFER END ==
(defun my-recenter-if-end-of-buffer-visible (&rest args)
  "Advice to recenter window if the end of the buffer is visible."
  (when (and (not (equal (point-max) (point-min)))
             (pos-visible-in-window-p (point-max)))
    (recenter)))

(advice-add 'pixel-scroll-interpolate-down :after #'my-recenter-if-end-of-buffer-visible)
;(advice-add 'scroll-up :after #'my-recenter-if-end-of-buffer-visible)

;;; == TREEMACS ==
(use-package! treemacs
  :init
  (map! :leader :desc "treemacs" "t t" #'treemacs)
  :custom
  (treemacs-width 28)              ; adjust window width
  :config
  (treemacs-follow-mode 1)         ; follow files
  ;(treemacs-project-follow-mode 1) ; follow projects
)

;;; == VTERM ==
(use-package! vterm
  :defer t
  :config
  (setq-default vterm-shell (executable-find "fish"))             ; set fish shell as default
  )
(map! :leader
       :desc "vterm popup"              "t s"     #'+vterm/toggle  ; open popup
       :desc "vterm window"             "t S"     #'+vterm/here    ; open in current window
       )

;;; == EVIL-WINDOWS KEYMAPS ==
(map! :leader
      (:prefix ("w". "window")
       :desc "New window, up"           "n"             #'evil-window-new
       :desc "New window, left"         "N"             #'evil-window-vnew

       :desc "Split view, right"        "s"             #'evil-window-split
       :desc "Split view, down"         "v"             #'evil-window-vsplit

       :desc "Select LEFT window"       "<left>"        #'evil-window-left
       :desc "Select DOWN window"       "<down>"        #'evil-window-down
       :desc "Select UP window"         "<up>"          #'evil-window-up
       :desc "Select RIGHT window"      "<right>"       #'evil-window-right

       :desc "Move window LEFT"         "S-<left>"      #'+evil/window-move-left
       :desc "Move window DOWN"         "S-<down>"      #'+evil/window-move-down
       :desc "Move window UP"           "S-<up>"        #'+evil/window-move-up
       :desc "Move window RIGHT"        "S-<right>"     #'+evil/window-move-right

       :desc "Maximize window"          "m m"           #'doom/window-maximize-buffer
       :desc "Maximize vertically"      "m v"           #'doom/window-maximize-vertically
       :desc "Maximize horizontally"    "m s"           #'doom/window-maximize-horizontally

       :desc "Close window"             "c"             #'evil-window-delete
       :desc "Kill buffer & window"     "d"             #'kill-buffer-and-window))

;;; == WHITEROOM-MODE ==
(after! writeroom-mode
  (add-hook! 'writeroom-mode-enable-hook
    (centaur-tabs-mode -1)
    (git-gutter-mode -1)
    (company-mode -1)
    )

  (add-hook! 'writeroom-mode-disable-hook
    (centaur-tabs-mode 1)
    (git-gutter-mode 1)
    (company-mode 1)
    )
  )
