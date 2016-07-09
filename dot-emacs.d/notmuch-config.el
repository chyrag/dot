;;; -*-Emacs-Lisp-*-

;; offlineimap
(require 'offlineimap)

;; funny stuff
(autoload 'sm-add-random-header "silly-mail" nil t)
;; (add-hook 'mail-setup-hook 'sm-add-random-header)
(setq sm-add-ramdom-header-to-mail t)

;; mail variables
(setq user-full-name "Chirag Kantharia"
      user-mail-address "chirag.kantharia@gmail.com"
      mm-text-html-renderer 'w3m    	;; use w3m to view html mail
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

;; bbdb
(setq bbdb-file "~/.emacs.d/bbdb")           ;; keep ~/ clean; set before loading
;; (require 'bbdb)
(autoload 'bbdb "bbdb" "big brother database" t)
(bbdb-initialize)
(setq bbdb-offer-save 1                        ;; 1 means save-without-asking
      bbdb-use-pop-up nil                      ;; allow popups for addresses
      bbdb-electric-p t                        ;; be disposable with SPC
      bbdb-dwim-net-address-allow-redundancy t ;; always use full name
      bbdb-quiet-about-name-mismatches 2       ;; show name-mismatches 2 secs
      bbdb-always-add-address t                ;; add new addresses to existing...
                                               ;; ...contacts automatically
      bbdb-canonicalize-redundant-nets-p t     ;; x@foo.bar.cx => x@bar.cx
      bbdb-completion-type nil                 ;; complete on anything
      bbdb-complete-name-allow-cycling t       ;; cycle through matches
                                               ;; this only works partially
      bbbd-message-caching-enabled t           ;; be fast
      bbdb-use-alternate-names t               ;; use AKA
      bbdb-elided-display t                    ;; single-line addresses
                                               ;; auto-create addresses from mail
      bbdb/mail-auto-create-p 'bbdb-ignore-some-messages-hook
      bbdb-ignore-some-messages-alist ;; don't ask about fake addresses
      ;; NOTE: there can be only one entry per header (such as To, From)
      ;; http://flex.ee.uec.ac.jp/texi/bbdb/bbdb_11.html
      '(( "From" . "no.?reply\\|DAEMON\\|daemon\\|bugzilla\\|jenkins")))

;; (define-key message-minibuffer-local-map [(tab)] 'bbdb-complete-name)
;; (set-face-background 'notmuch-message-summary-face "sea green")


;; smtp mail settings (nullmailer)
;; (setq smtpmail-smtp-server "localhost"
;;      smtpmail-smtp-service 25)


;; not much config comes here

(use-package notmuch
  :defer t
  :init
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
          ("flagged" . (:foreground "orange"))))
  :config
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
      (notmuch-show-tag (list "+flagged"))))
  (define-key notmuch-search-mode-map "L"
    (lambda ()
      "mark message to be responded Later"
      (interactive)
      (notmuch-search-tag (list "+flagged"))
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


;; it would be good if the following could work without confirming
;; (add-hook 'kill-emacs-hook 'offlineimap-quit))

;; not much
;; (autoload 'notmuch "notmuch" "notmuch mail" t)
;; (require 'notmuch)
;; (setq notmuch-fcc-dirs nil	;; Gmail saves sent mails by itself
;;       notmuch-hello-logo nil    ;; no logo
;;       notmuch-saved-searches
;;       '((:name "to me"     :query "(to:chirag OR cc:chirag) AND tag:unread" :key "m")
;; 	(:name "new"       :query "tag:unread"                              :key "n")
;; 	(:name "today"     :query "date:today..now"                         :key "t")
;; 	(:name "yesterday" :query "date:yesterday..yesterday"               :key "y")
;; 	(:name "this week" :query "date:7days..now"                         :key "w")
;; 	(:name "flagged"   :query "tag:flagged"                             :key "f")
;; 	(:name "sent this week" :query "date:7days..now AND from:chirag@versa-networks.com" :key "s")
;; 	(:name "drafts"    :query "tag:draft"                               :key "d")
;; 	(:name "all mail"  :query "*"                                       :key "a"))
;;       )

;; (use-package notmuch
;;   :bind ("C-c n" . notmuch-hello)
;;   :defer t
;;   :init
;;   (setq notmuch-fcc-dirs nil
;;         notmuch-hello-log nil
;;         notmuch-saved-searches
;;         '((:name "to me" :query "(to:chirag OR cc:chirag) AND tag:unread" :key "m")
;;           (:name "new"   :query "tag:unread"                              :key "n")
;;           (:name "today" :query "date:today..now"                         :key "t")
;;           (:name "yesterday" :query "date:yesterday..yesterday"           :key "y")
;;           (:name "this week" :query "date:7days..now"                     :key "w")
;;           (:name "flagged"   :query "tag:flagged"                         :key "f")
;;           (:name "sent this week" :query "date:7days..now AND from:chirag@versa-networks.com" :key "s")
;;           (:name "drafts" :query "tag:draft" :key "d")
;;           (:name "all mail" :query "*")))
;;   :config
;;   ;; Change flagged lines to be dark blue in the background, not blue
;;   ;; in the foreground. This harmonizes much more with my dark theme.
;;   (add-to-list 'notmuch-search-line-faces
;;   			   '("flagged" :background "dark blue"))
;;
;;   (setq notmuch-search-result-format
;;         '(("date" . "%12s ")
;;           ("count" . "%6s ")
;;           ("authors" . "%-23s ")
;;           ("subject" . "%s ")
;;           ;; ("tags" . "(%s)")
;;           ))
;;   ;; spam
;;   (define-key notmuch-show-mode-map "S"
;;     (lambda ()
;;       "mark message as spam"
;;       (interactive)
;;       (notmuch-show-tag (list "+spam" "-inbox"))))
;;
;;   (define-key notmuch-search-mode-map "S"
;;     (lambda ()
;;       "mark message as spam"
;;       (interactive)
;;       (notmuch-search-tag (list "-inbox" "+spam"))
;;       (next-line) )))
;;
;;
;; (defface my-notmuch-hello-header-face
;;   '((t :foreground "white"
;;        :background "blue"
;;        :weight bold))
;;   "Font for the header in `my-notmuch-hello-insert-searches`."
;;   :group 'notmuch-faces)
;;
;; ;;;; (setq notmuch-saved-searches
;; ;;;;       '(
;; ;;;; ;; why the fuck doesn't this work?
;; ;;;; ;;	(:name "inbox" :query "tag:inbox OR tag:unread" :count-query "tag:unread")
;; ;;;; ;;	(:name "today" :query "date:today..now" :count-query "tag:unread")
;; ;;;; ;; the inbox tag is _all_ the incoming mail; we dont need it here
;; ;;;; ;; ("inbox"     . "tag:inbox")
;; ;;;; 	("to me"       .  "(to:chirag OR cc:chirag) AND tag:unread")
;; ;;;; 	(:name "new" :query "tag:unread" :count-query "tag:unread")
;; ;;;; 	("today"       . "date:today..today")
;; ;;;; 	("yesterday"   . "date:yesterday..yesterday")
;; ;;;; 	("last 7 days" . "date:7days..today")
;; ;;;; ;;	("bugs"      . "tag:bugs")
;; ;;;; ;;	("team"      . "tag:team")
;; ;;;; ;;	("reviews"   . "tag:reviews")
;; ;;;; ;;	("sanity"    . "tag:sanity")
;; ;;;; ;;	("week"      . "date:sun..today")
;; ;;;; ;;      ("month"     . "date:1st..today")
;; ;;;; ;;      ("notes"     . "tag:notes")
;; ;;;; ;;      ("status"    . "tag:status")
;; ;;;; 	("fltrmgrha" . "tag:fltrmgrha")
;; ;;;; 	("sent past week" . "from:chirag@versa-networks.com AND date:7days..now")
;; ;;;; ;;      ("all"       . "all")
;; ;;;; 	))
;;
;; ;; function to bounce the message
;; ;; (define-key notmuch-show-mode-map "b"
;; ;;   (lambda (&optional address)
;; ;;     "Bounce the current message."
;; ;;     (interactive "sBounce To: ")
;; ;;     (notmuch-show-view-raw-message)
;; ;;     (message-resend address)))
;;
;; ;; newmail?
;; (defvar notmuch-hello-refresh-count 0)
;; (defun notmuch-hello-refresh-status-message ()
;;   (unless no-display
;;     (let* ((new-count
;; 	    (string-to-number
;; 	     (car (process-lines notmuch-command "count"))))
;; 	   (diff-count (- new-count notmuch-hello-refresh-count)))
;;       (cond
;;        ((= notmuch-hello-refresh-count 0)
;; 	(message "You have %s messages."
;; 		 (notmuch-hello-nice-number new-count)))
;;        ((> diff-count 0)
;; 	(message "You have %s more messages since last refresh."
;; 		 (notmuch-hello-nice-number diff-count)))
;;        ((< diff-count 0)
;; 	(message "You have %s fewer messages since last refresh."
;; 		 (notmuch-hello-nice-number (- diff-count)))))
;;       (setq notmuch-hello-refresh-count new-count))))
;; (add-hook 'notmuch-hello-refresh-hook 'notmuch-hello-refresh-status-message)
;;

(provide 'notmuch-config)
