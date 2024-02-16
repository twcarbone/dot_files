;; Startup
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(electric-pair-mode t)
(show-paren-mode 1)
(column-number-mode 1)
(ido-mode 1)

;; Keybindings
(global-set-key (kbd "M-o") 'other-window)

;; Packages
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; ido
(setq ido-auto-merge-work-directories-length -1)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; company
(add-hook 'after-init-hook 'global-company-mode)

;; Line numbers
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; Dired
(setq dired-listing-switches "-lhva --group-directories-first")

;; cc mode
(setq c-default-style "stroustrup")

;; Other
(setq compile-command "")

;; Functions
(defun kill-all-buffers ()
  "Kill all buffers."
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

;; Insert newline below current without breaking
;; https://stackoverflow.com/a/57332647
(global-set-key (kbd "<C-return>") (lambda ()
				     (interactive)
				     (end-of-line)
				     (newline-and-indent)))

;; Insert newline above current without breaking
;; https://stackoverflow.com/a/57332647
(global-set-key (kbd "<C-S-return>") (lambda ()
				       (interactive)
				       (previous-line)
				       (end-of-line)
				       (newline-and-indent)
				       ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("e27c9668d7eddf75373fa6b07475ae2d6892185f07ebed037eedf783318761d7" default))
 '(package-selected-packages '(company clang-format magit gruber-darker-theme smex)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)
