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

(defun set-background-for-terminal (&optional frame)
  (or frame (setq frame (selected-frame)))
  "unsets the background color in terminal mode"
  (unless (display-graphic-p frame)
    (set-face-background 'default nil frame)))
(add-hook 'after-make-frame-functions 'set-background-for-terminal)
(add-hook 'window-setup-hook 'set-background-for-terminal)

(require 'base16-material-darker-theme)

;;; Backup and version control
(setq make-backup-files nil)

(use-package magit
  :ensure t)
