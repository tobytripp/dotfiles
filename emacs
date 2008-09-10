
(global-font-lock-mode 1)
(tool-bar-mode -1)
(setq transient-mark-mode t)

(fset 'yes-or-no-p 'y-or-n-p)

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/mmm-mode-0.4.8")
(add-to-list 'load-path "~/.emacs.d/eieio-0.17")
(add-to-list 'load-path "~/.emacs.d/speedbar-0.14beta4")
(add-to-list 'load-path "~/.emacs.d/semantic-1.4.4")
(add-to-list 'load-path "~/.emacs.d/emacs-rails")
(add-to-list 'load-path "~/.emacs.d/ecb-2.32")

(autoload 'ruby-mode "ruby-mode" "Major mode for Ruby" t)
(setq auto-mode-alist (cons '("\\.rb$" . ruby-mode) auto-mode-alist))

(add-hook 'ruby-mode-hook
          (lambda()
            (add-hook 'local-write-file-hooks
                      '(lambda()
                         (save-excursion
                           (untabify (point-min) (point-max))
                           (delete-trailing-whitespace)
                           )))
            (set (make-local-variable 'indent-tabs-mode) 'nil)
            (set (make-local-variable 'tab-width) 2)
            (imenu-add-to-menubar "IMENU")
            ;Not sure if this line is 100% right but it works!
            (define-key ruby-mode-map "C-m" 'newline-and-indent)
            (require 'ruby-electric)
            (ruby-electric-mode t)
            ))

; Install mode-compile to give friendlier compiling support!
(autoload 'mode-compile "mode-compile"
   "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
 "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)


;These lines are required for ECB
(setq semantic-load-turn-everything-on t)
(require 'semantic-load)

; This installs ecb - it is activated with M-x ecb-activate
(require 'ecb-autoloads)

(setq ecb-layout-name "left14")
(setq ecb-layout-window-sizes
      (quote
       (("left14"
         (0.2564102564102564 . 0.6949152542372882)
         (0.2564102564102564 . 0.23728813559322035)))))

(setq ecb-source-path
      (quote
       ("~/Code/ThoughtWorks")
       ("~/Code/Ruby")
))



; needed for rails mode
(require 'snippet)
(require 'find-recursive)
; The rails require needs to go after ECB
; otherwise it loads a new incompatible speedbar
(require 'rails)

(require 'mmm-mode)
(require 'mmm-auto)
(setq mmm-global-mode 'maybe)
(setq mmm-submode-decoration-level 2)
(set-face-background 'mmm-output-submode-face  "LightGrey")
(set-face-background 'mmm-code-submode-face    "white")
(set-face-background 'mmm-comment-submode-face "lightgrey")

(mmm-add-classes
 '((erb-code
    :submode ruby-mode
    :match-face (("<%#" . mmm-comment-submode-face)
                 ("<%=" . mmm-output-submode-face)
                 ("<%"  . mmm-code-submode-face))
    :front "<%[#=-]?"
    :back "-?%>"
    :insert ((?% erb-code       nil @ "<%"  @ " " _ " " @ "%>" @)
             (?# erb-comment    nil @ "<%#" @ " " _ " " @ "%>" @)
             (?= erb-expression nil @ "<%=" @ " " _ " " @ "%>" @))
    )))
(add-hook 'html-mode-hook
          (lambda ()
            (setq mmm-classes '(erb-code))
            (mmm-mode-on)))
(add-to-list 'auto-mode-alist '("\.rhtml$" . html-mode))
(add-to-list 'auto-mode-alist '("\.html.erb$" . html-mode))


