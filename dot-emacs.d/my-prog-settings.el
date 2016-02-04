;;; -*-Emacs-Lisp-*-

;; Programming mode?

;; my sandboxes
(require 'my-sandboxes)

;; projectile
;; (require 'projectile)
;; (projectile-global-mode)
;; (setq projectile-completion-system 'helm)
;; (helm-projectile-on)

;; whitespace variables
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face empty tabs lines-tail trailing))


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
  ;; (define-key c-mode-map "\r" 'newline-and-indent)
  (c-set-style "juniper")
  (flyspell-mode)
  (projectile-mode)
  (setq vc-svn-diff-switches '"-u")
  (define-key c-mode-map "\C-cd" 'vc-diff)
  (setq dabbrev-case-replace nil)
  (setq indent-tabs-mode nil)
  (setq tab-always-indent 'complete)
  (electric-indent-mode t)
  ;; (electric-pair-mode t) ; damn irritating!
  ;; (add-hook 'before-save-hook 'delete-trailing-whitespace
  (whitespace-mode)
  (show-paren-mode t)
  (setq show-paren-style 'parenthesis)

  (defun toggle-tab-width ()
    "Toggle the value of tab-width between 4 and 8"
    (interactive)
    (if (= tab-width 8)
	(setq tab-width 4)
      ((insert )f (= tab-width 4)
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

;; python
(add-hook 'python-mode-hook '(lambda ()
			       (local-set-key (kbd "RET") 'newline-and-indent)
			       (setq python-indent-offset 4)))

;; Versa XML file settings
(setq nxml-child-indent 4
      nxml-attribute-indent 4
      nxml-slash-auto-complete-flag t)

;; waf
(setq auto-mode-alist (cons '("wscript" . python-mode) auto-mode-alist))
(setq compile-command "build-flexvnf.sh")

;; parens
(require 'paren)
(show-paren-mode t)
(setq show-paren-style 'parenthesis)
;; (setq show-paren-style 'expression)

;; idutils
;; (autoload 'gid "ID" nil t)

;; git
;; (autoload 'git "git" "Load GIT module" t nil)
;; (require 'git)

;; cscope
(require 'xcscope)
(setq cscope-option-do-not-update-database t)
(setq cscope-close-window-after-select t)
(setq cscope-option-use-inverted-index t)
(cscope-setup)

;; autoload gdb-script-mode while editing .gdb files
(add-to-list 'auto-mode-alist '("\\.gdb$" . gdb-script-mode))

;; magit
(autoload 'magit-status "magit" "Open a Magit status buffer [\u2026]" t nil)

;; start yasnippet with emacs
;; (require 'yasnippet)
;; (yas-global-mode 1)

;; bugz
;;(require 'bugz-mode)
;;(setq bugz-db-base "http://bugzilla.versa-networks.com/xmlrpc.cgi")
;;(setq bugz-db-user "chirag@versa-networks.com")

; turn on automatic reparsing of open buffers in semantic
;; (global-semantic-idle-scheduler-mode 1)

;; start yasnippet with emacs
;;(require 'yasnippet)
;;(yas-global-mode 1)

(provide 'my-prog-settings)
