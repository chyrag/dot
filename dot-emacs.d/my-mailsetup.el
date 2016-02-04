;;; -*-Emacs-Lisp-*-

;; self
(setq user-full-name "Chirag Kantharia"
      user-mail-address "chirag@versa-networks.com"
      organization "Versa Networks")

;; misc reading/composing settings
(setq  mm-text-html-renderer 'w3m    	;; use w3m to view html mail
       message-fill-column 72        	;; wrap text at column 72
       message-kill-buffer-on-exit t 	;; kill buffer after sending mails
       message-mode-hook (quote (flyspell-mode)) 	;; spell check
       message-citation-line-function 'message-insert-formatted-citation-line 	;; citation line
       message-citation-line-format "On %a, %b %d %Y at %r, %f wrote:"
       ;; message-send-mail-function 'smtpmail-send-it
       message-send-mail-function 'message-send-mail-with-sendmail
       message-auto-save-directory "~/.drafts"
       )

;; smtp mail settings (nullmailer)
;; (setq smtpmail-smtp-server "localhost"
;;      smtpmail-smtp-service 25)

;; offlineimap
(require 'offlineimap)
(offlineimap)

;; not much
(autoload 'notmuch "notmuch" "notmuch mail" t)
(setq notmuch-fcc-dirs nil	;; Gmail saves sent mails by itself
      notmuch-hello-logo nil    ;; no logo
      )
(setq notmuch-saved-searches
      '(
;; why the fuck doesn't this work?
;;	(:name "inbox" :query "tag:inbox OR tag:unread" :count-query "tag:unread")
;;	(:name "today" :query "date:today..now" :count-query "tag:unread")
;; the inbox tag is _all_ the incoming mail; we dont need it here
;; ("inbox"     . "tag:inbox")
	("to me"       .  "(to:chirag OR cc:chirag) AND tag:unread")
	(:name "new" :query "tag:unread" :count-query "tag:unread")
	("today"       . "date:today..today")
	("yesterday"   . "date:yesterday..yesterday")
	("last 7 days" . "date:7days..today")
;;	("bugs"      . "tag:bugs")
;;	("team"      . "tag:team")
;;	("reviews"   . "tag:reviews")
;;	("sanity"    . "tag:sanity")
;;	("week"      . "date:sun..today")
;; ("month"     . "date:1st..today")
        ("notes"     . "tag:notes")
	("sent"      . "from:chirag@versa-networks.com")
	("status"    . "tag:status")
	("fltrmgrha" . "tag:fltrmgrha")
	("all"       . "all")
	))

;; mu4e setup
(require 'mu4e)
(require 'mu4e-alert)
(setq mu4e-maildir (expand-file-name "~/Maildir")
      mu4e-sent-folder "/[Gmail].Sent Mail"
      mu4e-trash-folder "/[Gmail].Trash"
      mu4e-drafts-folder "/drafts"
      mu4e-headers-skip-duplicates t
      mu4e-view-show-addresses 't
      mu4e-view-show-images t
      mu4e-show-images t
      mu4e-view-image-max-width 800
      mu4e-sent-messages-behavior 'delete
      mu4e-headers-date-format "%Y-%m-%d %H:%M"
      mu4e-headers-fields
      '((:human-date     .  12)
	(:flags          .   6)
	(:from           .  30)
	(:subject        . nil)) ;; thread-subject does not work :(
      mu4e-maildir-shortcuts  '(("/INBOX"                . ?i)
				("/[Gmail].Sent Items"   . ?s)
				("/[Gmail].Trash"        . ?t)
				("/[Gmail].All Mail"     . ?a)))
(mu4e-alert-set-default-style 'notifications)
(add-hook 'after-init-hook #'mu4e-alert-enable-notifications)
(add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display)

;; bbdb
(setq bbdb-file "~/.emacs.d/bbdb")           ;; keep ~/ clean; set before loading
(require 'bbdb)
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
      '(( "From" . "no.?reply\\|DAEMON\\|daemon\\|facebookmail\\|twitter\\|bugzilla\\|jenkins")))
;; (define-key message-minibuffer-local-map [(tab)] 'bbdb-complete-name)

;; (set-face-background 'notmuch-message-summary-face "sea green")

(provide 'my-mailsetup)
