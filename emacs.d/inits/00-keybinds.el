(define-key global-map (kbd "C-h") 'delete-backward-char)
(define-key global-map (kbd "C-t") 'other-window)
(define-key global-map (kbd "M-g") 'goto-line)
(define-key global-map (kbd "M-?") 'help-for-help)

;; Enable cua-mode for rectangular edit (but disable other features
;; from the mode). C-ENTER to enable the rectangular region.
(cua-mode t)
(setq cua-enable-cua-keys nil)
