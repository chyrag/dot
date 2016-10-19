;; Load default settings that I would like to work with

;; Remove those GUI elements
(tooltip-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
;;  (set-default-font "Inconsolata:style=bold:size=20")
;;  (set-default-font "Hack:style=bold:size=18")
;;  (set-default-font "10x20")
;;  (set-default-font "Source Code Pro-16")
(setq frame-title-format '(buffer-file-name "%f" ("%b")))
(set-frame-parameter nil 'fullscreen 'fullboth)
(setq-default frame-background-mode 'dark)

;; Sane defaults
(setq-default
 auto-revert-verbose nil
 auto-save-interval 0
 auto-save-timeout 600
 blink-matching-paren nil
 column-number-mode t
 confirm-kill-emacs 'y-or-n-p
 confirm-nonexistent-file-or-buffer nil
 delete-by-moving-to-trash nil
 delete-selection-mode t
 diary-file "~/.diary"
 dired-dwim-target t
 display-time-load-average-threshold 100
 display-time-format "%a %m/%d %H:%M "
 echo-keystrokes 0.02
 ediff-split-window-function 'split-window-horizontally
 ediff-window-setup-function 'ediff-setup-windows-plain
 electric-indent-mode nil
 fill-column 80
 font-lock-maximum-decoration t
 gc-cons-threshold 50000000
 global-auto-revert-non-file-buffers t
 history-length 1000
 indent-tabs-mode nil
 inhibit-startup-message t
 initial-major-mode 'text-mode
 initial-scratch-message ""
 large-file-warning-threshold 100000000
 line-number-mode t
 make-backup-files nil
 next-error-highlight t
 next-error-highlight-no-select t
 next-line-add-newlines nil
 org-directory "~/.emacs.d/org/"
 query-replace-highlight t
 recentf-max-saved-items 100
 require-final-newline t
 ring-bell-function #'ignore

 scroll-conservatively 100000
 scroll-margin 3
 scroll-preserve-screen-position 1
 sentence-end-double-space nil
 shift-select-mode nil
 use-package-verbose t
 use-dialog-box nil
 tab-always-indent 'complete
 tramp-persistency-file-name (expand-file-name "tramp" my-tmp)
 transient-mark-mode t
 truncate-lines t
 truncate-partial-width-windows nil
 visible-bell t
 x-select-enable-clipboard t)

(auto-compression-mode +1)
(blink-cursor-mode -1)
(global-font-lock-mode +1)
;; (global-hl-line-mode +1)
(show-paren-mode +1)
(winner-mode +1)
(display-time)
(flyspell-mode)
(set-language-environment "ASCII")

(provide 'sensible-defaults)
