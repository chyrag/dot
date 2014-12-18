; ~/.vm-init

;; vm-color
(require 'u-vm-color)
(add-hook 'vm-summary-mode-hook 'u-vm-color-summary-mode)
(add-hook 'vm-select-message-hook 'u-vm-color-fontify-buffer)
(defadvice vm-decode-mime-message (after u-vm-color activate)
   (u-vm-color-fontify-buffer-even-more))

(setq 
;; spools
    vm-primary-inbox "/var/mail/chirag"
    vm-crash-box "~/.vm.crash.mbox"
)
