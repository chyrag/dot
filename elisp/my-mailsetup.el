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
       message-send-mail-function 'smtpmail-send-it)

;; smtp mail settings (nullmailer)
(setq smtpmail-smtp-server "localhost"
      smtpmail-smtp-service 25)

;; offlineimap
(require 'offlineimap)

;; not much
(autoload 'notmuch "notmuch" "notmuch mail" t)
(setq notmuch-fcc-dirs nil)	;; Gmail saves sent mails by itself
(setq notmuch-saved-searches
      '(
        ("today" .	"date:today..now")
        ("yesterday" .  "date:yesterday..now")
        ("week" .	"date:1week..now")
        ("month" .	"date:1month..now")
	("inbox" .	"tag:inbox")
	))

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

(provide 'my-mailsetup)
