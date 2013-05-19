;;; ELISP.EL
;;
;; Copyright (c) 2006 2007 2008 2009 2010 2011 Charles Lu
;;
;; Author:  Charles Lu <loochao@gmail.com>
;; URL:     http://www.princeton.edu/~chaol
;; License: GNU
;;
;; This file is not part of GNU Emacs.
;;
;; Commentary:
;; Settings for elisp packages.

;;; CODE
(message "=> lch-elisp: loading...")
;;; Dictionary
(autoload 'dictionary-search "dictionary" "Ask for a word and search it in all dictionaries" t)
(autoload 'dictionary "dictionary" "Create a new dictionary buffer" t)
(autoload 'dictionary-match-words "dictionary" "Ask for a word and search all matching words in the dictionaries" t)
(autoload 'dictionary-lookup-definition "dictionary" "Unconditionally lookup the word at point." t)
(autoload 'dictionary-mouse-popup-matching-words "dictionary" "Display entries matching the word at the cursor" t)
(autoload 'dictionary-popup-matching-words "dictionary" "Display entries matching the word at the point" t)
(autoload 'dictionary-tooltip-mode "dictionary" "Display tooltips for the current word" t)
(autoload 'global-dictionary-tooltip-mode "dictionary" "Enable/disable dictionary-tooltip-mode for all buffers" t)

(define-key global-map (kbd "<f7> <f7>") 'dictionary-search)

;;; Windmove
;; Part of GNU Emacs
;; Use shift + arrow to navigate between windows. 
(require 'windmove)
(windmove-default-keybindings)
;;; Color-grep
(require 'color-grep)

;;; Go-to-char
(require 'go-to-char)

;;; Less-mode
(require 'less)
(require 'lch-key-util)
(define-key global-map (kbd "C-c v") 'less-minor-mode)
(defvar vi-move-key-alist nil
  "The key alist that like vi move.")
(setq vi-move-key-alist
      '(("j" . next-line)
        ("k" . previous-line)
        ("h" . backward-char)
        ("l" . forward-char)
        ("e" . scroll-down)
        ("SPC" . scroll-up)))
(lch-set-key vi-move-key-alist less-minor-mode-map)
(lch-set-key
 '(
   ("J" . less-scroll-up-one-line)
   ("K" . less-scroll-down-one-line)
   ("." . go-to-char-forward)
   ("," . go-to-char-backward)
   (">" . beginning-of-buffer)
   ("<" . end-of-buffer)
   ("q" . less-quit)
   ("b" . one-key-menu-hideshow)
   ("t" . one-key-menu-etags)
   )
 less-minor-mode-map
 )
;;; Rainbow-delimiter
(require 'rainbow-delimiters)
(define-key global-map (kbd "<f11> r") 'rainbow-delimiters-mode)  ;p stands for parenthesis
;;; Matlab
;; Work like a charm, but only enable when needed
;;(require 'matlab-load)
;;; Ace-jump-mode
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  ""
  t)
(define-key global-map (kbd "C-c j") 'ace-jump-mode)
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;;; Diminish
;; diminish keeps the modeline tidy
;; by removing or abbreviating minor mode indicators.
(require 'diminish)

;;; Savehist
;; keeps track of some history
;; Part of GNU Emacs
(require 'savehist)
(setq savehist-additional-variables
      ;; search entries
      '(search ring regexp-search-ring)
      ;; save every minute
      savehist-autosave-interval 60
      ;; keep the home clean
      savehist-file (concat emacs-var-dir "/savehist"))
(savehist-mode +1)

;;; Saveplace
;; Save point position between sessions
;; When you visit a file, point goes to the last place where it was
;; when you previously visited. Save file is set to emacs-var-dir/saveplace
(require 'saveplace)

;; activate it for all buffers
(setq-default save-place t)
(setq save-place-file (concat emacs-var-dir "/saveplace"))

;;; Volatile-highlights
(require 'volatile-highlights)
(volatile-highlights-mode t)
(diminish 'volatile-highlights-mode)
;;; Cowsay-fortune
(require 'cowsay-fortune)
(defun lch-cowsay-fortune ()
  (interactive)
  (switch-to-buffer (get-buffer-create "*fortune*"))
  (fortune-show))
(define-key global-map (kbd "<f1> f") 'lch-cowsay-fortune)

;;; Paredit
(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code."
  t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(define-key global-map (kbd "<f2> p") 'paredit-mode)
;;; Eye-dropper
;; To pick the fg and bg color at point
(require 'eyedropper)
;;; Thing-edit
;; Written by lazy cat, do sth after get things at point
;; An one key menu defined in lch-one-key.el
(require 'thing-edit)
;;; Flyspell
;; Part of GNU Emacs
(require 'flyspell)
(setq ispell-program-name "aspell" ; use aspell instead of ispell
      ispell-extra-args '("--sug-mode=ultra"))

(defun lch-enable-flyspell ()
  (when (executable-find ispell-program-name)
    (flyspell-mode +1)))
(add-hook 'text-mode-hook 'lch-enable-flyspell)

;;; AucTeX
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

(setq-default TeX-master nil)
(defun lch-latex-mode-hook ()
  (turn-on-auto-fill)
  (abbrev-mode +1)
  (flyspell-mode +1))
(add-hook 'LaTeX-mode-hook 'lch-latex-mode-hook)
;;; Anything
;; Anything.el provides a framework.
;; has to enable anything-config to make it really go.
;; anything-config is quite long and powerful.
(require 'anything)
(require 'anything-match-plugin)

(require 'anything-config)
(define-key global-map (kbd "M-SPC") 'anything)
(define-key global-map (kbd "M-a") 'anything-command-map)
;;; Outline
;; Outline is part of GNU Emacs
;; TODO: bind the outline-minor-mode-prefix C-c @ to C-o
(add-hook 'outline-minor-mode-hook 'hide-body)

;; Add hook to the following major modes so that the outline minor mode starts automatically.
;; Outline mode is better to be enabled only in document modes.
(dolist (hook
         '(emacs-lisp-mode-hook latex-mode-hook text-mode-hook change-log-mode-hook makefile-mode-hook))
  (add-hook hook 'outline-minor-mode))

(define-key global-map (kbd "M-<left>") 'hide-body)
(define-key global-map (kbd "M-<right>") 'show-all)
(define-key global-map (kbd "<left>") 'hide-entry)
(define-key global-map (kbd "<right>") 'show-entry)
(define-key global-map (kbd "M-<up>") 'outline-previous-heading)
(define-key global-map (kbd "M-<down>") 'outline-next-heading)

;;; Browse-kill-ring
;; (info "(emacs)Kill Ring")
(require 'browse-kill-ring)
(setq browse-kill-ring-separator
      "\n--item------------------------------")
(browse-kill-ring-default-keybindings)
(setq browse-kill-ring-highlight-inserted-item t)
(setq browse-kill-ring-highlight-current-entry t)
(setq browse-kill-ring-no-duplicates t)

;;; Recentf
;; Part of GNU Emacs
(require 'recentf)

;; toggle `recentf' mode
(recentf-mode +1)

;; file to save the recent list into
(setq recentf-save-file (concat emacs-var-dir "/emacs.recentf")
      recentf-max-saved-items 200
      recentf-max-menu-items 30
      recentf-exclude '("/tmp/" "/ssh:"))

;; Key bindings
(define-key global-map (kbd "C-x C-r") 'recentf-open-files)

;;; Undo-tree
;; Represent undo-history as an actual tree (visualize with C-x u)
(require 'undo-tree)
(global-undo-tree-mode 1)
(define-key global-map (kbd "C-x u") 'undo-tree-visualize)
(diminish 'undo-tree-mode)

;;; Uniquify
;; Make filename unique.
;; Part of GNU Emacs.
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward
      uniquify-separator ":")
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

;;; Rainbow-mode
;; Autoload to speed up.
(autoload 'rainbow-mode "rainbow-mode.el" "" t)
(define-key global-map (kbd "<f11> R") 'rainbow-mode)
;;; Live-fontify-hex
;; Display colors directly in lisp mode
;; Helpful when you write color-theme.
;; Enable only when work with color.
(require 'live-fontify-hex)
(font-lock-add-keywords 'lisp-mode
                        '((live-fontify-hex-colors)))
(font-lock-add-keywords 'emacs-lisp-mode
                        '((live-fontify-hex-colors)))
(font-lock-add-keywords 'lisp-interaction-mode
                        '((live-fontify-hex-colors)))
(font-lock-add-keywords 'css-mode
                        '((live-fontify-hex-colors)))

;;; Smex
(require 'smex)
(smex-initialize)
(setq smex-save-file (concat emacs-var-dir "/.smex-items"))
(define-key global-map (kbd "M-x") 'smex)
;; (define-key global-map (kbd "M-X") 'smex-major-mode-commands)
;; Old M-x.
(define-key global-map (kbd "C-c C-c M-x") 'execute-extended-command)

;;; Markdown-mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
;; (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;; iDo
(ido-mode t)
(define-key global-map (kbd "C-x b") 'ido-switch-buffer)

;; Ignore .DS_Store files with ido mode
(add-to-list 'ido-ignore-files "\\.DS_Store")

;;; iBuffer
;; Part of GNU Emacs
(define-key global-map (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;;; Goto-last-change
(require 'goto-last-change)
(define-key global-map (kbd "C-x C-\\") 'goto-last-change)
(define-key global-map (kbd "<f2> <f2>") 'goto-last-change)
;;; Desktop
;; Part of GNU Emacs
(require 'desktop)

(defun desktop-settings-setup()
  (desktop-save-mode 1)
  (setq desktop-save t)
  (setq desktop-load-locked-desktop t)
  (setq desktop-dirname emacs-var-dir)
  (setq desktop-path (list emacs-var-dir))
  (if (file-exists-p (concat desktop-dirname desktop-base-file-name))
      (desktop-read desktop-dirname)))

(add-hook 'after-init-hook 'desktop-settings-setup)

;;; Yasnippet
(require 'yasnippet)
(defvar lch-yasnippet-dir (concat emacs-lib-dir "/snippets") "")
(add-to-list 'yas-snippet-dirs lch-yasnippet-dir)
(yas-global-mode 1)

(defun lch-reload-snippets ()
  (interactive)
  (dolist (x yas-snippet-dirs)
    (when (file-exists-p x)
      (yas-load-directory x))))

;;; Auto-complete
;; Disable it usually, for it's slow and distracting.
;; Try dabbrev-expand (M-/)
(require 'auto-complete)
(require 'auto-complete-config)
(require 'lch-key-util)
(ac-config-default)
(ac-flyspell-workaround)
(add-to-list 'ac-dictionary-directories (concat emacs-var-dir "/auto-complete-dict"))
(setq ac-comphist-file  (concat emacs-var-dir "/ac-comphist.dat"))

(global-auto-complete-mode t)
(setq ac-auto-show-menu t)
(setq ac-dwim t)
(setq ac-use-menu-map t)
(setq ac-quick-help-delay 1)
(setq ac-quick-help-height 60)
(setq ac-disable-inline t)
(setq ac-show-menu-immediately-on-auto-complete t)
(setq ac-auto-start 2)
(setq ac-candidate-menu-min 0)

(set-default 'ac-sources
             '(ac-source-dictionary
               ac-source-words-in-buffer
               ac-source-words-in-same-mode-buffers
               ac-source-semantic
               ac-source-yasnippet))

;; (dolist (mode '(org-mode text-mode lisp-mode markdown-mode))
;;   (add-to-list 'ac-modes mode))

;; Key triggers
(define-key ac-completing-map (kbd "M-.") 'ac-next)
(define-key ac-completing-map (kbd "M-,") 'ac-previous)
(define-key ac-completing-map "\t" 'ac-complete)
(define-key ac-completing-map (kbd "M-RET") 'ac-help)
(define-key ac-completing-map "\r" 'nil)

;;; PROVIDE
(provide 'lch-elisp)
(message "~~ lch-elisp: done.")

;; Local Variables:
;; mode: emacs-lisp
;; mode: outline-minor
;; outline-regexp: ";;;;* "
;; End:















































