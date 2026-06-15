; Remove shitty bars and splash screen
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq visible-bell t)

;; disable annoying compiler warnings
(setq byte-compile-warnings '(not free-vars unresolved noruntime lexical make-local))

; Set font
(add-to-list 'default-frame-alist `(font . "BerkeleyMono-20"))

; Line numbers
(global-display-line-numbers-mode 1)
(column-number-mode 1)

; Indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-default-style "k&r")
(setq c-basic-offset 4) 

; Set up MELPA packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

; Redirect customized variables to custom.el
(setq custom-file "~/.config/emacs/custom.el")
(load-file custom-file)

; Uncomment this to make the background transparent
;(set-frame-parameter nil 'alpha-background 95)

(require 'use-package)
(setq use-package-always-ensure t)

(use-package citeproc
  :ensure t)

(use-package atom-one-dark-theme
  :ensure t
  :config
  (load-theme 'atom-one-dark t))

;; fuzzy finding
(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil))

;; consult
(use-package consult
  :ensure t)

;; fancy auto-complete
(use-package vertico
  :ensure t
  :init
  (vertico-mode)
  :config
  (define-key vertico-map (kbd "DEL") #'vertico-directory-delete-char))

;; Fancy keybind stuff
(use-package which-key
  :ensure t
  :init
  (which-key-mode))

;; Add labels to functions in M-x
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

(use-package magit
  :ensure t)

;; LSPs
(use-package lsp-mode
  :ensure t
  :hook ((c-mode . lsp)
         (c++-mode . lsp)
         (python-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :config
  (setq lsp-keymap-prefix "C-c l")
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  (setq lsp-file-watch-threshold 15000)
  )
(use-package lsp-ui
  :ensure t
  :commands (lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-doc-delay 0.5)
  (setq lsp-ui-sideline-show-hover nil)
  (setq lsp-ui-sideline-show-diagnostics t)
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  )
(use-package yasnippet)
(use-package company)

; Function to select whole line
(defun select-line ()
  (interactive)
  (move-beginning-of-line 1)
  (set-mark-command nil)
  (move-end-of-line 1))

; Keybinds
(keymap-global-set "C-x e" 'replace-string)
(keymap-global-set "C-x C-b" 'ibuffer)
(keymap-global-set "C-x c" 'compile)
(keymap-global-set "C-," 'select-line)
(keymap-global-set "M-g l" 'consult-line)
(keymap-global-set "C-x /" 'comment-or-uncomment-region)

; Dont clutter those stupid backup files everywhere
(setq auto-save-file-name-transforms
      `((".*" ,(concat user-emacs-directory "auto-save/") t)))
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))
