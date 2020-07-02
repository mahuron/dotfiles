;;; Daemon
(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs)
  )

;;; User lisp
(let ((default-directory  "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;;; Bootstrap packaging support
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (setq make-backup-files nil)
  (require 'use-package))

(setq custom-file "~/.emacs.d/custom.el")
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file)

;;; General UI options
(setq inhibit-startup-screen t)
(menu-bar-mode -1)

;;; Backup and version control
(setq make-backup-files nil)

;;; Theme
(defun after-load-theme-hook nil
  "Hook run after a theme is loaded via `load-theme'.")
(defadvice load-theme (after run-after-load-theme-hook activate)
  "Run `after-load-theme-hook'."
  (run-hooks 'after-load-theme-hook))

(defun set-background-to-unspecified (&optional frame)
  (or frame (setq frame (selected-frame)))
  "unsets the background color in terminal mode"
  (unless (display-graphic-p frame)
    (set-face-background 'default "unspecified-bg" frame)))

(add-hook 'after-make-frame-functions 'set-background-to-unspecified)
(add-hook 'window-setup-hook 'set-background-to-unspecified)
(add-hook 'after-load-theme-hook 'set-background-to-unspecified)

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package base16-theme
  :ensure t
  :init
  (setq base16-theme-256-color-source 'base16-shell)
  :config
  (load-theme 'base16-default-dark t))

(use-package magit
  :ensure t)

(use-package counsel
  :ensure t
  :init
  (ivy-mode)
  (counsel-mode)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d)")
  :bind (("C-s" . swiper-isearch)
		 ("C-r" . swiper-isearch-backward)))

(use-package adoc-mode
  :ensure t
  :mode ("\\.asciidoc\\'" "\\.adoc\\'"))

(use-package go-mode
  :config
  (defun im-go-mode-hook ()
	(setq tab-width 4)
	(setq compile-command "go build -v"))
  :bind (("M-." . godef-jump)
		 ("M-*" . pop-tag-mark))
  :ensure t
  :mode ("\\.go\\'")
  :hook (im-go-mode
		 (before-save . gofmt-before-save))
  )
