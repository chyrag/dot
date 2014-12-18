; ~/.vm-init

;; mutt aliases
(require 'mutt-alias)
;; biff
(require 'vm-biff)
;; vm-color
(require 'u-vm-color)
(add-hook 'vm-summary-mode-hook 'u-vm-color-summary-mode)
(add-hook 'vm-select-message-hook 'u-vm-color-fontify-buffer)

(setq 

;; Personal settings
    user-full-name "Chirag Kantharia"
    user-mail-address "chirag@juniper.net"
    mail-user-agent 'vm-user-agent
    mail-signature t

;; mail folders
    vm-folder-directory "~/mail"
    vm-imap-folder-cache-directory "~/.mail-cache"

;; spools
    vm-imap-account-alist
        '(("imap-ssl:imap-bng.jnpr.net:993:*:login:chirag:*"  "jnpr"))
    vm-primary-inbox
        "imap-ssl:imap-bng.jnpr.net:993:INBOX:login:chirag:*"

;; virtual folders
    vm-virtual-folder-alist
      '(
         ("svn" ('vm-primary-inbox
                 (and (recipient "svn-changes") (subject "[svn-commit]"))))
         ("cvs" ('vm-primary-inbox
                 (and (recipient "cvs-all") (subject "cvs commit:"))))
         ("bm"  ('vm-primary-inbox
                (recipient "bangalore-misc")))
       )

;; mail display
    vm-preview-lines nil
    vm-highlighted-header-regexp "^From\\|^Subject\\|^Date\\|^CC\\|^Cc\\|To"
    vm-auto-displayed-mime-content-types '("text" "multipart")
    vm-mime-internal-content-type-exceptions '("text/html")
    vm-mime-type-converter-alist
    '(
        ("text/html" "text/plain" "w3m -T text/html -dump")
    )

;; reply/forward composition
    vm-reply-subject-prefix "Re: "
    vm-included-text-attribution-format "On %y/%M/%d at %H (%z), %F wrote:\n"
    vm-included-text-prefix "| "
    vm-in-reply-to-format nil
    vm-forwarding-subject-format "[forwarded from %F] %s"
    vm-forwarding-digest-type "rfc934"

;; vm behaviour
    vm-auto-get-new-mail t
    vm-delete-after-archiving t
    vm-delete-after-saving t
    vm-move-after-deleting t
)


;;*****************************************************************************
;; A hook function to setup mail-composing buffers
(defun chirag-vm-mail-mode-hook ()
  "Chirag Kantharia `vm-mail-mode-hook'."
  (interactive)

  (when (string-match "received" (buffer-name))
    (make-local-variable 'vm-confirm-quit)
    (setq vm-confirm-quit t))
  
  (setq fill-column 70
        comment-start "> "
        indent-line-function 'indent-relative-maybe)
  
  ;; mark lines longer than `fill-column' chars red 
  (add-to-list 'mail-font-lock-keywords
               (list (concat "^" (make-string fill-column ?.)
                             "\\(.+$\\)")
                     '(1 font-lock-warning-face t)))
  
  (font-lock-mode 1)
  (turn-on-auto-fill)
  (turn-on-filladapt-mode)
  (flyspell-mode 1)
; (enriched-mode 1)
; (auto-capitalize-mode)
; (vm-mail-subject-prefix-cleanup)
  )

(add-hook 'vm-mail-mode-hook 'chirag-vm-mail-mode-hook)
(add-hook 'vm-quit-hook 'vm-expunge-folder)

(require 'boxquote)
(defun boxquote-region-and-edit-title (s e)
  (interactive "r")
  (boxquote-region s e)
  (call-interactively 'boxquote-title))

;;*****************************************************************************
;; Now change some keyboard bindings 
(define-key vm-mode-map [(meta up)]    'vm-previous-unread-message)
(define-key vm-mode-map [(meta down)]  'vm-next-unread-message)
(define-key vm-mode-map "C"     'vm-continue-postponed-message)
(define-key vm-mode-map "T"     'vm-toggle-mark)
(define-key vm-mode-map "s"     'vm-save-message-to-imap-folder)
(define-key vm-mode-map "\C-a"  'vm-mime-auto-save-all-attachments)
(define-key vm-mode-map "VI"    'vm-visit-imap-folder)
(define-key vm-mode-map "VV"    'vm-visit-virtual-folder)
(define-key vm-mode-map [(control s)] 'isearch-forward)
(define-key vm-mode-map "K"     'vm-kill-subject)
(define-key vm-mode-map "j"     'vm-next-message)
(define-key vm-mode-map "k"     'vm-previous-message)
(define-key vm-mode-map ";"     'vm-next-command-uses-marks)

(define-key vm-summary-mode-map [(control up)] 'previous-line)
(define-key vm-summary-mode-map [(control down)] 'next-line)
(define-key vm-summary-mode-map [(control s)] 'vm-isearch-forward)

(define-key vm-mail-mode-map [tab] 'indent-relative)
(define-key vm-mail-mode-map [(control tab)] 'mail-interactive-insert-alias)
(define-key vm-mail-mode-map [return] 'newline-and-indent)
(define-key vm-mail-mode-map "\C-c\C-o" 'vm-serial-expand-tokens)
(define-key vm-mail-mode-map [(control c) (control I)] 'vm-serial-insert-token)
(define-key vm-mail-mode-map [(control meta delete)] 'kill-this-buffer)
(define-key vm-mail-mode-map "\C-c\C-i" 'vm-mail-mode-comment-region)
(define-key vm-mail-mode-map "\C-c\C-d" 'vm-mail-mode-elide-reply-region)
(define-key vm-mail-mode-map "\C-c\C-k" 'vm-mail-mode-citation-clean-up)
(define-key vm-mail-mode-map "\C-c\C-a" 'vm-mime-attach-file)
(define-key vm-mail-mode-map "\C-c\C-b" 'boxquote-region-and-edit-title)

;;; .vm ends here
