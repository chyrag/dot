;;; NAME:
;;;	fdate.el - implement fdate-string in elisp
;;;
;;; SYNOPSIS:
;;;	(fdate-string "format")
;;;
;;; DESCRIPTION:
;;;	This module simply provides an elisp interface to a
;;;	programe identified by fdate-process (date(1) by
;;;	default).
;;;	If using date(1), fdate-string will add the necessary '+'
;;;	to "format".
;;;
;;; 	To install: add this to .emacs
;;; 	(autoload 'fdate-string "fdate" "formatted date/time")
;;;
;;; SEE ALSO:
;;;      ftime.c
;;;

;;; RCSid:
;;;	$Id$

(provide 'fdate-string)

(defvar fdate-process "date"
  "*Program used to format date/time info.")
(defvar fdate-options nil
  "*Options for fdate-process")
(defvar fdate-eat-nl t
  "*Eat the newline output by fdate-process.")

(defun fdate-string (fmt)
  "Call fdate-process to format date/time."
  (interactive)
  (call-process "/bin/sh" nil t nil
		"-c" (concat fdate-process " " (if fdate-options
						   fdate-options)
			     "'"
			     (if (string-equal fdate-process "date")
				 "+")
			     fmt "'")
		)
    (if fdate-eat-nl
	(backward-delete-char 1 nil))
  )
  
  
