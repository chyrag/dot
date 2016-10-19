(require 'mu4e)

;; funny stuff
(autoload 'sm-add-random-header "silly-mail" nil t)
;; (add-hook 'mail-setup-hook 'sm-add-random-header)
(setq sm-add-ramdom-header-to-mail t)

;; write good
(add-hook 'message-mode-hook 'writegood-mode)
(add-hook 'message-mode-hook 'flyspell-mode)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t
      message-fill-column 72
      mm-text-html-renderer 'w3m
      message-citation-line-function 'message-insert-formatted-citation-line 	;; citation line
      message-citation-line-format "On %a, %b %d %Y at %r, %f wrote:"
      message-send-mail-function 'smtpmail-send-it
      send-mail-function 'smtpmail-send-it
      message-auto-save-directory "~/.drafts"
      message-sendmail-f-is-evil t
      mail-envelope-from 'header
      mail-specify-envelope-from 'header
      message-sendmail-envelope-from 'header)

;; mu4e variables
(setq mu4e-maildir "~/Maildir"
      mu4e-drafts-folder "/[Gmail].Drafts"
      mu4e-sent-folder   "/[Gmail].Sent Mail"
      mu4e-trash-folder  "/[Gmail].Trash"
      mu4e-sent-messages-behavior 'delete
      mu4e-maildir-shortcuts
      '( ("/INBOX"               . ?i)
         ("/[Gmail].Sent Mail"   . ?s)
         ("/[Gmail].Trash"       . ?t)
         ("/[Gmail].All Mail"    . ?a))
      mu4e-get-mail-command "offlineimap")

(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
      send-mail-function 'smtpmail-send-it
      smtpmail-stream-type 'ssl
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 465)

;; alternatively, for emacs-24 you can use:
;;(setq message-send-mail-function 'smtpmail-send-it
;;     smtpmail-stream-type 'starttls
;;     smtpmail-default-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-service 587)


;; message templates
(use-package message-templ
  :bind
  ("C-c s" . message-templ-select)
  :init
  (setq message-templ-config-alist '(("^To: rahatresidency@googlegroups.com"
                                      (lambda ()
                                        (message-templ-apply "maintenance"))
                                      ("X-List-To" . "notmuch"))))
  ;; (setq message-templ-config-alist '(("^To:.*notmuch@notmuchmail.org" my-func)))

  (setq message-templ-alist '(("maintenance"
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

(provide 'mu4e-config)
