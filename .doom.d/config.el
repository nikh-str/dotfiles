;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Niqi"
      ;; user-mail-address "john@doe.com")
      )

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

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)


(setq doom-font (font-spec :family "Hack Nerd Font" :size 13)
      doom-variable-pitch-font (font-spec :family "Monospace" :size 15)
      doom-big-font (font-spec :family "Source Code Pro" :size 24))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(map! :leader
      :desc "Toggle tabs globally" "t c" #'centaur-tabs-mode
      :desc "Toggle tabs local display" "t C" #'centaur-tabs-local-mode)
(map! :leader
      :desc "Toggle comment" "/" #'comment-line)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(after! org
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-directory "~/Documents/org/")
(setq org-agenda-files '("~/Documents/org/agenda.org"))
(setq org-roam-directory "~/Documents/org/roam")
(setq deft-directory "~/Documents/org/"
      deft-recursive t
      deft-strip-summary-regexp ".*$"
      )
)

(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.3))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.1))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
  '(org-document-title ((t (:height 1.65))))
)


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
(after! org-roam
  (setq org-roam-directory "~/Documents/org/roam")

  (add-hook 'after-init-hook 'org-roam-mode)

  ;; Let's set up some org-roam capture templates
  (setq org-roam-capture-templates
        (quote (("d" "default" plain (function org-roam--capture-get-point)
                 "%?"
                 :file-name "%<%Y-%m-%d-%H%M%S>-${slug}"
                 :head "#+title: ${title}\n"
                 :unnarrowed t)
                )))
  )

(use-package! org-roam-bibtex
    :hook (org-roam-mode . org-roam-bibtex-mode))
  ;; :bind (:map org-mode-map
         ;; (("C-c n a" . orb-note-actions))))

(setq orb-templates
     '(("r" "ref" plain (function org-roam-capture--get-point)
         ""
         :file-name "${citekey}"
         :head "#+TITLE: ${citekey}: ${title}\n#+ROAM_KEY: ${ref}\n#+ROAM_TAGS ; <--
         - tags ::
         - keywords :: ${keywords}

         * Notes
        :PROPERTIES:
        :Custom_ID: ${citekey}
        :URL: ${url}
        :AUTHOR: ${author-or-editor}
        :NOTER_DOCUMENT: ${file}
        :NOTER_PAGE:
        :END:")))
        ;; :unnarrowed t)))

(setq orb-preformat-keywords
      '(("citekey" . "=key=") "title" "url" "file" "author-or-editor" "keywords")
        orb-process-file-keyword t
        orb-file-field-extensions '("pdf"))

(use-package! org-ref
    :config
    (setq
        org-ref-completion-library 'org-ref-ivy-cite
        org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
        ;; org-ref-notes-directory "~/Documents/org/references/notes"
        ;; org-ref-bibliography-notes "~/Documents/org/roam/bibnotes.org"
        org-ref-default-bibliography '("/home/niki/Documents/LaTeX/CitationLib/ZotLib.bib")
        ;; see above function
        org-ref-open-pdf-function 'my/org-ref-open-pdf-at-point
        ;; org-ref-pdf-directory "~/Documents/Library/Physics"
        ;; org-ref-note-title-format "* TODO %y - %t\n :PROPERTIES:\n  :Custom_ID: %k\n  :NOTER_DOCUMENT: %F\n :ROAM_KEY: cite:%k\n  :AUTHOR: %9a\n  :JOURNAL: %j\n  :YEAR: %y\n  :VOLUME: %v\n  :PAGES: %p\n  :DOI: %D\n  :URL: %U\n :END:\n\n"
        ;; org-ref-notes-directory "/home/haozeke/Git/Gitlab/Mine/Notes/"
        org-ref-notes-function 'orb-edit-notes
        ))

  (defun my/org-ref-open-pdf-at-point ()
    "Open the pdf for bibtex key under point if it exists."
    (interactive)
    (let* ((results (org-ref-get-bibtex-key-and-file))
           (key (car results))
           (pdf-file (funcall org-ref-get-pdf-filename-function key)))
      (if (file-exists-p pdf-file)
          (find-file pdf-file)
        (message "No PDF found for %s" key))))


(after! helm
  (use-package! helm-bibtex
    :custom
    ;; In the lines below I point helm-bibtex to my default library file.
    (bibtex-completion-bibliography '("~/Documents/LaTeX/CitationLib/ZotLib.bib"))
    (bibtex-completion-library-path '("~/Documents/Zotero/"))
    (reftex-default-bibliography '("~/Documents/LaTeX/ZotLib.bib"))
    ;; The line below tells helm-bibtex to find the path to the pdf
    ;; in the "file" field in the .bib file.
    (bibtex-completion-pdf-field "file")
    :hook (Tex . (lambda () (define-key Tex-mode-map "\C-ch" 'helm-bibtex))))
  ;; I also like to be able to view my library from anywhere in emacs, for example if I want to read a paper.
  ;; I added the keybind below for that.
  (map! :leader
        :desc "Open literature database"
        "o l" #'helm-bibtex)
  ;; And I added the keybinds below to make the helm-menu behave a bit like the other menus in emacs behave with evil-mode.
  ;; Basically, the keybinds below make sure I can scroll through my list of references with C-j and C-k.
  (map! :map helm-map
        "C-j" #'helm-next-line
        "C-k" #'helm-previous-line)
)

;; (setq bibtex-format-citation-functions
;;       '((org-mode . (lambda (x) (insert (concat
;;                                          "\\cite{"
;;                                          (mapconcat 'identity x ",")
;;                                          "}")) ""))))

(after! org-noter
    (setq
          org-noter-notes-search-path '("~/Documents/org/roam/")
          org-noter-hide-other nil
          org-noter-separate-notes-from-heading t
          org-noter-always-create-frame nil)
    (map!
     :map org-noter-doc-mode-map
     :leader
     :desc "Insert note"
     "m i" #'org-noter-insert-note
     :desc "Insert precise note"
     "m p" #'org-noter-insert-precise-note
     :desc "Go to previous note"
     "m k" #'org-noter-sync-prev-note
     :desc "Go to next note"
     "m j" #'org-noter-sync-next-note
     :desc "Create skeleton"
     "m s" #'org-noter-create-skeleton
     :desc "Kill session"
     "m q" #'org-noter-kill-session
     )
)

;; This is to use pdf-tools instead of doc-viewer
(use-package! pdf-tools
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-width)
  :custom
  (pdf-annot-activate-created-annotations t "automatically annotate highlights"))




 (set-frame-parameter (selected-frame) 'alpha '(85 . 80))
 (add-to-list 'default-frame-alist '(alpha . (85 . 80)))

 (defun toggle-transparency ()
   (interactive)
   (let ((alpha (frame-parameter nil 'alpha)))
     (set-frame-parameter
      nil 'alpha
      (if (eql (cond ((numberp alpha) alpha)
                     ((numberp (cdr alpha)) (cdr alpha))
                     ;; Also handle undocumented (<active> <inactive>) form.
                     ((numberp (cadr alpha)) (cadr alpha)))
               100)

          '(85 . 50) '(100 . 100)))))
 (global-set-key (kbd "C-c t") 'toggle-transparency)
