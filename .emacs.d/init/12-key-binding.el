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

(global-set-key (kbd "C-,") 'tabbar-backward-tab)
(global-set-key (kbd "C-.") 'tabbar-forward-tab)

(global-set-key "\C-z" nil)
