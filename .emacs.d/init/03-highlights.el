(show-paren-mode t)
(transient-mark-mode 1)                ;;選択範囲に色を付ける
(setq highlight-nonselected-windows t) ;;バッファを切り替えても色はついたままの状態にする

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
      '((space-mark ?\u3000 [?\u25a1])
        ;; WARNING: the mapping below has a problem.
        ;; When a TAB occupies exactly one column, it will display the
        ;; character ?\xBB at that column followed by a TAB which goes to
        ;; the next TAB column.
        ;; If this is a problem for you, please, comment the line below.
        (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))
(setq whitespace-space-regexp "\\(\u3000+\\)")
(global-whitespace-mode t)

(use-package hl-line)
(defun global-hl-line-timer-function ()
  (global-hl-line-unhighlight-all)
  (let ((global-hl-line-mode t))
    (global-hl-line-highlight)))

(setq global-hl-line-timer
      (run-with-idle-timer 0.1 t 'global-hl-line-timer-function))

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
  :hook (prog-mode . rainbow-mode))
(setq rainbow-html-colors t)
(setq rainbow-x-colors t)
(setq rainbow-latex-colors t)
(setq rainbow-ansi-colors t)

(use-package volatile-highlights)
(volatile-highlights-mode t)
(add-hook 'after-init-hook 'global-color-identifiers-mode)

(use-package highlight-indent-guides)
(setq highlight-indent-guides-auto-enabled t)
(setq highlight-indent-guides-responsive t)
(setq highlight-indent-guides-method 'fill)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
