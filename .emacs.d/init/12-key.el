;;; key-binding.el ---

;; ====================================
;; キーバインド
;; ====================================

(use-package free-keys)
(use-package which-key
  :diminish which-key-mode
  :hook (after-init . which-key-mode))

(global-set-key [mouse-5] 'inertias-up )
(global-set-key [mouse-4] 'inertias-down )
(global-unset-key [\C-down-mouse-1])
(global-unset-key [\C-down-mouse-3])

(global-set-key [f2] 'rotate-window)
(global-set-key [f3] 'rotate-layout)
(global-set-key [f4] 'duplicate-thing) ;;前の行をコピー
(global-set-key [f5] 'revert-buffer)               ;;ファイルを読み込み直す

;; (setq w32-pass-lwindow-to-system nil
;;       w32-pass-apps-to-system nil
;;       w32-apps-modifier 'hyper
;;       w32-lwindow-modifier 'super ) ; Left Windows key

(global-set-key [ralt] 'toggle-input-method) ;; 日本語切り替え
;;(global-set-key [zenkaku-hankaku] 'ibus-toggle) ;; 日本語切り替え

;;(define-key function-key-map [capslock] 'event-apply-control-modifier)  ;; super キーの設定
;;(define-key function-key-map [rctl] 'event-apply-hyper-modifier)        ;; super キーの設定
(define-key function-key-map [rctl] 'event-apply-super-modifier) ;; super キーの設定

;;(global-set-key (kbd "s-w") 'copy-line)
(global-set-key (kbd "s-w") 'copy-whole-line)
;;(global-set-key (kbd "s-k") 'kill-line*)
(global-set-key (kbd "s-k") 'kill-whole-line)
(global-set-key (kbd "s-t") 'helm-gtags-find-tag)
(global-set-key (kbd "s-r") 'helm-gtags-find-rtag)
(global-set-key (kbd "s-s") 'helm-gtags-find-symbol)
(global-set-key (kbd "s-n") 'flycheck-goto-next-error)
(global-set-key (kbd "s-p") 'flycheck-goto-prev-error)
(global-set-key (kbd "s-z") 'emacs-surround)
;;(global-set-key (kbd "H-/") 'auto-complete)

(global-set-key "\C-j" 'quick-buffer-switch-map)
(global-set-key "\C-m" 'smart-newline)
(global-set-key "\C-n" 'next-line-recenter)
(global-set-key "\C-p" 'previous-line-recenter)
(global-set-key "\C-h" 'delete-backward-char)                 ;; 文字の削除
(global-set-key "\C-w" 'my-kill-region-or-backward-kill-word) ;; 単語を削除
(global-set-key "\C-\\" 'redo) ;; やり直し
;; (global-set-key (kbd "C->") 'winhist-backward)
;; (global-set-key (kbd "C-<") 'winhist-forward)
(global-set-key (kbd "C-}") 'mc/mark-next-like-this)
(global-set-key (kbd "C-{") 'mc/mark-previous-like-this)
;;(global-set-key (kbd "C-*") 'mc/mark-all-like-this)
(global-set-key (kbd "C-*") 'mc/mark-all-dwim)
(global-set-key (kbd "C-^") popwin:keymap)
(global-set-key (kbd "C-+") 'increment-string-as-number)
(global-set-key (kbd "C--") 'decrement-string-as-number)
;;(global-set-key (kbd "C-;") 'elscreen-toggle)
(global-set-key (kbd "C-;") 'switch-to-previous-buffer)
;;(global-set-key (kbd "C-,") 'elscreen-previous)
(global-set-key (kbd "C-,") 'tabbar-backward-tab)
;;(global-set-key (kbd "C-.") 'elscreen-next)
(global-set-key (kbd "C-.") 'tabbar-forward-tab)
;;(global-set-key "\C-\[" 'sense-expand-region)
;;(global-set-key "\C-\]" 'er/contract-region)

(global-set-key "\C-x\C-b" 'helm-buffers-list)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)
(global-set-key (kbd "C-x C-n") 'helm-resume-and-next)
(global-set-key (kbd "C-x C-p") 'helm-resume-and-previous)
;;(global-set-key "\C-x\C-s" 'see-you-again)

(global-set-key "\C-xri"   'insert-pair-region) ;;regionを文字列で囲む
(global-set-key "\C-xrr"   'replace-rectangle) ;;矩形分の文字列を置換
(global-set-key "\C-xrn"   'number-rectangle) ;;矩形の左端に数列を挿入
(global-set-key "\C-xrl"   'helm-bookmarks)

(global-set-key "\C-z" nil)

(global-set-key "\C-z\C-a" 'goto-last-change)
;;(global-set-key "\C-z\C-b" 'search-buffers) ;; ディレクトリのファイルを検索
;;(global-set-key "\C-z\C-b" 'yafastnav-jump-to-backward)
;;(global-set-key "\C-z\C-b" 'anything-buffers-list)
(global-set-key "\C-z\C-b" 'helm-buffers-list)
;;(global-set-key "\C-z\C-b" 'helm-projectile)
;;(global-set-key "\C-z\C-c" 'kill-comment)
(global-set-key "\C-z\C-c" 'git-complete)
(global-set-key "\C-z\C-d" 'dmoccur)                           ;; ディレクトリのファイルを検索
(global-set-key "\C-z\C-e" 'goto-last-change-reverse)
;;(global-set-key "\C-z\C-f" 'anything-recentf)
;;(global-set-key "\C-z\C-f" 'helm-recentf)
(global-set-key "\C-z\C-f" 'helm-for-files)
(global-set-key "\C-z\C-g" 'moccur-grep)                       ;; ディレクトリのファイルを検索
;;(global-set-key "\C-z\C-g" 'helm-multi-swoop-all)                       ;; ディレクトリのファイルを検索
;;(global-set-key "\C-z\C-i" 'flyspell-correct-word-popup-el)
;;(global-set-key "\C-z\C-i" 'zencoding-expand-yas)
(global-set-key "\C-z\C-i" 'emmet-expand-line)
(global-set-key "\C-z\C-j" 'jaunte)
;;(global-set-key "\C-z\C-k" 'kill-paragraph)                    ;;段落末まで削除
;;(global-set-key "\C-z\C-l" 'my-pop-killed-file-name-list)
;;(global-set-key "\C-z\C-l" 'anything-for-current-buffer)
(global-set-key "\C-z\C-l" 'helm-for-current-buffer)
(global-set-key "\C-z\C-m" 'moccur-grep-find)                  ;; バッファを検索
;;(global-set-key "\C-z\C-m" 'helm-multi-swoop)                  ;; バッファを検索
(global-set-key "\C-z\C-n" 'bm-next)                           ;; 次のマークへ
(global-set-key "\C-z\C-o" 'moccur)
(global-set-key "\C-z\C-p" 'bm-previous)                       ;;前のマークへ
(global-set-key "\C-z\C-r" 'align-regexp)                      ;;前のマークへ
;;(global-set-key "\C-z\C-s" 'sdic-describe-word-at-point)
(global-set-key "\C-z\C-s" 'dumb-jump-go)
;;(global-set-key "\C-z\C-t" 'text-translator-all)
(global-set-key (kbd "C-z C-t") 'google-translate-enja-or-jaen)
(global-set-key "\C-z\C-v" 'ace-jump-mode)
(global-set-key "\C-z\C-w" 'delete-trailing-whitespace)        ;;行末の余分な空白を削除する
(global-set-key (kbd "C-z C-/")  'point-undo)
(global-set-key "\C-z\C-\\" 'point-redo)
;;(global-set-key (kbd "C-z C-,") 'switch-to-next-new-file-visit-buffer)          ;;ウィンドウ分割のUndo  // tags-loop-continue
;;(global-set-key (kbd "C-z C-.") 'switch-to-oldest-file-visit-buffer)            ;;ウィンドウ分割のRedo  // find-tag
(global-set-key (kbd "C-z C-SPC") 'sense-expand-region)
;;(global-set-key (kbd "C-z C-@") 'er/expand-region)
;; (global-set-key (kbd "C-z C-@") 'er/contract-region)

(global-set-key "\C-zl" 'align)                 ;;整列
(global-set-key "\C-zb" 'helm-bm)
(global-set-key "\C-zc" 'clone-indirect-buffer)

(defvar my-original-map (make-sparse-keymap)
  "My original keymap binded to C-q.")
(defalias 'my-original-prefix my-original-map)
(define-key global-map (kbd "C-q") 'my-original-prefix)
(define-key my-original-map (kbd "C-q") 'quoted-insert)

(global-set-key "\M-gg" 'nil)
(global-set-key "\M-g\M-g" 'nil)
(global-set-key "\M-g" 'goto-line)
(global-set-key (kbd "M-n") 'next-line-visual)
(global-set-key (kbd "M-p") 'previous-line-visual)
;;(global-set-key "\M-o" 'occur-by-moccur) ;; 現在のバッファを検索
;;(global-set-key "\M-o" 'helm-occur) ;; 現在のバッファを検索
(global-set-key "\M-o" 'helm-swoop) ;; 現在のバッファを検索
;;(global-set-key "\M-x" 'anything-M-x)
(global-set-key "\M-x" 'helm-M-x)
(global-set-key "\M-y" 'helm-show-kill-ring) ;; 削除履歴
;;(global-set-key "\M-y" 'anything-show-kill-ring) ;; 削除履歴
(global-set-key "\M-w" 'my-kill-ring-save-or-backward-kill-line) ;; 行頭まで削除
;;(global-set-key "\M-z" 'ace-jump-zap-up-to-char) ;; 指定文字の前まで削除
(global-set-key (kbd "M-z") 'zop-up-to-char)
(global-set-key [?\M-:] 'my-repeat)                                     ;;繰り返し動作
;;(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "M-%") 'vr/replace)
(global-set-key (kbd "M-SPC") 'shrink-whitespace)

(global-set-key (kbd "C-M-l") 'imenus-mode-buffers)
(global-set-key (kbd "C-M-g") 'helm-ag)
(global-set-key (kbd "C-M-k") 'backward-kill-sexp) ;推奨
(global-set-key (kbd "C-M-%") 'vr/query-replace)
(global-set-key (kbd "C-M-SPC") 'bm-toggle)

;; (global-set-key (kbd "M-,")  'tabbar-backward-tab)
;; (global-set-key (kbd "M-.")  'tabbar-forward-tab)

(define-key isearch-mode-map (kbd "C-f") 'isearch-yank-char) ;; 文字を 1 文字ずつ追加
(define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char) ;; 検索文字列を一文字削除
(define-key isearch-mode-map (kbd "C-y") 'isearch-yank-kill) ;; 検索文字列にヤンク貼り付け
(define-key isearch-mode-map (kbd "C-e") 'isearch-edit-string) ;; 検索文字列を編集

;; 検索文字列を補完
(define-key isearch-mode-map (kbd "<tab>") 'isearch-dabbrev-expand)
(define-key isearch-mode-map (kbd "M-o") 'helm-occur-from-isearch)
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch) ;; isearch実行中にhelm-swoopに移行
(define-key isearch-mode-map (kbd "M-m") 'helm-multi-swoop-all-from-isearch)

;; C-gで検索を終了
(define-key isearch-mode-map (kbd "C-g")
  '(lambda() (interactive) (isearch-done)))

(define-key minibuffer-local-completion-map "\C-h" 'delete-backward-char) ;;ミニバッファ内で単語削除
(define-key minibuffer-local-completion-map "\C-w" 'backward-kill-word) ;;ミニバッファ内で単語削除

(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

(define-key web-mode-map (kbd "C-;") nil)
(define-key web-mode-map (kbd "C-c /") 'web-mode-element-close)
(define-key web-mode-map (kbd "C-c C-m") 'web-mode-tag-match)

;;(define-key php-mode-map [(control .)] 'tabbar-forward-tab)

;;(define-key emmet-mode-map (kbd "C-j") 'quick-buffer-switch-map)

(define-key phi-search-default-map (kbd "M-m") 'phi-search-migemo-toggle)
(with-eval-after-load 'multiple-cursors-core
  (define-key mc/keymap (kbd "C-s") 'phi-search-migemo)
  (define-key mc/keymap (kbd "C-r") 'phi-search-migemo-backward))

;; (require 'region-bindings-mode)
;; (region-bindings-mode-enable)
;; (define-key region-bindings-mode-map "\M-a" 'mc/mark-all-like-this)
;; (define-key region-bindings-mode-map "\M-p" 'mc/mark-previous-like-this)
;; (define-key region-bindings-mode-map "\M-n" 'mc/mark-next-like-this)
;; (define-key region-bindings-mode-map "\M-m" 'mc/mark-more-like-this-extended)
;; (define-key region-bindings-mode-map "\M-s" 'phi-search)
;; (define-key region-bindings-mode-map "\M-r" 'phi-search-backward)
;; (define-key region-bindings-mode-map "\M-q" 'query-replace-from-region)

(use-package bind-key)
(bind-key* "C-h" 'delete-backward-char)
(bind-key* "C-w" 'my-kill-region-or-backward-kill-word)
(bind-key* "C-j" 'quick-buffer-switch-map)
(bind-key* "C-," 'tabbar-backward-tab)
(bind-key* "C-." 'tabbar-forward-tab)
(bind-key* "C-;" 'switch-to-previous-buffer)

(use-package sequential-command)
(require 'sequential-command-config)

(define-sequential-command seq-mark
 mark-word* mark-sexp* mark-string mark-up-list seq-return)
(global-set-key (kbd "C-@") 'seq-mark)

(define-sequential-command seq-home
  beginning-of-line backward-sentence seq-return)
(global-set-key "\C-a" 'seq-home)

(define-sequential-command seq-end
  end-of-line forward-sentence seq-return)
(global-set-key "\C-e" 'seq-end)

(use-package smartrep)
(smartrep-define-key
    global-map "C-q" '(("p" . (backward-paragraph))
                       ("n" . (forward-paragraph))
                       ("a" . (backward-list))
                       ("e" . (forward-list))
                       ("f" . (forward-sentence))
                       ("b" . (backward-sentence))
                       ))
