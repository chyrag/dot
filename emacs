;;; -*-Emacs-Lisp-*-

;; General stuff ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; load elisp files from home directory as well.
(setq load-path (cons (expand-file-name "~/.elisp/") load-path)
      inhibit-startup-message t		;; no startup messages
      inhibit-startup-echo-area-message t
      disabled-command-hook nil 	;; don't irritate me with disabled commands
      tty-suppress-bold-inverse-default-colors t	;; supress bright colors
      show-paren-mode t			;; highlight matching brackets
      scroll-step 1			;; scroll one line at a time
      					;; (instead of scrolling half a page)
      transient-mark-mode 't		;; show the marked region
      visible-bell t			;; no audible bell
      next-line-add-newlines nil	;; stop at the end of the file, not just add lines
      require-final-newline t		;; always end a file with a newline
      line-number-mode t 		;; show linecolumn number in the modeline
      column-number-mode t
      make-backup-files nil		;; no backups
      auto-save-interval 0
      auto-save-timeout 600
      confirm-kill-emacs 'y-or-n-p)

;; font lock mode
(global-font-lock-mode t)
;; we don't want the tool-bar/menu-bar/time
(fset 'menu-bar-open nil)
(menu-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(scroll-bar-mode -1)
(display-time-mode -1)

;; remap keys
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M- " 'set-mark-command)
(global-set-key "\M-\C-h" 'backward-kill-word)
(global-set-key "\M-\C-r" 'query-replace)
(global-set-key "\M-r" 'replace-string)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-h" 'help-command)
(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-right>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-left>") 'enlarge-window-horizontally)

;; custom screen splitting
(defun vsplit-last-buffer ()
  (interactive)
  (split-window-vertically)
  (other-window 1 nil)
  (switch-to-next-buffer)
  )
(defun hsplit-last-buffer ()
  (interactive)
  (split-window-horizontally)
  (other-window 1 nil)
  (switch-to-next-buffer)
  )
(global-set-key (kbd "C-x 2") 'vsplit-last-buffer)
(global-set-key (kbd "C-x 3") 'hsplit-last-buffer)

;; smart modeline
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" "756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Programming mode?
;; my sandboxes
(require 'my-prog-settings)

;; mail setup
(require 'my-mailsetup)

;; TODO: org-mode?

;; printer
;; need custom command to print directly
;; a2ps -P HP_HP_LaserJet_400_MFP_M425dn -s duplex
(setq ps-printer-name "HP_HP_LaserJet_400_MFP_M425dn"
      ps-printer-name-option "-P"
      ps-lpr-command "a2ps"
      ps-spool-duplex t
      ps-auto-font-detect nil
      ps-print-color-p nil)

;; screens
(load "escreen")
(escreen-install)

;; revbuffs
;;
;; eof
