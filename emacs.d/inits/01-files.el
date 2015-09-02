(setq backup-inhibited t)

;; indent
(setq-default c-basic-offset 4)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq next-line-add-newlines nil)

;; whitespace
(require 'whitespace)
(setq whitespace-space 'underline)
(set-default 'whitespace-auto-cleanup t)
(set-default 'whitespace-check-buffer-leading nil)
(set-default 'whitespace-check-buffer-trailing t)
(set-default 'whitespace-check-buffer-indent nil)
(set-default 'whitespace-check-buffer-spacetab t)
(set-default 'whitespace-check-buffer-ateol t)

(global-whitespace-mode 1)
(add-hook 'after-change-major-mode-hook 'whitespace-mode)

;; display only tails of lines longer than 80 columns, tabs and
;; trailing whitespaces
(setq whitespace-line-column 80
      whitespace-style '(tabs trailing lines-tail))
;; face for long lines' tails
(set-face-attribute 'whitespace-line nil
                    :background "gray20"
                    :foreground "DarkSlateGray4"
                    ;; :weight 'bold
                    )
;; face for Tabs
(set-face-attribute 'whitespace-tab nil
                    :background "gray20"
                    :foreground "DarkSlateGray4"
                    ;; :weight 'bold
                    )

;; before-save-hook
(defun unix-newline () (set-buffer-file-coding-system 'undecided-unix))
(add-hook 'before-save-hook 'unix-newline)
(add-hook 'before-save-hook 'whitespace-cleanup)
