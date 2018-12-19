;;; Daemon
(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs)
  )

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
(setq make-backup-files nil)  (require 'use-package))

(use-package magit
  :ensure t)

(setq custom-file "~/.emacs.d/custom.el")
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file)

;;; General UI options
(setq inhibit-startup-screen t)
(menu-bar-mode -1)

(use-package base16-theme
  :ensure t
  :init
  (setq base16-theme-256-color-source "colors")
  :config
  (load-theme 'base16-default-dark t)
  )

;;; Backup and version control
(setq make-backup-files nil)
