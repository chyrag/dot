;;; -*-Emacs-Lisp-*-

(require 'smart-mode-line)
(sml/setup)
(sml/apply-theme 'dark)

;; Examples
;; (add-to-list 'sml/replacer-regexp-list '("^~/Dropbox/Projects/In-Development/" ":ProjDev:") t)
;; (add-to-list 'sml/replacer-regexp-list '("^~/Documents/Work/" ":Work:") t)
;;
;; ;; Added in the right order, they even work sequentially:
;; (add-to-list 'sml/replacer-regexp-list '("^~/Dropbox/" ":DB:") t)
;; (add-to-list 'sml/replacer-regexp-list '("^:DB:Documents" ":DDocs:") t)
;; (add-to-list 'sml/replacer-regexp-list '("^~/Git-Projects/" ":Git:") t)
;; (add-to-list 'sml/replacer-regexp-list '("^:Git:\\(.*\\)/src/main/java/" ":G/\\1/SMJ:") t)

;; my sandboxes
(add-to-list 'sml/replacer-regexp-list '("^~/Work/prototype" ":PROTO") t)
(add-to-list 'sml/replacer-regexp-list '("^~/Work/shamrock" ":SHAM:") t)
(add-to-list 'sml/replacer-regexp-list '("^~/Work/ha" ":HA:") t)
(add-to-list 'sml/replacer-regexp-list '("^~/Work/ipc" ":IPC:") t)
(add-to-list 'sml/replacer-regexp-list '("^~/Work/listen2" ":LSTN2:") t)
(add-to-list 'sml/replacer-regexp-list '("^~/Work/vobj" ":VOBJ:") t)
(add-to-list 'sml/replacer-regexp-list '("^~/Work/vipc" ":VIPC:") t)
(add-to-list 'sml/replacer-regexp-list '("^~/Work/vstated" ":VSTATE:") t)
(add-to-list 'sml/replacer-regexp-list '("^~/Work/eos" ":EOS") t)

(provide 'my-sandboxes)


