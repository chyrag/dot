;;; -*-Emacs-Lisp-*-

;; General stuff ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load elisp files from home directory as well.
(setq load-path (cons (expand-file-name "~/.elisp/") load-path))
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
;; don't irritate me with disabled commands
(setq disabled-command-hook nil)
;; supress bright colors
(tty-suppress-bold-inverse-default-colors t)
;; highlight matching brackets
(show-paren-mode t)
;; scroll one line at a time (instead of scrolling half a page)
(setq scroll-step 1)
;; show the marked region
(setq transient-mark-mode 't)
;; no audible bell
(setq visible-bell t)
;; stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)
;; always end a file with a newline
(setq require-final-newline t)
;; show linecolumn number in the modeline
(setq line-number-mode t)
(setq column-number-mode t)
;; we don't want the tool-bar/menu-bar/time
(fset 'menu-bar-open nil)
(menu-bar-mode -1)
(global-font-lock-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(scroll-bar-mode -1)
(display-time-mode -1)
;; no backups
(setq make-backup-files nil)
(setq auto-save-interval 0)
(setq auto-save-timeout 600)
;; font lock mode
(global-font-lock-mode t)
;; confirm exiting emacs
(setq confirm-kill-emacs 'y-or-n-p)

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

;; my sandboxes
(require 'my-sandboxes)

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


;; Fraley's insert current date function
;; Thu 8/25, 15:43:46
(defun insert-current-date ()
  "Insert the current date and time at the current point"
  (interactive)
  (let* ((date (current-time-string))
         (foo (string-match
	       (concat
		"\\([A-Z][a-z][a-z]\\) *"
		"\\([A-Z][a-z][a-z]\\) *"
		"\\([0-9]*\\) *"
		"\\([0-9:]*\\) *"
		"\\([0-9]*\\)$")
	       date))
	 (weekday (substring date (match-beginning 1) (match-end 1)))
	 (day (substring date (match-beginning 3) (match-end 3)))
	 (time (substring date (match-beginning 4) (match-end 4)))
	 (month
	  (cdr (assoc
		(substring date (match-beginning 2) (match-end 2))
		'(("Jan" . "1") ("Feb" . "2")  ("Mar" . "3")  ("Apr" . "4")
		  ("May" . "5") ("Jun" . "6")  ("Jul" . "7")  ("Aug" . "8")
		  ("Sep" . "9") ("Oct" . "10") ("Nov" . "11") ("Dec" . "12")))))
	 (year (substring date (match-beginning 5) (match-end 5))))
    (insert (concat weekday " " month "/" day ", " time))))


;; Programming ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;
;;; Format code the Juniper way
;;;

(require 'cc-mode)
(setq orig-c-style-alist c-style-alist)
(c-add-style "juniper"
	     '(
	       (c-basic-offset . 4)
	       (c-comment-only-line-offset . 0)
	       (c-offsets-alist
		. (
		   ;; first line of a new statement block
		   (statement-block-intro . +)
		   
		   ;; First line of a K&R C argument declaration.
		   (knr-argdecl-intro . +)

		   ;; The brace that opens a substatement block.
		   (substatement-open . 0)

		   ;; Any non-special C label.
		   (label . 2)

		   ;; A `case' or `default' label.
		   (case-label . 0)

		   ;; The first line in a case block that starts with
		   ;; a brace.
		   (statement-case-open . +)

		   ;; A continuation of a statement.
		   (statement-cont . +)

		   ;; The first line after a conditional or loop
		   ;; construct.
		   (substatement . +)

		   ;; The first line in an argument list.
		   (arglist-intro . c-lineup-arglist-intro-after-paren)

		   ;; The solo close paren of an argument list.
		   (arglist-close . c-lineup-arglist)

		   ;; Brace that opens an in-class inline method.
		   (inline-open . 0)

		   ;; Open brace of an enum or static array list.
		   (brace-list-open . 0)))

	       (c-special-indent-hook . c-gnu-impose-minimum)
	       (c-block-comment-prefix . "")))

(defun juniper-c-default-style ()
  "Set the default c-style for Juniper."
  (interactive)
  (define-key c-mode-map "\r" 'newline-and-indent)
  (c-set-style "juniper")
  (flyspell-mode)
  (setq vc-svn-diff-switches '"-u")
  (define-key c-mode-map "\C-cd" 'vc-diff)
  (setq dabbrev-case-replace nil)
  (setq indent-tabs-mode nil)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)

  (defun toggle-tab-width ()
    "Toggle the value of tab-width between 4 and 8"
    (interactive)
    (if (= tab-width 8)
      (setq tab-width 4)
      (if (= tab-width 4)
	(setq tab-width 8)))
    (scroll-up 0))

  (defun toggle-c-offset ()
    "Toggle the value of c-basic-offset between 4 and 8"
    (interactive)
    (if (= c-basic-offset 8)
      (setq c-basic-offset 4)
      (if (= c-basic-offset 4)
	(setq c-basic-offset 8)))
    (scroll-up 0))

  ;; Complement to next-error
  (defun previous-error (n)
    "Visit previous compilation error message and corresponding source code."
    (interactive "p")
    (next-error (- n)))
  (abbrev-mode nil))
(add-hook 'c-mode-common-hook 'juniper-c-default-style)

;; waf
(setq auto-mode-alist (cons '("wscript" . python-mode) auto-mode-alist))
(setq compile-command "build-flexvnf.sh")

;; idutils
;; (autoload 'gid "ID" nil t)

;; cscope
(require 'xcscope)
(cscope-setup)
(setq cscope-no-mouse-prompts t)
(setq cscope-do-not-update-database t)
(setq cscope-close-window-after-select t)
(cscope-setup)

;;; Emulate vi's ":set list" command.  Setting is buffer-local and
;;; won't screw up the rest of the editor session.  This probably
;;; should be a minor mode instead of two global functions.  Consider
;;; using the whitespace.el or show-whitespace-mode.el packages.

(defvar vi-list-display-table (make-display-table)
  "vi-list display table for showing tabs and EOLs")
(aset vi-list-display-table ?\t (vconcat "^I"))
(aset vi-list-display-table ?\n (vconcat "$\n"))

(defun vi-list ()
  "Simulate a :set list in Vi."
  (interactive)
  (setq buffer-display-table vi-list-display-table))

(defun vi-nolist ()
  "Simulate a :set nolist in Vi."
  (interactive)
  (setq buffer-display-table nil))


;; bbdb
(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)

;; diary

;; printer
;; need custom command to print directly
;; a2ps -P HP_HP_LaserJet_400_MFP_M425dn -s duplex
(setq ps-printer-name "HP_HP_LaserJet_400_MFP_M425dn"
      ps-printer-name-option "-P"
      ps-lpr-command "a2ps"
      ps-spool-duplex t
      ps-auto-font-detect nil
      ps-print-color-p nil)

;; emacs server
;; (server-start)

;; workgroups
;; (require 'workgroups)

;; screens
(load "escreen")
(escreen-install)

;; elscreen
;; (require 'elscreen)
;; (require 'elscreen-bg)


;; eof
