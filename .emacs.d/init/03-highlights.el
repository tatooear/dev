(require 'whitespace)
(setq whitespace-style
      '(
        face ; faceで可視化
        trailing ; 行末
        tabs ; タブ
        spaces ; スペース
        space-mark ; 表示のマッピング
        tab-mark
        ))
(setq whitespace-display-mappings
      '(
        (space-mark ?\u3000 [?\u2423])
        (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])
        ))
(setq whitespace-trailing-regexp  "\\([ \u00A0]+\\)$")
(setq whitespace-space-regexp "\\(\u3000+\\)")

(use-package hl-line
  :ensure nil
  :hook
  (after-init . global-hl-line-mode))

(use-package mic-paren)
(paren-activate)
;(setq paren-match-face '(underline paren-face)) ;下線
(setq paren-match-face 'bold paren-sexp-mode t) ; bold
(setq paren-sexp-mode t)

(use-package highlight-symbol)

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package rainbow-mode
  :hook (emacs-lisp-mode . rainbow-mode))

(use-package volatile-highlights
  :hook
  (after-init . volatile-highlights-mode))

(use-package all-the-icons)
