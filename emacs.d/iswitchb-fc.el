;;; iswitchb-fc.el --- switch to buffers or file-cache entries with 1 command

;; Copyright (C) 2004  Free Software Foundation, Inc.

;; Author: Benjamin Rutt <brutt@bloomington.in.us>

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; This package allows you to use iswitchb-like functionality to
;; switch to not only your current buffers, but also any files in your
;; previously built filecache (see filecache.el).  This experience is
;; liberating; you no longer need to worry whether the file you want
;; to go to is open in emacs or not, you just have a single command
;; (C-x b) to go to a buffer containing that file.  You don't have to
;; worry whether to press C-x b to switch to a buffer or to use C-x
;; C-f basename C-TAB to open a file using filecache.

;; This package is smart enough to uniquify name clashes between
;; multiple files with the same basename.  All buffers are at the
;; beginning of the input list presented by iswitchb, and all
;; filecache entries are at the end.

;; To use, place the file in your load-path and add

;; (require 'iswitchb-fc)

;; to your ~/.emacs, which causes the function iswitchb to refer to
;; the new function iswitchb-fc.  Presumably you'd add the above line
;; only if you have (iswitchb-mode 1) in your ~/.emacs already,
;; otherwise you probably wouldn't care about this package.  To undo
;; the effect of loading this package, you would need to do M-x
;; load-library iswitchb RET.

;; This package may only work on GNU Emacs.  Untested on XEmacs,
;; but patches will be accepted.

;; Thanks to Kin Cho (kin@neoscale.com) for the idea and for pointing
;; me in the right direction.

;;; Code:

(require 'iswitchb)
(eval-when-compile (require 'cl))

(defun iswitchb-fc-get-fc-triplets ()
  (let ((dest nil)
	(cr nil)
	(tmpls (copy-sequence file-cache-alist)))
    (while tmpls
      (setq fca-item (car tmpls))
      (while (>= (length fca-item) 2)
	(setq dest (cons (list 'fc (car fca-item) (cadr fca-item)) dest))
	(setq fca-item (cons (car fca-item) (cddr fca-item))))
      (setq tmpls (cdr tmpls)))
    dest))

(defun iswitchb-fc-icompleting-read (prompt choices)
  "Use iswitch as a completing-read replacement to choose from
choices.  PROMPT is a string to prompt with.  CHOICES is a list
of strings to choose from."
  (let ((iswitchb-make-buflist-hook
         (lambda () (setq iswitchb-temp-buflist choices))))
    (iswitchb-read-buffer prompt)))

(defun iswitchb-fc ()
  (interactive)
  (require 'filecache)
  (let* ((canonical-fn-hash (make-hash-table :test 'equal))
	 ;; representing what the user sees
	 (choosename-hash (make-hash-table :test 'equal))
	 (fc-basenames-hash (make-hash-table :test 'equal))
	 ;; all buffer triplets
	 (buf-triplets
	  (mapcar
	   (lambda (b)
	     (let* ((bfn (buffer-file-name b))
		    (triplet (list 'buf (buffer-name b) bfn)))
	     (when bfn
	       (puthash bfn triplet canonical-fn-hash))
	     triplet))
	   (buffer-list)))
	 ;; any filecache triplets that aren't covered by a buffer already
	 (fc-triplets
	  (delq nil
		(let ((fc-triplets (iswitchb-fc-get-fc-triplets)))
		  (mapcar
		   (lambda (triplet)
		     (let ((cname (concat (nth 2 triplet) (nth 1 triplet)))
			   (existing nil))
		       (setq existing (gethash cname canonical-fn-hash))
		       (when (not existing)
			 (puthash cname triplet canonical-fn-hash)
			 triplet)))
		   fc-triplets))))
	 (result-names nil)
	 (result-triplets nil))

    (mapc
     (lambda (buf-triplet)
       (puthash (nth 1 buf-triplet) buf-triplet choosename-hash))
     buf-triplets)

    (mapc
     (lambda (fc-triplet)
       (let* ((key (nth 1 fc-triplet))
	      (val (gethash key fc-basenames-hash)))
	 (if val
	     (puthash key (+ 1 val) fc-basenames-hash)
	   (puthash key 1 fc-basenames-hash))))
     fc-triplets)

    (mapc
     (lambda (fc-triplet)
       (let ((key (nth 1 fc-triplet)))
	 ;; if there is already a buffer with the same name,
	 ;; or there is a clash with another fc basename, put the
	 ;; canonical name in the choosename-hash
	 (if (or (gethash key choosename-hash)
		 (> 1 (gethash key fc-basenames-hash)))
	     (puthash (concat (nth 2 fc-triplet) (nth 1 fc-triplet))
		      fc-triplet choosename-hash)
	   (puthash (nth 1 fc-triplet) fc-triplet choosename-hash))))
     fc-triplets)

    ;; choosename-hash contains all of the entries from the fc we
    ;; want.  But add the ones from the cdr of the buffer list first,
    ;; so the buffer switching has "visual priority".  We don't need
    ;; the car since it's the current buffer, so why would we switch
    ;; to it?  Yeah, that's what I thought.
    (setq result-names (mapcar (lambda (triplet) (cadr triplet))
			       (cdr buf-triplets)))
    (setq result-triplets (cdr buf-triplets))
    ;; add the filecache entries from the choosename-hash at the end
    (let ((tail-rn nil)
	  (tail-rt nil))
      (maphash
       (lambda (k v)
	 (when (eq (car v) 'fc)
	   (setq tail-rn (cons k tail-rn))
	   (setq tail-rt (cons v tail-rt))))
       choosename-hash)
      (setq result-names (append result-names tail-rn))
      (setq result-triplets (append result-triplets tail-rt)))

    (let ((choice (iswitchb-fc-icompleting-read
		  "Switch to: " result-names))
	  (buf nil))
      (when choice
	(let* ((pos (position choice result-names))
	       (chosen-triplet (and pos (nth pos result-triplets))))
	  (if (not chosen-triplet)
	      (setq buf choice)
	    (cond
	     ((equal (car chosen-triplet) 'buf)
	      (setq buf (cadr chosen-triplet)))
	     ((equal (car chosen-triplet) 'fc)
	      (save-excursion
		(find-file (concat
			    (nth 2 chosen-triplet)
			    (nth 1 chosen-triplet)))
		(setq buf (current-buffer))))
	     (t (error "Internal error in iswitchb-fc"))))))
      (iswitchb-visit-buffer buf))))
(defalias 'iswitchb 'iswitchb-fc)

(provide 'iswitchb-fc)
;;; iswitchb-fc.el ends here
