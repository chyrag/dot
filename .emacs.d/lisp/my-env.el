;; Environment/appearance

;; functions (probably these need to go into different file?)
(defun file-reopen-as-root ()
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/sudo:root@localhost:"
             buffer-file-name))))

;; quick way to recall the last files that were open
(use-package recentf
  :init
  (setq recentf-save-file (expand-file-name "recentf" my-tmp))
  (setq recentf-max-menu-items 50)
  :config
  (add-to-list 'recentf-exclude (expand-file-name ".*" my-tmp))
  (add-to-list 'recentf-exclude (expand-file-name ".*" org-directory))
  (add-to-list 'recentf-exclude (expand-file-name "elpa/.*" user-emacs-directory))
  (add-to-list 'recentf-exclude (expand-file-name "~/.type-break"))
  (add-to-list 'recentf-exclude (expand-file-name "~/#.type-break#"))
  (recentf-mode +1))

(use-package session
  :init
  (setq session-initialize '(de-saveplace session keys menus places)
        session-globals-include '((kill-ring 50)
                                  (session-file-alist nil)
                                  (file-name-history 10000)))
  (setq session-globals-max-string 100000000)
  (setq history-length t)
  (setq session-undo-check -1)
  (setq session-save-file (expand-file-name "session" my-tmp))
  (setq session-store-buffer-places (expand-file-name "places" my-tmp))
  (add-hook 'after-init-hook 'session-initialize))

(use-package yahoo-weather
  :disabled t
  :init
  (setq yahoo-weather-location "Bangalore")
  ;; (setq yahoo-weather-location "Santa Clara, CA")
  :config
  (yahoo-weather-mode))

(use-package counsel)
(use-package ivy
  :diminish ivy-mode
  :after counsel
  :init
  (setq ivy-use-virtual-buffers t)
  :config
  (ivy-mode 1)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "C-x C-r") 'counsel-recentf))
  ;; (global-set-key (kbd "C-x C-r") 'ivy-recentf))

;;; Tool
(use-package smex
  :bind
  (("M-x" . smex)
   ("M-X" . smex-major-mode-commands))
  :init
  (setq smex-save-file (expand-file-name "smex-items" my-tmp))
  :config
  (smex-initialize))

(use-package avy
  :bind
  ("C-." . avy-goto-char)
  ("M-s" . avy-goto-word-1)
  :init
  :config
  (avy-setup-default))

;; Draw a tail in the trail of typed characters; disabled as of now;
;; to enable it, put the following in the :init section
;;  (highlight-tail-mode)
;; (use-package highlight-tail
;;   :diminish highlight-tail-mode
;;   :config
;;   (setq highlight-tail-steps 14
;; 	highlight-tail-timer 1
;; 	highlight-colors '(("black" . 0 )
;;                            ("#bc2525" . 25)
;;                            ("black" . 66))
;;         highlight-tail-posterior-type 'const))

(use-package win-switch
  :bind
  ("C-x o" . win-switch-dispatch)
  :config
  (setq win-switch-feedback-background-color "#6c96af")
  (setq win-switch-feedback-foreground-color "#000000")
  (setq win-switch-window-threshold 1)
  (setq win-switch-idle-time 0.7)
  (win-switch-set-keys '("o") 'next-window)
  (win-switch-set-keys '("p") 'previous-window))

(use-package expand-region
  :bind
  ("C-=" . er/expand-region))

(use-package which-key
  :diminish which-key-mode
  :defer 5
  :commands
  which-key-mode
  :init
  (setq which-key-idle-delay 3.0)
  :config
  (which-key-mode +1))

;; rainbow-mode to display colors as the background of the hex code
(use-package rainbow-mode
  :diminish rainbow-mode
  :defer t
  :preface
  (defun enable-rainbow-mode ()
    (when (string-match "\\(\\.emacs\\|color-theme-\\|-theme\\|init\\.el\\)" (buffer-name))
      (rainbow-mode +1)))
  :init
  (add-hook 'emacs-lisp-mode-hook #'enable-rainbow-mode)
  (dolist (hook '(css-mode-hook html-mode-hook sass-mode-hook))
    (add-hook hook #'rainbow-mode)))

;; swiper
(use-package swiper
  :ensure t
  :config
  (global-set-key (kbd "C-s") 'swiper)
  (setq ivy-display-style 'fancy)
  :init
  ;;advise swiper to recenter on exit
  (defun swiper-recenter (&rest args)
    "recenter display after swiper"
    (recenter)
    )
  (defadvice swiper-recenter (after swiper)))

;; beacon
(use-package beacon
  :diminish beacon-mode
  :config
  (setq beacon-push-mark 35)
  ;; (setq beacon-color "#666600")
  (setq beacon-color "#cccc00")
  :init
  (beacon-mode))

;; flyspell
(use-package flyspell
  :diminish flyspell-mode
  :defer t)

;; spell check
(use-package flyspell-correct-ivy
  :config
  (define-key flyspell-mode-map (kbd "C-;") #'flyspell-correct-previous-word-generic))

;;; Auto complete (company -> COMPlete ANYthing)
(use-package company
  :ensure t
  :defer t
  :diminish company-mode
  :commands company-mode
  :init
  (setq company-idle-delay 0)
  :config
  (global-company-mode)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (defadvice company-pseudo-tooltip-unless-just-one-frontend
    (around only-show-tooltip-when-invoked activate)
    (when (company-explicit-action-p) ad-do-it))
  ;; company colors with dark background
  (require 'color)
  (let ((bg (face-attribute 'default :background)))
    (custom-set-faces
     `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
     `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
     `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
     `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
     `(company-tooltip-common ((t (:inherit font-lock-constant-face)))))))

;; savehist
(use-package savehist
  :init
  (setq savehist-file (expand-file-name "savehist" my-tmp)
        history-length 10000
        history-delete-duplicates t)
  :config
  (savehist-mode +1))

;;; Smart mode line
(use-package smart-mode-line
  :init
  (setq sml/no-confirm-load-theme t)
  :config
  (sml/setup)
  (sml/apply-theme 'respectful))

;; Take a break
(use-package type-break
  :defer t
  :bind
  ("<f12>" . type-break)
  :config
  (type-break-mode))

;; Screens
(use-package escreen
  :config
  (escreen-install)
  (escreen-number-mode))

;; ibuffer
(use-package ibuffer
  :defer t
  :config
  (global-set-key (kbd "C-x C-b") 'ibuffer)
  (autoload 'ibuffer "ibuffer" "List buffers." t))

;; write good
(use-package writegood-mode
  :defer t
  :diminish writegood-mode
  :config
  (writegood-mode))

;; nyan-mode
(use-package nyan-mode
  :ensure t
  :config
  (nyan-mode))

;; xkcd
(use-package xkcd
  :defer t
  :config
  (global-set-key (kbd "C-c C-r") 'xkcd-rand))

(provide 'my-env)
