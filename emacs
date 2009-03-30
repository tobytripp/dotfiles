(global-font-lock-mode 1)
(tool-bar-mode -1)
(setq transient-mark-mode t)

(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq require-final-newline t)
(setq next-line-add-newlines nil) ; don't add new lines if scrolling down at bottom
(setq-default indent-tabs-mode nil)

;; Software that beeps is stupid
(setq visible-bell t)

(global-set-key "\C-m" 'newline-and-indent)

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/mmm-mode-0.4.8")
(add-to-list 'load-path "~/.emacs.d/eieio-0.17")
(add-to-list 'load-path "~/.emacs.d/speedbar-0.14beta4")
(add-to-list 'load-path "~/.emacs.d/semantic-1.4.4")
(add-to-list 'load-path "~/.emacs.d/emacs-rails")
(add-to-list 'load-path "~/.emacs.d/ecb-2.32")
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(add-to-list 'load-path "~/.emacs.d/color-theme")

;(require 'color-theme)
;(load-file "~/.emacs.d/color-theme/themes/pastels-on-dark-theme.el")
;(color-theme-pastels-on-dark)
(load-file "~/.emacs.d/.emacs-color-theme")
(my-color-theme)

(global-hl-line-mode 1)

(require 'git)

(require 'filecache)
(defun rails-add-proj-to-file-cache (dir)
  "Adds all the ruby and html file recursively in cwd to file cache"
  (interactive "DAdd directory: ")
    (file-cache-clear-cache)
    (file-cache-add-directory-recursively dir
       (regexp-opt (list ".rb" ".rhtml" ".xml" ".js" ".yml" ".html.erb")))
    (file-cache-delete-file-regexp "\\.svn"))

(iswitchb-mode 1)
(require 'iswitchb-fc)
(defun iswitchb-local-keys ()
      (mapc (lambda (K) 
	      (let* ((key (car K)) (fun (cdr K)))
    	        (define-key iswitchb-mode-map (edmacro-parse-keys key) fun)))
	    '(("<right>" . iswitchb-next-match)
	      ("<left>"  . iswitchb-prev-match)
	      ("<up>"    . ignore             )
	      ("<down>"  . ignore             ))))
    (add-hook 'iswitchb-define-mode-map-hook 'iswitchb-local-keys)

(require 'anything-config)
(global-set-key (kbd "C-c SPC") 'anything)

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
            (require 'ruby-electric)
            (ruby-electric-mode t)
            ))


; Install mode-compile to give friendlier compiling support
(autoload 'mode-compile "mode-compile"
   "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
 "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)
;; (setq ruby-command "jruby")

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
    )
)

; Javascript mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
 
(setq js2-basic-offset 2)
(setq js2-use-font-lock-faces t)


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

(global-set-key [(meta /)] 
                (make-hippie-expand-function
                 '(try-expand-dabbrev-visible
                   try-expand-dabbrev
                   try-expand-dabbrev-from-kill
                   try-expand-dabbrev-all-buffers) t)
                )

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-layout-window-sizes (quote (("left-analyse" (0.32592592592592595 . 0.39622641509433965) (0.32592592592592595 . 0.1509433962264151) (0.32592592592592595 . 0.2830188679245283) (0.32592592592592595 . 0.1509433962264151)) ("left3" (0.32592592592592595 . 0.39622641509433965) (0.32592592592592595 . 0.24528301886792453) (0.32592592592592595 . 0.33962264150943394)) ("left14" (0.2564102564102564 . 0.6949152542372882) (0.2564102564102564 . 0.23728813559322035)))))
 '(ecb-source-path (quote (("/" "/") (#("/Users/toby/Code/Ruby/community.branch.svn" 0 42 (help-echo "Mouse-2 toggles maximizing, mouse-3 displays a popup-menu")) "community") ("/Users/toby/Code/System" "system") ("/Users/toby/Code/Jahva/mmh/mmh-web-mvn/src/main/webapp" "mmh-rails"))))
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount (quote (1 ((shift) . 1) ((control))))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(mmm-code-submode-face ((t (:background "Grey15"))))
 '(mmm-comment-submode-face ((t (:background "#212F2F"))))
 '(mmm-default-submode-face ((t (:background "Grey15"))))
 '(mmm-output-submode-face ((t (:background "Grey15")))))


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))
