;;-*- coding:utf-8; mode:emacs-lisp; -*-

;;; DIRED
;;
;; Copyright (c) 2006 2007 2008 2009 2010 2011 Charles LU
;;
;; Author:  Charles LU <loochao@gmail.com>
;; URL:     http://www.princeton.edu/~chaol
;; Licence: GNU
;;
;; This file is not part of GNU Emacs.
;;
;; Commentary:
;; Settings for dired

;;; CODE
(message "=> lch-dired: loading...")

(require 'dired)
(setq dired-recursive-copies t)                        
(setq dired-recursive-copies 'always)                  ;No ask when copying recursively.
(setq dired-recursive-deletes t)                       
(setq dired-recursive-deletes 'always)                 ;No ask when delete recursively.

;;; Dired-lisps
;; Dired-x
;; dired-x is part of GNU Emacs
;; enable some really cool extensions like C-x C-j(dired-jump)
(require 'dired-x)
(define-key global-map (kbd "C-6") 'dired-jump)

;; Wdired
;; wdired is Part of GNU Emacs.
(require 'wdired)
(define-key dired-mode-map "w" 'wdired-change-to-wdired-mode)

;;; Utils
(defun dired-open-mac ()
  (interactive)
  (let ((file-name (dired-get-file-for-visit)))
    (if (file-exists-p file-name)
	(call-process "/usr/bin/open" nil 0 nil file-name))))
(define-key dired-mode-map "o" 'dired-open-mac)

(defun dired-up-directory-single ()
  "Return up directory in single window.
When others visible window haven't current buffer, kill old buffer after `dired-up-directory'.
Otherwise, just `dired-up-directory'."
  (interactive)
  (let ((old-buffer (current-buffer))
        (current-window (selected-window)))
    (dired-up-directory)
    (catch 'found
      (walk-windows
       (lambda (w)
         (with-selected-window w
           (when (and (not (eq current-window (selected-window)))
                      (equal old-buffer (current-buffer)))
             (throw 'found "Found current dired buffer in others visible window.")))))
      (kill-buffer old-buffer))))
(define-key dired-mode-map "'" 'dired-up-directory-single)
(define-key dired-mode-map (kbd "C-6") 'dired-up-directory-single)

;; Emms
(define-key dired-mode-map "!" 'emms-add-dired)
;;; PROVIDE
(provide 'lch-dired)
(message "~~ lch-dired: done.")


;; Local Variables:
;; mode: emacs-lisp
;; mode: outline-minor
;; outline-regexp: ";;;;* "
;; End:
