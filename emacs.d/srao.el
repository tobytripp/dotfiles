(setenv "PATH" (concat "/usr/local/mongodb/bin" ":" "/usr/local/git/bin/" ":" (getenv "PATH")))

(add-to-list 'load-path (concat dotfiles-dir "/vendor"))
(progn (cd "~/.emacs.d/vendor")
       (normal-top-level-add-subdirs-to-load-path))

(require 'tobys-key-bindings)
(require 'tobys-ruby-hooks)

(setq mouse-wheel-scroll-amount '(1))
(setq mouse-wheel-progressive-speed nil)

(setq
  ns-command-modifier   'meta       ; Apple/Command key is Meta
  ns-alternate-modifier 'super      ; Option is the Mac Option key
  )

(load-file (concat dotfiles-dir "/tobys-colors.el"))
(my-color-theme)

(require 'column-marker)
(add-hook 'ruby-mode-hook (lambda () (interactive) (column-marker-1 80)))

(require 'yasnippet)
(setq yas/trigger-key (kbd "C-c y"))
(yas/initialize)
(yas/load-directory (concat dotfiles-dir "/vendor/yasnippet-0.6.1c/snippets"))

(require 'textmate)
(textmate-mode)

(defun maximize-frame ()
  (interactive)
  (set-frame-position (selected-frame) 0 0)
  (set-frame-size (selected-frame) 1000 1000))

(add-hook 'align-load-hook
          (lambda ()
            (add-to-list 'align-rules-list
                         '(text-column-whitespace
                           (regexp  . "\\(^\\|\\S-\\)\\([ \t]+\\)")
                           (group   . 2)
                           (modes   . align-text-modes)
                           (repeat  . t)))))

(require 'delim-kill)

(defun unicode-insert (char)
  "Read a unicode code point and insert said character.
    Input uses `read-quoted-char-radix'.  If you want to copy
    the values from the Unicode charts, you should set it to 16."
  (interactive (list (read-quoted-char "Char: ")))
  (ucs-insert char))

(require 'real-auto-save)
(add-hook 'text-mode-hook 'turn-on-real-auto-save)
(add-hook 'ruby-mode-hook 'turn-on-real-auto-save)

(setq real-auto-save-interval 5) ;; in seconds


