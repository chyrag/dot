;; self details
;; (setq user-full-name "Chirag Kantharia" user-mail-address "chirag@versa-networks.com"  organization "Versa Networks")

;; setup versa mail (gmail)
(setq gnus-select-method
      '(nnimap "versa networks"
	       (nnimap-address "imap.gmail.com")
	       (nnimap-server-port 993)
	       (nnimap-inbox "Inbox")
	       (nnimap-stream ssl)))

;; misc reading/composing settings
(setq 
 mm-text-html-renderer 'w3m    ;; use w3m to view html mail
 message-fill-column 72        ;; wrap text at column 72
 message-kill-buffer-on-exit t ;; kill buffer after sending mails
)

;; headers/labels
(defun rs-gnus-get-label (header)
  "Returns label from X-Label header"
  (let
      ((lbl (or (cdr (assq 'X-Label (mail-header-extra header))) "")))
    lbl))
(defalias 'gnus-user-format-function-r 'rs-gnus-get-label)

;; gnus variables
(setq gnus-permanently-visible-groups "^INBOX\\|^\\[Gmail\\]\\/Drafts\\|^\\[Gmail\\]\\/Sent\\ Mail\\|^attic\\|^build\\|^bugs\\|^versa-sw-blr\\|^versa-blr\\|^git-admin" ;; select groups that we want to see all the time
      gnus-visible-headers
      '("From:" "^Newsgroups:" "^Subject:" "^Date:" "^Followup-To:" "^Reply-To:"
	"^Organization:" "^Summary:" "^Keywords:" "^To:" "^Cc:" "^Posted-To:"
	"^Mail-Copies-To:" "^Apparently-To:" "^Gnus-Warning:" "^Resent-From:"
	"X-Sent:" "^User-Agent:" "^X-Mailer:" "^Newsreader:" "^X-Newsreader:" 
        "^X-Accept-Language" "^Message-Id:" "^X-Bugzilla-Who")

      gnus-posting-styles '((".*"
			     (name user-full-name)
			     (address "chirag@versa-networks.com")
			     (organization "Versa Networks")
			     (signature-file "~/.signature")))
      gnus-summary-line-format "%1{%U%R%z: %}%2{%d%}%5{ %[%4i%] %}%4{%-24,24n%}%6{%-4,4ur%}%5{| %}%(%1{%B%}%s%)\n"
      gnus-group-mode-line-format "Gnus: %b %d %y [%A] %Z"
      gnus-group-line-format "%M%S%p%P%5y:%B%(%g%)%O\n"

      gnus-topic-line-format "%i[ %{%(%n%)%} (%g/%A) ]%v\n"
      gnus-topic-indent-level 4

      gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
      gnus-thread-sort-functions '(lambda (t1 t2) (not (gnus-thread-sort-by-date t1 t2)))
      gnus-use-cache t
      gnus-use-full-window nil)

;; (add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

;; send mail settings			     
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-smtp-server "localhost"
      smtpmail-smtp-service 10025)

;; fontify
(set-face-foreground 'gnus-group-mail-1-empty "blue")
(set-face-foreground 'gnus-group-mail-2-empty "yellow")
(set-face-foreground 'gnus-group-mail-3-empty "grey")

(copy-face 'default 'face-label)

(set-face-foreground 'face-label "grey")
(setq gnus-face-1 'face-label)

(set-face-foreground 'face-label "yellow")
(setq gnus-face-2 'face-label)

(set-face-foreground 'face-label "orange")
(setq gnus-face-3 'face-label)

(set-face-foreground 'face-label "magenta")
(setq gnus-face-4 'face-label)

(set-face-foreground 'face-label "red")
(setq gnus-face-5 'face-label)

(set-face-foreground 'face-label "olive drab")
(setq gnus-face-6 'face-label)

(set-face-foreground 'gnus-summary-high-unread-face "dark red")
(set-face-foreground 'gnus-summary-normal-unread-face "orange")
(set-face-foreground 'gnus-summary-normal-read-face "grey")

;; gnu tree
(when window-system
  (setq
   gnus-sum-thread-tree-root "\u25cf "
   gnus-sum-thread-tree-false-root "\u25b7 "
   gnus-sum-thread-tree-single-indent ""
   gnus-sum-thread-tree-leaf-with-other "\u251c\u2500\u25ba"
   gnus-sum-thread-tree-vertical "\u2502 "
   gnus-sum-thread-tree-single-leaf "\u2514\u2500\u25ba"))

;; bbdb
(setq bbdb-file "~/.emacs.d/bbdb")           ;; keep ~/ clean; set before loading
(require 'bbdb) 
(bbdb-initialize)
(setq 
    bbdb-offer-save 1                        ;; 1 means save-without-asking
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
(define-key message-minibuffer-local-map [(tab)] 'bbdb-complete-name)

;; mairix
(require 'mairix)
;; tbd

;; eof
