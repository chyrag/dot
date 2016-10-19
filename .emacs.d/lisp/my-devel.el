;; Development environment

(use-package xcscope
  :config
  (setq cscope-option-do-not-update-database t)
  (setq cscope-close-window-after-select t)
  (setq cscope-option-use-inverted-index t)
  :init
  (cscope-setup))

;; highlight uncommitted changes
(use-package diff-hl
  :ensure t
  :commands global-diff-hl-mode
  :init
  (setq diff-hl-draw-borders nil)
  :config
  ;; (diff-hl-margin-mode)
  (global-diff-hl-mode +1))

;; make the whitespace standout
(use-package whitespace
  :init
  (dolist (hook '(prog-mode-hook text-mode-hook
                                 conf-mode-hook))
    (add-hook hook #'whitespace-mode))
  :config
  (setq whitespace-line-column 80) ;; limit line length
  (setq whitespace-style '(face empty tabs lines-tail trailing))
  :diminish whitespace-mode)

;; make the whitespace cleanup as default
(use-package whitespace-cleanup-mode
  :config
  (global-whitespace-cleanup-mode)
  :diminish whitespace-cleanup-mode)

(use-package subword
  :diminish subword-mode
  :config
  (global-subword-mode +1))

;; highlight the changes to the buffer
(use-package volatile-highlights
  :diminish volatile-highlights-mode
  :config
  (volatile-highlights-mode t))

;; Draw a tail in the trail of typed characters
(use-package highlight-tail
  :disabled t
  :diminish highlight-tail-mode
  :init
  (setq highlight-tail-steps 14
	highlight-tail-timer 1
	highlight-colors '(("black" . 0 )
                           ("#bc2525" . 25)
                           ("black" . 66))
        highlight-tail-posterior-type 'const)
  :config
  (highlight-tail-mode))

(use-package undo-tree
  :bind
  ("C-x u" . undo-tree-visualize)
  :diminish undo-tree-mode
  :commands global-undo-tree-mode
  :config
  (global-undo-tree-mode))

(use-package visual-regexp
  :bind
  ("C-c r" . vr/replace)
  ("C-c q" . vr/query-replace))

(use-package highlight-symbol
  :diminish highlight-symbol-mode
  :commands
  (highlight-symbol-mode highlight-symbol-nav-mode)
  :bind
  ("C-<f3>" . highlight-symbol)
  :init
  (dolist (hook '(prog-mode-hook html-mode-hook css-mode-hook))
    (add-hook hook #'highlight-symbol-mode)
    (add-hook hook #'highlight-symbol-nav-mode)))

(use-package git-gutter
  :disabled t
  :init
  (global-git-gutter-mode t)
  (global-set-key (kbd "C-x C-g") 'git-gutter:toggle)
  (global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)
  (global-set-key (kbd "C-x v p") 'git-gutter:previous-hunk)
  (global-set-key (kbd "C-x v n") 'git-gutter:next-hunk)
  (global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)
  (global-set-key (kbd "C-x v SPC") 'git-gutter:mark-hunk)
  (global-set-key (kbd "C-x v s") 'git-gutter:stage-hunk))


(use-package rainbow-delimiters
  :diminish rainbow-delimiters-mode
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; syntax check
(use-package flycheck
  :diminish flycheck-mode
  :commands flycheck-mode
  :config
  (defalias 'flycheck-show-error-at-point-soon
    'flycheck-show-error-at-point))

;; function-args
(use-package function-args
  :diminish function-args-mode
  :bind
  ("C-c n" . fa-idx-cycle-down)
  :defer t)

(use-package mic-paren
  :commands paren-activate
  :config
  (paren-activate))

;; Projectile
(use-package projectile
  :init
  (setq projectile-completion-system 'ivy)
  (setq projectile-known-projects-file
        (expand-file-name "projectile-bookmarks.eld" my-tmp))
  :config
  (projectile-global-mode))

;;; git
(use-package git
  :defer t
  :bind
  ("<f9>"  . git-blame-mode))

;; magit
(use-package magit
  :defer t
  :bind
  ("C-x g" . magit-status))

;;; last change
(use-package goto-last-change
  :defer t
  :bind
  ("C-x ," . goto-last-change))

;; highlight symbol
(use-package highlight-symbol
  :init
  (setq highlight-symbol-on-navigation-p t)
  :config
  (global-set-key [(control f3)] 'highlight-symbol)
  (global-set-key [f3] 'highlight-symbol-next)
  (global-set-key [(shift f3)] 'highlight-symbol-prev)
  (global-set-key [(meta f3)] 'highlight-symbol-query-replace)
  :diminish highlight-symbol-mode "")

;; semantic
(use-package semantic
  :defer t
  :config
  ;; Increase the delay before activation
  (setq semantic-idle-scheduler-idle-time 30)
  ;; Don't reparse really big buffers.
  (setq semantic-idle-scheduler-max-buffer-size 100000)
  ;; Increase the delay before doing slow work
  (setq semantic-idle-scheduler-work-idle-time 30)
  :init
  (semantic-mode 1))

;; smart scan
(use-package smartscan
  :bind
  ("C-c n" . smartscan-symbol-go-forward)
  ("C-c p" . smartscan-symbol-go-backward)
  :init
  (global-smartscan-mode 1))

;;;
;;; Format code the Juniper way
;;;
;; (require 'cc-mode) ;; should not be required
(c-add-style "juniper"
             '(
               (c-basic-offset . 4)
               (c-comment-only-line-offset . 0)
               (c-offsets-alist
                . (
                   ;; first line of a new statement block
                   (statement-block-intro . +)

                   ;; First line of a K&R C argument declaration.
                   (knr-argdecl-intro . +)

                   ;; The brace that opens a substatement block.
                   (substatement-open . 0)

                   ;; Any non-special C label.
                   (label . 2)

                   ;; A `case' or `default' label.
                   (case-label . 0)

                   ;; The first line in a case block that starts with
                   ;; a brace.
                   (statement-case-open . +)

                   ;; A continuation of a statement.
                   (statement-cont . +)

                   ;; The first line after a conditional or loop
                   ;; construct.
                   (substatement . +)

                   ;; The first line in an argument list.
                   (arglist-intro . c-lineup-arglist-intro-after-paren)

                   ;; The solo close paren of an argument list.
                   (arglist-close . c-lineup-arglist)

                   ;; Brace that opens an in-class inline method.
                   (inline-open . 0)

                   ;; Open brace of an enum or static array list.
                   (brace-list-open . 0)))

               (c-special-indent-hook . c-gnu-impose-minimum)
               (c-block-comment-prefix . "")))

(defun juniper-c-default-style ()
  "Set the default c-style for Juniper."
  (interactive)
  (message "Loading default c-style for Juniper")
  ;; (define-key c-mode-map "\r" 'newline-and-indent)

  (c-set-style "juniper")
  (c-toggle-hungry-state t)
  (flycheck-mode)
  (flyspell-prog-mode)
  (fa-config-default)
  (highlight-symbol-mode)
  (function-args-mode)
  (rainbow-delimiters-mode +1)
  (diff-hl-mode)
  ;; (git-gutter-mode)
  (font-lock-add-keywords 'c-mode
			  '(("\\<\\(FIX\\|FIXME\\|TODO\\|BUG\\|HACK\\):" 1 font-lock-warning-face t)))

  (setq vc-svn-diff-switches '"-u")
  (define-key c-mode-map "\C-cd" 'vc-diff)

  (setq indent-tabs-mode nil)
  ;; (setq tab-always-indent 'complete)
  (electric-indent-mode t)
  ;; (add-hook 'before-save-hook 'delete-trailing-whitespace
  (whitespace-mode)
  (show-paren-mode t)
  (setq show-paren-style 'parenthesis)

  (defun toggle-tab-width ()
    "Toggle the value of tab-width between 4 and 8"
    (interactive)
    (if (= tab-width 8)
        (setq tab-width 4)
      ((insert )f (= tab-width 4)
       (setq tab-width 8)))
    (scroll-up 0))

  (defun toggle-c-offset ()
    "Toggle the value of c-basic-offset between 4 and 8"
    (interactive)
    (if (= c-basic-offset 8)
        (setq c-basic-offset 4)
      (if (= c-basic-offset 4)
          (setq c-basic-offset 8)))
    (scroll-up 0))

  ;; Complement to next-error
  (defun previous-error (n)
    "Visit previous compilation error message and corresponding source code."
    (interactive "p")
    (next-error (- n)))
  (abbrev-mode nil)

  (message "Loaded Juniper C default style"))

(add-hook 'c-mode-common-hook 'juniper-c-default-style)

;; (font-lock-add-keywords nil '(("\\<\\(FIX\\|FIXME\\|TODO\\|BUG\\|HACK\\):" 1 font-lock-warning-face t)))
;; (rainbow-delimiters-mode)
;; all the three below do not work :(
;; (diminish abbrev-mode "")
;; (diminish flyspell-mode "")
;; (diminish function-args-mode "")

;; python
(add-hook 'python-mode-hook '(lambda ()
                               (setq python-indent-offset 4)))
;; (add-hook 'projectile-mode-hook '(lambda () (diminish 'projectile-mode "P")))

;; Versa XML file settings
(setq nxml-child-indent 4
      nxml-attribute-indent 4
      nxml-slash-auto-complete-flag t)

;; waf
(setq auto-mode-alist (cons '("wscript" . python-mode) auto-mode-alist))

;; autoload gdb-script-mode while editing .gdb files
(add-to-list 'auto-mode-alist '("\\.gdb$" . gdb-script-mode))

(provide 'my-devel)
