(setq user-full-name "Chirag Kantharia"
      user-mail-address "chirag@juniper.net"
      mail-self-blind t
      indent-prefix "| "
      mail-yank-prefix "| ")

;;(setq gnus-select-method '(nntp "news.juniper.net"))
;;(setq gnus-secondary-select-methods '((nnmbox "private")))

(setq gnus-select-method '(nnfolder ""))

;;(setq nnmail-spool-file '(  
;;  (file :path "/var/mail/chirag")))

(setq mail-sources
            '((file :path "/var/mail/chirag")))

(setq gnus-posting-styles
      '((".*"
         (signature-file "~/.signature"))))

(setq gnus-message-archive-group "sent")
(setq gnus-message-archive-group  
   '((concat "sent-" (format-time-string "%Y-%B" (current-time)))))  
