(add-hook 'ruby-mode-hook
          (lambda()
            (add-hook 'local-write-file-hooks
                      '(lambda()
                         (save-excursion
                           (untabify (point-min) (point-max))
                           (delete-trailing-whitespace)
                           )))
            (set (make-local-variable 'indent-tabs-mode) 'nil)
            (local-set-key (kbd "M-RET") 'textmate-next-line)
            (set (make-local-variable 'tab-width) 2)
;            (define-key ruby-mode-map "C-m" 'newline-and-indent)
            (require 'rsense)
            (require 'rspec-mode)
            (require 'rvm)
            (rvm-use-default)
            (require 'ruby-electric)
            (ruby-electric-mode t)
            ))

; Install mode-compile to give friendlier compiling support
(autoload 'mode-compile "mode-compile"
   "Command to compile current buffer file based on the major mode" t)
(global-set-key (kbd "C-c c") 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
 "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key (kbd "C-c k") 'mode-compile-kill)
(setq mode-compile-save-all-p t)

(provide 'tobys-ruby-hooks)

