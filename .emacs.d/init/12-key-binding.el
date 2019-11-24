(use-package free-keys :ensure t)
(use-package which-key
  :diminish which-key-mode
  :hook (after-init . which-key-mode))

(global-set-key [f2] 'rotate-window)
(global-set-key [f3] 'rotate-layout)
(global-set-key [f4] 'duplicate-thing) ;;前の行をコピー
(global-set-key [f5] 'revert-buffer)               ;;ファイルを読み込み直す

(global-set-key [zenkaku-hankaku] 'toggle-input-method) ;; 日本語切り替え

(define-key function-key-map [capslock] 'event-apply-control-modifier)  ;; super キーの設定
(define-key function-key-map [apps] 'event-apply-hyper-modifier)        ;; super キーの設定
(define-key function-key-map [lwindow] 'event-apply-super-modifier) ;; super キーの設定

(global-set-key "\C-z" nil)

(global-set-key "\C-n" 'next-line-recenter)
(global-set-key "\C-p" 'previous-line-recenter)
(global-set-key "\C-h" 'delete-backward-char)                 ;; 文字の削除
(global-set-key "\C-w" 'my-kill-region-or-backward-kill-word) ;; 単語を削除
(global-set-key "\C-\\" 'redo) ;; やり直し
(global-set-key (kbd "C-}") 'mc/mark-next-like-this)
(global-set-key (kbd "C-{") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-*") 'mc/mark-all-dwim)
(global-set-key (kbd "C-^") popwin:keymap)
(global-set-key (kbd "C-+") 'increment-string-as-number)
(global-set-key (kbd "C--") 'decrement-string-as-number)
(global-set-key (kbd "C-;") 'switch-to-previous-buffer)
(global-set-key (kbd "C-,") 'tabbar-backward-tab)
(global-set-key (kbd "C-.") 'tabbar-forward-tab)

(global-set-key "\C-xri"   'insert-pair-region) ;;regionを文字列で囲む
(global-set-key "\C-xrr"   'replace-rectangle) ;;矩形分の文字列を置換
(global-set-key "\C-xrn"   'number-rectangle) ;;矩形の左端に数列を挿入

(global-set-key "\C-z\C-f" 'counsel-find-file)
(global-set-key "\C-z\C-g" 'counsel-ag)
(global-set-key "\C-z\C-i" 'counsel-imenu)
(global-set-key "\C-z\C-r" 'counsel-recentf)

(global-set-key "\M-gg" 'nil)
(global-set-key "\M-g\M-g" 'nil)
(global-set-key "\M-g" 'goto-line)
(global-set-key (kbd "M-n") 'next-line-visual)
(global-set-key (kbd "M-p") 'previous-line-visual)

(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "M-w") 'my-kill-ring-save-or-backward-kill-line) ;; 行頭まで削除
(global-set-key (kbd "M-z") 'zop-up-to-char)

