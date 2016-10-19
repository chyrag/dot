;;; -*-Emacs-Lisp-*-

;; offlineimap
(require 'offlineimap)

;; funny stuff
(autoload 'sm-add-random-header "silly-mail" nil t)
;; (add-hook 'mail-setup-hook 'sm-add-random-header)
(setq sm-add-ramdom-header-to-mail t)

;; write good
(add-hook 'message-mode-hook 'writegood-mode)

;; mail variables
(setq mm-text-html-renderer 'w3m    	;; use w3m to view html mail
      message-fill-column 72        	;; wrap text at column 72
      message-kill-buffer-on-exit t 	;; kill buffer after sending mails
      message-mode-hook (quote (flyspell-mode)) 	;; spell check
      message-citation-line-function 'message-insert-formatted-citation-line 	;; citation line
      message-citation-line-format "On %a, %b %d %Y at %r, %f wrote:"
      ;; message-directory "~/Maildir/[Gmail].Drafts"
      ;; message-send-mail-function 'smtpmail-send-it
      ;; message-send-mail-function 'message-send-mail-with-sendmail
      message-send-mail-function 'smtpmail-send-it
      send-mail-function 'smtpmail-send-it
      ;; message-auto-save-directory "~/Maildir/[Gmail].Drafts"
      message-auto-save-directory "~/.drafts"
      message-sendmail-f-is-evil t
      mail-envelope-from 'header
      mail-specify-envelope-from 'header
      message-sendmail-envelope-from 'header

      smtpmail-stream-type 'ssl
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 465)

;; message templates
(use-package message-templ
  :bind
  ("C-c s" . message-templ-select)
  :init
  (setq message-templ-config-alist '(("^To: rahatresidency@yahoogroups.com"
                                      (lambda ()
                                        (message-templ-apply "alternate"))
                                      ("X-List-To" . "notmuch"))))
  ;; (setq message-templ-config-alist '(("^To:.*notmuch@notmuchmail.org" my-func)))

  (setq message-templ-alist '(("alternate"
                               ("From" . "Chirag Kantharia (Rahat Residency) <chirag.kantharia@gmail.com>")
                               ("Bcc" . "chyrag@yahoo.com")
                               (body-file . "~/archives/rahat/rr_maintenance_template.txt"))
                              ("student-inquiry"
                               ("Subject" . "Your inquiry about foo")
                               (body-file . "~/config/dat/student09.txt"))
                              ("course-marks"
                               ("Subject" . "Marks for CSXXXX")
                               ("Bcc" . "david@example.com")
                               (top-file . "~/teaching/csXXXX/marks-top.msg")
                               (bottom-file . "~/teaching/csXXXX/marks-bottom.msg"))))
  :config
  (message "Message templating ready!"))

;; not much config comes here
(use-package notmuch
  :defer t
  :config
  (setq notmuch-fcc-dirs nil
        notmuch-hello-logo nil
        notmuch-saved-searches
        '((:name "to me" :query "(to:chirag OR cc:chirag) AND tag:unread" :key "m")
          (:name "new"   :query "tag:unread"                              :key "u")
          (:name "flagged" :query "tag:flagged"                           :key "f")
          (:name "today" :query "date:today..now"                         :key "t")
          (:name "yesterday" :query "date:yesterday..yesterday"           :key "y")
          (:name "this week" :query "date:sunday..now"                    :key "w")
          (:name "last week" :query "date:last_week..sat"                 :key "l")
          (:name "sent this week"  :query "tag:replied AND date:sun..now")
          (:name "sent last week"  :query "tag:replied AND date:last_week..sat")
          (:name "all"      :query "*")
          (:name "all sent" :query "tag:replied"))
        notmuch-search-result-format
        '(("date"    . "%12s ")
          ("count"   . "%6s ")
          ("authors" . "%-23s ")
          ("subject" . "%s ")
          ("tags"    . "(%s)"))
        notmuch-search-line-faces
        '(("unread"  . (:foreground "green"))
          ("deleted" . (:foreground "red"))
          ("flagged" . (:foreground "orange")))
	notmuch-address-command 'internal)
  (global-set-key (kbd "C-c m") 'notmuch)
  ;; spam
  (define-key notmuch-show-mode-map "S"
    (lambda ()
      "mark message as spam"
      (interactive)
      (notmuch-show-tag (list "+spam" "-inbox"))))
  (define-key notmuch-search-mode-map "S"
    (lambda ()
      "mark message as spam"
      (interactive)
      (notmuch-search-tag (list "-inbox" "+spam"))
      (next-line) ))

  ;; flag message to respond later
  (define-key notmuch-show-mode-map "L"
    (lambda ()
      "mark message to be responded Later"
      (interactive)
      (notmuch-show-tag (list "+flagged" "-inbox"))))
  (define-key notmuch-search-mode-map "L"
    (lambda ()
      "mark message to be responded Later"
      (interactive)
      (notmuch-search-tag (list "+flagged" "-inbox"))
      (next-line) ))

  ;; delete mail
  (define-key notmuch-show-mode-map "d"
    (lambda ()
      "mark message to be deleted"
      (interactive)
      (notmuch-show-tag (list "+deleted" "-inbox"))))
  (define-key notmuch-search-mode-map "d"
    (lambda ()
      "mark message to be deleted"
      (interactive)
      (notmuch-search-tag (list "-inbox" "+deleted"))
      (next-line) ))

  ;; start polling for mails using offlineimap
  (offlineimap))

(provide 'notmuch-config)
