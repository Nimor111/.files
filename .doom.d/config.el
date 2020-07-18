(setq user-full-name "Georgi Bojinov"
      user-mail-address "georgi.bojinov@hotmail.com")

(setq doom-font (font-spec :family "JetBrainsMono" :size 18))

(setq doom-theme 'doom-gruvbox)

(setq org-startup-indented t
      org-indent-mode t
      org-log-done 'note)

(setq org-agenda-files '("~/Nextcloud/org-roam" "~/Nextcloud/Orgzly/gtd.org" "~/Nextcloud/Orgzly/tickler.org" "~/Nextcloud/Orgzly/inbox.org"))

(setq org-directory "~/Nextcloud/org/")

(setq org-roam-directory "~/Nextcloud/org-roam")

(after! org-roam
        (map! :leader
            :prefix "n"
            :desc "org-roam" "l" #'org-roam
            :desc "org-roam-insert" "i" #'org-roam-insert
            :desc "org-roam-switch-to-buffer" "b" #'org-roam-switch-to-buffer
            :desc "org-roam-find-file" "f" #'org-roam-find-file
            :desc "org-roam-show-graph" "g" #'org-roam-show-graph
            :desc "org-roam-insert" "i" #'org-roam-insert
            :desc "org-roam-capture" "c" #'org-roam-capture))

(use-package! org-roam-server)

(use-package! org-journal
      :bind
      ("C-c n j" . org-journal-new-entry)
      :custom
      (org-journal-dir "~/Nextcloud/org-roam/")
      (org-journal-date-prefix "#+title: ")
      (org-journal-file-format "%Y-%m-%d.org")
      (org-journal-date-format "%A, %d %B %Y"))

(use-package! org-randomnote
  :bind
  ("C-c r" . org-randomnote))

(load-library "find-lisp")
(setq org-randomnote-candidates
      (find-lisp-find-files "~/Nextcloud/org-roam" "\.org$"))

(use-package! ox-reveal
  :config
  (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js"))

(use-package! org-drill
  :after org)

(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/Nextcloud/Orgzly/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/Nextcloud/Orgzly/tickler.org" "Tickler")
                               "* %i%? \n %U")))

(setq org-refile-targets '(("~/Nextcloud/Orgzly/gtd.org" :maxlevel . 3)
                           ("~/Nextcloud/Orgzly/someday.org" :level . 1)
                           ("~/Nextcloud/Orgzly/tickler.org" :maxlevel . 2)))

(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))

(use-package! deft
      :after org
      :bind
      ("C-c n d" . deft)
      :config
      (setq deft-recursive t)
      (setq deft-use-filter-string-for-filename t)
      (setq deft-default-extension "org")
      (setq deft-directory "~/Nextcloud/org-roam/"))

(use-package! rustic
  :config
  (setq rustic-format-trigger 'on-save))

(use-package! haskell-mode
      :after haskell-mode
      :custom
      (haskell-tags-on-save t))
(setq haskell-interactive-popup-error nil)

(add-hook! 'elfeed-search-mode-hook 'elfeed-update)

(map!
  (:after dired
    (:map dired-mode-map
     "C-x i" #'peep-dired
     )))
(evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file
                                             (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

;; (use-package! esh-autosuggest
;;  :hook (eshell-mode . esh-autosuggest-mode))

(map!
 (:after evil
   :en "C-h"   #'evil-window-left
   :en "C-j"   #'evil-window-down
   :en "C-k"   #'evil-window-up
   :en "C-l"   #'evil-window-right))

(setq display-line-numbers-type t)
