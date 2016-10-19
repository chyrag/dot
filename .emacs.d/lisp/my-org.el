;; Org setup

(defvar my-status-dir (expand-file-name "~/documents/status/")
    "Directory where I store my status reports")

(global-set-key (kbd "C-c o") (lambda() (interactive)(find-file (expand-file-name "status.org" my-status-dir))))
(global-set-key (kbd "C-c t") (lambda() (interactive)(find-file (expand-file-name "todo.org" my-status-dir))))
(global-set-key (kbd "C-c c") 'org-capture)

;; Org
(use-package org
  :ensure t
  :bind
  (("C-c a" . org-agenda))
  :defer t

  :config
  (defun jump-to-org-agenda ()
    (interactive)
    (let ((buf (get-buffer "*Org Agenda*"))
          wind)
      (if buf
          (if (setq wind (get-buffer-window buf))
              (select-window wind)
            (if (called-interactively-p)
                (progn
                  (select-window (display-buffer buf t t))
                  (org-fit-window-to-buffer)
                  ;; (org-agenda-redo)
                  )
              (with-selected-window (display-buffer buf)
                (org-fit-window-to-buffer)
                ;; (org-agenda-redo)
                )))
        (call-interactively 'org-agenda-list)))
    ;;(let ((buf (get-buffer "*Calendar*")))
    ;;  (unless (get-buffer-window buf)
    ;;    (org-agenda-goto-calendar)))
    )
  (run-with-idle-timer 300 t 'jump-to-org-agenda)
  (defadvice org-agenda (around org-agenda-fullscreen activate)
    (window-configuration-to-register :org-agenda-fullscreen)
    ad-do-it
    (delete-other-windows))
  (defadvice org-agenda-quit (around org-agenda-quit-fullscreen activate)
    ad-do-it
    (jump-to-register :org-agenda-fullscreen))
  (unless (boundp 'org-export-latex-classes)
    (setq org-export-latex-classes nil))
  (add-to-list 'org-export-latex-classes
               '("article"
                 "\\documentclass{article}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
;;   (add-to-list 'org-export-latex-classes
;;               '("moderncv"
;;                 "\\documentclass{moderncv}"
;;                 ("\\

  (require 'india-holidays-2016)

  (defun my-org-insert-week-template ()
    "Insert org headline template for the week.

Example:

** 2016-07-04 (week 27)
*** <2016-07-04 Mon - day 186>
*** <2016-07-05 Tue - day 187>
*** <2016-07-06 Wed - day 188>
*** <2016-07-07 Thu - day 189>
*** <2016-07-08 Fri - day 190>
*** <2016-07-09 Sat - day 191>
*** <2016-07-10 Sun - day 192>"

    (interactive)
    (let ((week-start (current-time))
          (oneday (seconds-to-time 86400)))
      (loop
       (if (string= (format-time-string "%w" week-start) "1")
           (return)
         (setq week-start (time-subtract week-start oneday))))
      (let ((week-hdr "%Y-%m-%d (week %U)")
            (day-hdr "<%Y-%m-%d %a - day %j>"))
        (save-excursion
          (insert "** " (format-time-string week-hdr week-start) "\n")
          (dotimes (i 7)
            (insert "*** " (format-time-string day-hdr week-start) "\n")
            (setq week-start (time-add week-start oneday)))))))

  ;; Set up paths.
  (setq org-agenda-files (list (expand-file-name "work.org" org-directory)
                               (expand-file-name "birthdays.org" org-directory)
                               (expand-file-name "anniversaries.org" org-directory)
                               (expand-file-name "holidays.org" org-directory)
                               (expand-file-name "personal.org" org-directory)
                               (expand-file-name "todo.org" org-directory))
        org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
          (sequence "WAITING(w@)" "HOLD(h@)" "|" "CANCELLED(c)"))
        org-agenda-include-diary nil ;; for time being
        org-agenda-start-on-weekday nil
        org-todo-keyword-faces
        '(("NEXT" :foreground "blue" :weight bold)
          ("WAITING" :foreground "orange" :weight bold)
          ("HOLD" :foreground "magenta" :weight bold)
          ("CANCELLED" :foreground "forest green" :weight bold))

        ;; Add a timestamp when a certain TODO item was finished.
        org-log-done 'time

	;; customize log
	org-agenda-show-log t
	org-agenda-todo-ignore-scheduled t
	org-agenda-todo-ignore-deadlines t

        ;; Custom timestamp formats.
        org-display-custom-times t
        org-time-stamp-custom-formats
        '("<%d-%m-%Y %a>" . "<%d-%m-%Y %a %H:%M>")
        org-ellipsis "⤵"
        org-M-RET-my-split-line nil)

  ;; templates
  (setq org-capture-templates
        '(("i" "Ideas" entry (file+datetree "~/Dropbox/Org/ideas.org" "Ideas")
           "* %?\nHad this idea on %U\n  %i\n %a")
          ("j" "Journal" entry (file+datetree "~/Dropbox/Org/journal.org")
           "* %?\nEntered on %U\n  %i\n  %a")
          ("l" "Lyric" entry (file+headline "~/Dropbox/Org/lyrics.org"
                                            "Lyrical Ideas"))
          ("t" "Todo" entry (file+headline "~/Dropbox/Org/gtd.org" "Tasks")
           "* TODO %?\n  %i\n  %a")
          ("J" "Joke" entry (file+headline "~/Dropbox/Org/jokes.org" "Jokes"))
          ("Q" "Quote" entry (file+headline "~/Dropbox/Org/quotes.org" "Quotes"))
          ("R" "Recipe" entry (file+headline "~/Dropbox/Org/recipes.org" "Recipes"))))

  (add-hook 'org-mode-hook
            (lambda ()
	      (flyspell-mode)
	      (writegood-mode)
              (add-hook 'before-save-hook 'org-align-all-tags nil t))))

;; org-bullets
(use-package org-bullets
  :defer t
  :commands org-bullets-mode
  :preface
  (defun org-bullets-mode-hook ()
    (setq org-bullets-bullet-list '("◉" "◎" "⚫" "○" "►" "◇"))
    (org-bullets-mode +1))
  :init
  (add-hook 'org-mode-hook #'org-bullets-mode-hook))

(provide 'my-org)
