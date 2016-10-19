;; ~/.emacs

(defconst my-start-time (current-time))

;; About me
(setq user-full-name "Chirag Kantharia"
      user-mail-address "chirag.kantharia@gmail.com"
      organization "Private Networks"
      calendar-latitude 12.93
      calendar-longitude -77.69
      calendar-location-name "Bangalore, IN")

;; Vars/paths
(defvar my-dir (expand-file-name "~/Dropbox/Dot/emacs.d")
  "The root dir for my Emacs configuration.")
(defvar my-tmp (expand-file-name "tmp" user-emacs-directory)
  "Temp files that might be useful but that I don't care about.")
(unless (file-exists-p my-tmp) (make-directory my-tmp))
(add-to-list 'load-path "/usr/share/emacs/24.5/lisp/emacs-lisp/")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/")
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(let ((default-directory (concat user-emacs-directory "elpa/")))
  (normal-top-level-add-subdirs-to-load-path))

;; Bootstrap packages
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
	("melpa" . "http://melpa.org/packages/")
	("marmalade" . "https://marmalade-repo.org/packages/")
	("org" . "http://orgmode.org/elpa/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-verbose t)
(require 'use-package)
(use-package auto-compile
  :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)
(setq use-package-always-ensure t)


;; Load sane defaults
(require 'sensible-defaults)

;; Load faces/colors/theme
(require 'my-colors)

;; Load key-bindings
(require 'my-keybindings)

;; Ensure we have our packages
(require 'my-packages)

;; Load environment
(require 'my-env)

;; Load development settings
;; (require 'my-devel)

;; Load calendar/org
(require 'my-org)

;; Load mail settings
;; (require 'notmuch-config)
(require 'mu4e-config)

;;; Elapsed time
(add-hook 'after-init-hook
          `(lambda ()
             (let ((elapsed (float-time (time-subtract (current-time)
                                                       my-start-time))))
               (message "Loading %s...done (%.3fs)", load-file-name elapsed))
             (org-agenda nil "a")) t)
;; eof
(put 'upcase-region 'disabled nil)
