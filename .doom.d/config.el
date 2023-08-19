;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Nandaja Varma"
      user-mail-address "nandaja.varma@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
;(setq doom-font (font-spec :family "SourceCodePro+Powerline+Awesome+Regular" :size 17 :weight 'light)
      ;doom-variable-pitch-font (font-spec :family "open sans"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-acario-dark)


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(add-to-list 'load-path "~/.emacs.d/tramp/lisp/")
(require 'tramp)


;; ----#START theme setup-----
;; (use-package doom-themes
;;   :ensure t
;;   :config
;;   ;; Global settings (defaults)
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;   (load-theme 'doom-acario-dark t)

;;   ;; Enable flashing mode-line on errors
;;   (doom-themes-visual-bell-config)
;;   ;; Enable custom neotree theme (all-the-icons must be installed!)
;;   (doom-themes-neotree-config)
;;   ;; or for treemacs users
;;   (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
;;   (doom-themes-treemacs-config)
;;   ;; Corrects (and improves) org-mode's native fontification.
;;   (doom-themes-org-config))
;;   source http://www.mycpu.org/emacs-productivity-setup/
(require 'doom-themes)

(require 'indent-guide)
(indent-guide-global-mode)
(set-face-background 'indent-guide-face "dimgray")

;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each
;; theme may have their own settings.
(load-theme 'doom-pine t)

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Enable custom neotree theme
(doom-themes-neotree-config)  ; all-the-icons fonts must be installed!

(setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
(doom-themes-treemacs-config)
;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

(require 'doom-modeline)
(doom-modeline-mode 1)
;; ----#END theme setup-----


;;-----#START Treemacs mousefree switching----
(defun +private/treemacs-back-and-forth ()
  (interactive)
  (if (treemacs-is-treemacs-window-selected?)
      (aw-flip-window)
    (treemacs-select-window)))

(map! :after treemacs
      :leader
      :n "-" #'+private/treemacs-back-and-forth)
;;END Treemacs mousefree switching----

;;;-----#START org mode-------------
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/org/")

;; Org-habit
(require 'org-habit)
(add-to-list 'org-modules 'org-habit)
(use-package! org-habit
  :after org
  :config
  (setq org-habit-following-days 7
        org-habit-preceding-days 35
        org-habit-show-habits t)  )
(setq modus-themes-org-agenda
      '(;; ...
        ;; Other key . value pairs
        ;; ...
        (habit . traffic-light)))


(setq org-agenda-files '("~/Workspace/agenda/"))

;;;-----#START org capture-------------
;;;
;;; to get the file during org capture
;; (org-capture-get :original-file)
;;
;;
;; (after! org
;;        (add-to-list 'org-capture-templates
(setq org-capture-templates
      '(
        ("w" "work" entry
                (file+headline "~/Workspace/agenda/work.org" "Inbox")
                "* %?  %(org-set-tags \"work\")"
                :prepend t
                :empty-lines 1
                :CREATED t
                :clock-keep t
        )
        ("u" "project" entry
                (file+headline "~/Workspace/agenda/projects.org" "Inbox")
                "* %? :project:\n%a\n"
                :prepend t
                :empty-lines 1
        )
        ("t" "tech learning" entry
                (file+headline "~/Workspace/agenda/learn.org" "Inbox")
                "* %? :tech:\n%a\n")
        ("c" "chores" entry
                (file+headline "~/Workspace/agenda/chore.org" "Inbox")
                "* %U %? :chore: \n%a\n" :clock-keep t)
        ("n" "quick note" entry
                (file+headline "~/Workspace/agenda/todo.org" "Inbox")
                "* %U %? :NOTE:\n\n %i\n %a" :clock-keep t)
        ("b" "book" entry
                (file+headline "~/Workspace/agenda/books.org" "Inbox")
                "*  %? :book:\n%a\n"
                :prepend t
                :empty-lines 1
                :CREATED t
                :clock-keep t)
      )
)

;;;-----#END org capture-------------
;;;-----#START org cutom agenda view-------------
(setq org-agenda-custom-commands
      '(("p" "Plan your agenda"
         (
        (todo "TODO" (
                (org-agenda-overriding-header "⚡ Coming up next")
                (org-agenda-remove-tags nil)
                (org-agenda-prefix-format "   %-2i %?b")
                (org-agenda-todo-keyword-format "")))

          (tags  "+chore-TODO=\"TODO\"" (
                      (org-agenda-overriding-header "\n☂ Chores pending")
                      (org-agenda-remove-tags t)
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'timestamp))
                      (org-agenda-todo-ignore-scheduled 'all)
                      (org-agenda-prefix-format "   %-2i %?b")
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled 'todo '("WAITING" "TODO" "DONE" "HOLD")))
                      (org-agenda-todo-keyword-format "")))

         (tags "+NOTE-TODO=\"TODO\"" (
                      (org-agenda-todo-ignore-scheduled 'all)
                      (org-agenda-overriding-header "⚡ Notes")
                      (org-agenda-todo-ignore-scheduled 'all)
                      (org-agenda-remove-tags t)
                      (org-agenda-prefix-format "   %-2i %?b")
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled 'todo '("WAITING" "TODO" "DONE" "HOLD")))
                      (org-agenda-todo-keyword-format "")))
         (tags "+book-TODO=\"TODO\"" (
                      (org-agenda-todo-ignore-scheduled 'all)
                      (org-agenda-overriding-header "📚 Books and Blogs")
                      (org-agenda-todo-ignore-scheduled 'all)
                      (org-agenda-remove-tags t)
                      (org-agenda-prefix-format "   %-2i %?b")
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled 'todo '("WAITING" "TODO" "DONE" "HOLD")))
                      (org-agenda-todo-keyword-format "")))
         (tags "+work-TODO=\"TODO\"" (
                      ;; (org-agenda-todo-ignore-scheduled 'all)
                      (org-agenda-overriding-header "🧠 Work")
                      (org-agenda-remove-tags t)
                      (org-tags-match-list-sublevels nil)
                      (org-agenda-show-inherited-tags nil)
                      (org-agenda-todo-ignore-scheduled 'all)
                      (org-agenda-prefix-format "   %-2i %?b")
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled 'todo '("WAITING" "TODO" "DONE" "HOLD")))
                      (org-agenda-todo-keyword-format "")))
         (tags "+tech-TODO=\"TODO\"" (
                      ;; (org-agenda-todo-ignore-scheduled 'all)
                      (org-agenda-overriding-header "🧠 Learning")
                      (org-agenda-remove-tags t)
                      (org-tags-match-list-sublevels nil)
                      (org-agenda-show-inherited-tags nil)
                      (org-agenda-todo-ignore-scheduled 'all)
                      (org-agenda-prefix-format "   %-2i %?b")
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled 'todo '("WAITING" "TODO" "DONE" "HOLD")))
                      (org-agenda-todo-keyword-format "")))
         (tags "+project-TODO=\"TODO\"" (
                      (org-agenda-overriding-header "\n🛹 Projects")
                      (org-agenda-remove-tags t)
                      (org-tags-match-list-sublevels nil)
                      (org-agenda-show-inherited-tags nil)
                      (org-agenda-todo-ignore-scheduled 'all)
                      (org-agenda-prefix-format "   %-2i %?b")
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled 'todo '("WAITING" "TODO" "DONE" "HOLD")))
                      (org-agenda-todo-keyword-format "")))
         (tags "+TODO=\"HOLD\"" (
                      (org-agenda-overriding-header "\n❌ On Hold")
                      (org-agenda-remove-tags nil)
                      (org-tags-match-list-sublevels nil)
                      (org-agenda-show-inherited-tags nil)
                      (org-agenda-prefix-format "   %-2i %?b")
                      (org-agenda-todo-keyword-format "")))
          ))))

;;;-----#END org cutom agenda view-------------
;;;
;;;-----#END org mode-------------

;;;------#START google cal sync---------
;; (require 'org-gcal)
;; (setq org-gcal-client-id "578676487259-rh3vsodv5k2oatm35vn6j40pj9r1un1j.apps.googleusercontent.com"
;;       org-gcal-client-secret "5Sg-xaxs8B1vjTEHVokXhLek"
;;       org-gcal-fetch-file-alist '(("nandaja.varma@sighup.io" .  "~/Workspace/agenda/schedule.org")))
;;;------#END google cal sync---------

;;;------#START go code stuff---------
;;; inspiration https://dr-knz.net/a-tour-of-emacs-as-go-editor.html
;;; Most of the following codeblocks is from there
(require 'yasnippet)
(yas-global-mode 1)

(add-hook 'before-save-hook 'gofmt-before-save)

;;; the following code basically builds with linter
(flycheck-define-checker go-build-escape
  "A Go escape checker using `go build -gcflags -m'."
  :command ("go" "build" "-gcflags" "-m"
            (option-flag "-i" flycheck-go-build-install-deps)
            ;; multiple tags are listed as "dev debug ..."
            (option-list "-tags=" flycheck-go-build-tags concat)
            "-o" null-device)
  :error-patterns
  (
   (warning line-start (file-name) ":" line ":"
          (optional column ":") " "
          (message (one-or-more not-newline) "escapes to heap")
          line-end)
   (warning line-start (file-name) ":" line ":"
          (optional column ":") " "
          (message "moved to heap:" (one-or-more not-newline))
          line-end)
   (info line-start (file-name) ":" line ":"
          (optional column ":") " "
          (message "inlining call to " (one-or-more not-newline))
          line-end)
  )
  :modes go-mode
  :predicate (lambda ()
               (and (flycheck-buffer-saved-p)
                    (not (string-suffix-p "_test.go" (buffer-file-name)))))\
  )

(with-eval-after-load 'flycheck
   (add-to-list 'flycheck-checkers 'go-build-escape)
   (flycheck-add-next-checker 'go-gofmt 'go-build-escape))

; lsp, if enabled, disables the flycheck checkers by default.
; Re-add ours in that case.
(add-hook 'lsp-configure-hook
      (lambda ()
        (when (eq major-mode 'go-mode)
          (flycheck-add-next-checker 'lsp 'go-build-escape)))
      100)
;;;------#END go code stuff---------


;;;------#START customize splash screen---------
;(require 'dashboard)
;(dashboard-setup-startup-hook)
;;;------#END customize splash screen---------

;;;------#START very large files---------
;(require 'vlf-setup)
;;;------#END very large files---------

