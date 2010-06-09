(setq rsense-home (concat dotfiles-dir "/vendor/rsense"))
(add-to-list 'load-path (concat rsense-home "/etc"))
(require 'rsense)

(add-to-list 'load-path (concat dotfiles-dir "/vendor/auto-complete-1.2"))
(require 'auto-complete-config)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(add-hook 'ruby-mode-hook
          (lambda ()
;            (local-set-key (kbd "C-c .") 'rsense-complete)
            (local-set-key (kbd "C-c .") 'ac-complete-rsense)
            (add-to-list 'ac-sources 'ac-source-rsense-method)
            (add-to-list 'ac-sources 'ac-source-rsense-constant)
            (add-to-list 'ac-sources 'ac-source-yasnippet)
            )
          )
