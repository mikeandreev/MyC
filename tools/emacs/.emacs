;;;;; emacs start-up parameters:
;  --no-splash --debug-init
;;;;; elpa configuration
; to install models:
; M-x list-packages
; to install:
;  * all that are require-ed from this file
;  * ack
;  * sml-mode (for 2014_proglang)
; 
; -- ver 1
; (require 'package)
; (push '("marmalade" . "http://marmalade-repo.org/packages/")
;       package-archives )
; (package-initialize)
;; --- ver 2
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                        ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")))
; (push '("melpa" . "http://melpa.milkbox.net/packages/")  package-archives)
(package-initialize)
;
; 
(defun require-package (package)
  (setq-default highlight-tabs t)
  "Install given PACKAGE."
  (unless (package-installed-p package)
    (unless (assoc package package-archive-contents)
      (package-refresh-contents))
    (package-install package)))

;;;;;
(desktop-save-mode 1)
;(desktop-restore-frames 1)
(global-linum-mode t)

(require 'smooth-scrolling)
(setq smooth-scroll-margin 1)
(setq scroll-conservatively 9999
      scroll-preserve-screen-position t)

;;;;; vim - like keybindings with my twicks
; cua
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

; evil
(require 'evil)
;   my key binding update in evil-maps.el
; (define-key evil-motion-state-map "\C-q" 'evil-visual-block)
;   comment out
; (define-key evil-motion-state-map "\C-v" 'evil-visual-block)
(evil-mode 1)
;(global-evil-tabs-mode t)
(require 'evil-jumper)
;
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(setq evil-leader/in-all-states 1)

(require 'ace-jump-mode)
(evil-leader/set-key "w" 'evil-ace-jump-word-mode) ; ,w for Ace Jump (word)
(evil-leader/set-key "l" 'evil-ace-jump-line-mode) ; ,l for Ace Jump (line)
(evil-leader/set-key "x" 'evil-ace-jump-char-mode) ; ,x for Ace Jump (char)


;C-s save-buffer
(global-set-key (kbd "C-s") 'save-buffer)

(global-auto-revert-mode 1)
