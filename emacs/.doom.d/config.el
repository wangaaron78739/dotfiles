;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Aaron Wang"
      user-mail-address "wangaaron78739@gmail.com")

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)
  (setq org-directory "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org"))

(setq parrot-num-rotations nil)
(setq projectile-project-search-path '("~/Documents/Github/"))


(when (eq system-type 'gnu/linux)
  (setq company-idle-delay 0.1)
  ;; (setq company-show-numbers t)
  )
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (make-local-variable 'company-idle-delay)
            (setq company-idle-delay 0.5)))

(setq indent-line-function 'insert-tab)
;; (setq ispell-dictionary "es_US")

;; (setq-default indent-tabs-mode nil)
;; (setq-default tab-width 2)
;; (setq indent-line-function 'insert-tab)
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
;; (setq doom-theme 'doom-vibrant)
(setq doom-theme 'doom-monokai-pro)

(setq doom-themes-treemacs-enable-variable-pitch nil)
(setq doom-variable-pitch-font (font-spec :family "monospace" :size 13))
(setq org-superstar-headline-bullets-list '("⁖" "◉" "○" "✸" "✿"))

(setq display-line-numbers-type 'relative)
(unless (equal "Battery status not available" (battery))
  (display-battery-mode 1))

(after! centaur-tabs
  (centaur-tabs-group-by-projectile-project))
(setq centaur-tabs-height 18)

(setq which-key-idle-delay 0.1)

(custom-set-faces!
  '(aw-leading-char-face
    :foreground "white" :background "red"
    :weight bold :height 2.5 :box (:line-width 10 :color "red")))

(defun really-kill-emacs ()
  "Like `kill-emacs', but ignores `kill-emacs-hook'."
  (interactive)
  (let (kill-emacs-hook)
    (kill-emacs)))
(setq +latex-viewers '(pdf-tools))
(when (eq system-type 'gnu/linux)
  (use-package! laas
    :after latex
    :hook (LaTeX-mode . laas-mode)
    :config
    (aas-set-snippets 'laas-mode
                      :cond #'texmathp ; expand only while in math
                      "./" (lambda () (interactive)
                             (yas-expand-snippet "\\frac{${1:`(or % \"numerator\")`}}{${2:denominator}}$0 "))
                      "norm" (lambda () (interactive)
                               (yas-expand-snippet "\\|$1\\|$0"))
                      "td" (lambda () (interactive)
                             (yas-expand-snippet "^{$1"))
                      "qq" "\\quad"
                      "..." "\\ldots"
                      "tt" (lambda () (interactive)
                             (yas-expand-snippet "\\text{$1"))
                      "set" (lambda () (interactive)
                              (yas-expand-snippet "\\\\{$1"))
                      ".(" (lambda () (interactive)
                             (yas-expand-snippet "\\left($1\\right)"))
                      "lll" "\\ell"
                      "tran" "^{T}"
                      "invs" "^{-1}"
                      "case" (lambda () (interactive)
                               (yas-expand-snippet "\\begin{cases}\n $1\n \\end{cases}"))
                      :cond (not #'texmathp)
                      " mk" (lambda () (interactive)
                              (yas-expand-snippet " \$$1$0"))
                      " dm" (lambda () (interactive)
                              (yas-expand-snippet " \\\[$1$0")))
    ))

(when (eq system-type 'darwin)
  (use-package! laas
    :after latex
    :hook (LaTeX-mode . laas-mode)
    :config
    (aas-set-snippets 'laas-mode
                      :cond #'texmathp ; expand only while in math
                      "./" (lambda () (interactive)
                             (yas-expand-snippet "\\frac{${1:`(or % \"numerator\")`}}{${2:denominator}}$0 "))
                      "norm" (lambda () (interactive)
                               (yas-expand-snippet "\\|$1\\|$0"))
                      "td" "^{"
                      "qq" "\\quad"
                      "..." "\\ldots"
                      "tt" "\\text{"
                      "set" "\\{"
                      "lll" "\\ell"
                      "tran" "^{T}"
                      "invs" "^{-1}"
                      "case" (lambda () (interactive)
                               (yas-expand-snippet "\\begin{cases}\n $1\n \\end{cases}"))
                      :cond (not #'texmathp)
                      " mk" (lambda () (interactive)
                              (yas-expand-snippet " \$$1$0"))
                      " dm" (lambda () (interactive)
                              (yas-expand-snippet " \\\[$1$0")))
    ))

(add-hook 'latex-mode-hook
          (lambda ()
            (add-hook! 'after-save-hook 'TeX-command-run-all nil 'make-it-local)))
(defun +myfunc ()
  (setq parrot-num-rotations 2)
  )
(add-hook 'latex-mode-hook #'+myfunc)
(use-package! parrot
  :config
  (parrot-mode)
  (define-key evil-normal-state-map (kbd "[r") 'parrot-rotate-prev-word-at-point)
  (define-key evil-normal-state-map (kbd "]r") 'parrot-rotate-next-word-at-point))
(map! :leader
      :desc "Dired"
      "d d" #'dired
      :leader
      :desc "Dired jump to current"
      "d j" #'dired-jump
      (:after dired
       (:map dired-mode-map
        :leader
        :desc "Peep-dired image previews"
        "d p" #'peep-dired
        :leader
        :desc "Dired view file"
        "d v" #'dired-view-file )))
(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)
;; (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(setq projectile-switch-project-action 'projectile-dired)
;; (defun my/counsel-projectile-switch-project-action-dired (project)
;;   "Open ‘dired’ at the root of the project."
;;   (let ((projectile-switch-project-action
;; 	 (lambda ()
;; 	   (projectile-dired))))
;;     (counsel-projectile-switch-project-by-name project)))

;; (counsel-projectile-modify-action
;;  'counsel-projectile-switch-project-action
;;  '(add ("." my/counsel-projectile-switch-project-action-dired
;;         "open ‘dired’ at the root of the project")
;;        ))
(quickrun-add-command "c++/c1z"
  '((:command . "g++")
    (:exec    . ("%c -std=c++1z %o -o %e %s"
		 "%e %a"))
    (:remove  . ("%e")))
  :default "c++")
(setq aya-trim-one-line 't)
(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")

(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))
(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
(setq evil-snipe-scope 'visible)
(global-evil-quickscope-mode 1)
;; (use-package! company-tabnine
;;   :after company
;;   :config
;;   (add-to-list 'company-backends #'company-tabnine))
;; ;; (use-package! company-tabnine
;; ;;   :after company
;; ;;   :config
;; ;;   (cl-pushnew 'company-tabnine (default-value 'company-backends)))
(use-package! company-tabnine
  :after company
  :when (featurep! :completion company)
  :config
  (cl-pushnew 'company-tabnine (default-value 'company-backends))
  )
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
;;
(setq cmake-ide-build-dir "./build")
;; needs clang-format
(after! format
  (set-formatter! 'clang-format
    '("clang-format"
      "-style={ BasedOnStyle: Google, UseTab: Always, IndentWidth: 4, TabWidth: 4, ColumnLimit: 120}"
      ("-assume-filename=%S" (or buffer-file-name mode-result "")))
    ))
(setq-hook! 'c-mode-hook +format-with-lsp nil)
(setq-hook! 'c++-mode-hook +format-with-lsp nil)

(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))
;; (setq lsp-pyright-use-library-code-for-types 'nil)
(setq lsp-pyright-use-library-code-for-types t)
(load! "+bindings")
