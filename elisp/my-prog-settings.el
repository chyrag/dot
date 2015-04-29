;;; -*-Emacs-Lisp-*-

;; Programming mode?

;; my sandboxes
(require 'my-sandboxes)

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

(provide 'my-prog-settings)
