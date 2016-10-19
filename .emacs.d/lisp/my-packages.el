;; Packages

(require 'cl)

;; (use-package auto-package-update)

;; install missing packages
(defvar ck/my-packages
  '(
    auto-compile
    avy
    beacon
    bind-key
    company
    counsel
    dabbrev
    deft
    diff-hl
    diminish
    escreen
    expand-region
    flycheck
    flyspell
    flyspell-correct-ivy
    function-args
    git-gutter
    goto-last-change
    highlight-symbol
    highlight-tail
    ibuffer
    ivy
    keyfreq
    message-templ
    mic-paren
    notmuch
    offlineimap
    org
    org-bullets
    projectile
    rainbow-mode
    rainbow-delimiters
    recentf
    savehist
    semantic
    session
    smart-mode-line
    smartscan
    smex
    subword
    swiper
    symon
    type-break
    volatile-highlights
    which-key
    whitespace
    whitespace-cleanup-mode
    win-switch
    writegood-mode
    xcscope
    xkcd
    yahoo-weather))

(defun ck/packages-installed-p ()
  (loop for pkg in ck/my-packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

(unless (ck/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg ck/my-packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;; (let ((missing (remove-if 'package-installed-p ck/my-packages)))
;;  (when missing
;;    (package-refresh-contents)
;;    (mapc 'package-install missing)))

(provide 'my-packages)
