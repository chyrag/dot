;;; my-font-lock.el --- FONT-LOCK CUSTOMIZATIONS

;;----------------------------------------------
;; Joerg Arndt's  emacs startup files
;; ... online at http://www.jjj.de/
;; your feedback is welcome  mailto: arndt (AT) jjj.de
;; version: 2005-June-21 (12:50)
;;----------------------------------------------


;;; Commentary:
;; 

;;; History:
;; 

;;; Code:

;;(if (file-exists-p font-lock-mode-file)
;;    (setq font-lock-mode-file
;;          (concat
;;           "/usr/share/emacs/"
;;           emacs-major-version "." emacs-minor-version
;;           "/lisp/font-lock.el")))
;;(message font-lock-mode-file)

(progn
  (require 'font-lock)

  ;; always use font-lock-mode:
  (global-font-lock-mode t) ;; causes slowdown
  (toggle-global-lazy-font-lock-mode)

  ;; Maximum size of a buffer for buffer fontification.
  ;; Only buffers less than this can be fontified when Font Lock mode is turned on.
  ;; If nil, means size is irrelevant.
  (setq font-lock-maximum-size 200000)

  (setq font-lock-maximum-decoration t)

  (make-face 'sh-heredoc-face)   ; for cat <<EOF in shell scripts
  (make-face 'font-latex-math-face)   ;
  (make-face 'font-lock-builtin-face)   ;
  (make-face 'font-lock-comment-face)   ;
  (make-face 'font-lock-constant-face)  ; constant and label names
  (make-face 'font-lock-function-name-face) ;
  (make-face 'font-lock-keyword-face)   ;
  (make-face 'font-lock-string-face)    ;
  (make-face 'font-lock-type-face)      ; type and class names
  (make-face 'font-lock-variable-name-face) ;
  (make-face 'font-lock-warning-face) ; for things that should stand out

  (set-face-foreground 'sh-heredoc-face "slategray")
  (set-face-foreground 'font-latex-math-face "green")
  (set-face-foreground 'font-lock-builtin-face "magenta")
  (set-face-foreground 'font-lock-comment-face "yellow")
  (set-face-foreground 'font-lock-constant-face "red")
  (set-face-foreground 'font-lock-function-name-face "cyan")
  (set-face-foreground 'font-lock-keyword-face "green")
  (set-face-foreground 'font-lock-string-face "red")
  (set-face-foreground 'font-lock-type-face "green")
  (set-face-foreground 'font-lock-variable-name-face "goldenrod")
  (set-face-foreground 'font-lock-warning-face "red")

  ;; Recognise operator-names and/bitand/bitor/compl/not/or/xor:
;;  (font-lock-add-keywords
;;   'c++-mode
;;   '("\\<\\(and\\|bitand\\|or\\|bitor\\|compl\\|not\\|xor\\)\\>"))

  (font-lock-add-keywords
   'c++-mode
   '(("\\<\\(return\\)" 1 font-lock-builtin-face)
     ("\\<\\(restrict\\)" 1 font-lock-keyword-face)) )

  (setq c++-font-lock-extra-types
        '(
          ;;              "size_t" ;; not needed: *_t already built in
          "Complex" "complex"
          "ldouble" ;; long double
          "uint" "ulong" "ushort" "uchar" ;; unsigned
          "int32" "uint32" "int64" "uint64" ;; int types
          ;;              "string"
          ;;              "Integer" "Rational"    ;; GNU types
          "mod" ;; for mod
          "umod_t" "smod_t"
          "hfloat" "hfdata" "LIMB" ;; for hfloat
          "Type" "Type0" "Type1" "Type2" "Type3" "Type4" ;; for templates
          ;;              "F_Type" "I_Type" "SI_Type" "UI_Type" ;; for templates
          ) )


  (font-lock-add-keywords
   'c-mode
   '(("\\<\\(return\\)" 1 font-lock-builtin-face)
     ("\\<\\(asm\\)" 1 font-lock-keyword-face)
     ) )

  (font-lock-add-keywords
   'latex-mode
   '(
     ("\\<\\(jjlabel\\)" 1 font-lock-constant-face)
     ("\\<\\(jjformula\\)" 1 font-lock-constant-face)
     ("\\<\\(jjvref\\)" 1 font-lock-constant-face)
     ("\\<\\(jjref\\)" 1 font-lock-constant-face)
     ("\\<\\(jjpageref\\)" 1 font-lock-constant-face)
     ("\\<\\(jjcite\\)" 1 font-lock-builtin-face)
     ("\\<\\(jjxinput\\)" 1 font-lock-builtin-face)
     ("\\<\\(jjignore\\)" 1 font-lock-warning-face)
     ("\\<\\(jjfile\\)" 1 font-lock-warning-face prepend) ;; even inside comments
     ("\\<\\(jjTODO\\)" 1 font-lock-warning-face prepend) ;; even inside comments
     ("\\<\\(jjTodo\\)" 1 font-lock-warning-face prepend) ;; even inside comments
     ) )
)
;;  ) ;; (if (file-exists-p " ... font-lock.el")


(provide 'my-font-lock)

;;; my-font-lock.el ends here
