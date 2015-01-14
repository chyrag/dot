;; setup versa mail (gmail)
(setq gnus-select-method
      '(nnimap "versa networks"
	       (nnimap-address "imap.gmail.com")
	       (nnimap-server-port 993)
	       (nnimap-inbox "Inbox")
	       (nnimap-stream ssl)))

;; we want to see all the groups
(setq gnus-permanently-visible-groups ".*")

;; use w3m to view html mail
(setq mm-text-html-renderer 'w3m)

;; wrap text at column 72
(defun my-message-mode-setup()
  (setq fill-column 72)
  (turn-on-auto-fill))
(add-hook 'message-mode-hook 'my-message-mode-setup)

;; headers/labels
(defun rs-gnus-get-label (header)
  "Returns label from X-Label header"
  (let
      ((lbl (or (cdr (assq 'X-Label (mail-header-extra header))) "")))
    lbl))

(defalias 'gnus-user-format-function-r 'rs-gnus-get-label)

;; gnus variables
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-smtp-server "localhost"
      smtpmail-smtp-service 10025
      gnus-visible-headers
      '("From:" "^Newsgroups:" "^Subject:" "^Date:" "^Followup-To:" "^Reply-To:"
	"^Organization:" "^Summary:" "^Keywords:" "^To:" "^Cc:" "^Posted-To:"
	"^Mail-Copies-To:" "^Apparently-To:" "^Gnus-Warning:" "^Resent-From:"
	"X-Sent:" "^User-Agent:" "^X-Mailer:" "^Newsreader:" "^X-Newsreader:" 
        "^X-Accept-Language" "^Message-Id:")
      gnus-posting-styles '((".*"
			     (name user-full-name)
			     (address "chirag@versa-networks.com")
			     (organization "Versa Networks")
			     (signature-file "~/.signature")))
      gnus-summary-line-format "%1{%U%R%z: %}%2{%d%}%5{ %[%4i%] %}%4{%-24,24n%}%6{%-4,4ur%}%5{| %}%(%1{%B%}%s%)\n"
      gnus-group-mode-line-format "Gnus: %%b"
      gnus-group-line-format "%M%S%p%P%5y:%B%(%g%)%O\n"

      gnus-topic-line-format "%i[ %{%(%n%)%} (%g/%A) ]%v\n"
      gnus-topic-indent-level 4

      gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
      gnus-thread-sort-functions '(lambda (t1 t2) (not (gnus-thread-sort-by-date t1 t2)))
      gnus-use-cache t)
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)



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
(set-face-foreground 'gnus-summary-normal-unread-face "blue")

;; gnu tree
(when window-system
  (setq
   gnus-sum-thread-tree-root "\u25cf "
   gnus-sum-thread-tree-false-root "\u25b7 "
   gnus-sum-thread-tree-single-indent ""
   gnus-sum-thread-tree-leaf-with-other "\u251c\u2500\u25ba"
   gnus-sum-thread-tree-vertical "\u2502 "
   gnus-sum-thread-tree-single-leaf "\u2514\u2500\u25ba"))
