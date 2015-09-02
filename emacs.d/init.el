(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")
