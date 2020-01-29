;;行番号を表示
(require 'linum)
;; (require 'hlinum)
;; (hlinum-activate)
(setq linum-format "%04d") ; 5 桁分の領域を確保して行番号のあとにスペースを入れ
(global-linum-mode t)      ; デフォルトで linum-mode を有効にする
;;(fringe-mode 0)
(fringe-mode)

(tool-bar-mode 0)                      ;; ツールバーを表示しない

(require 'server)
(server-start)

(remove-hook
 'kill-buffer-query-functions
 'server-kill-buffer-query-function)
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")
(global-auto-revert-mode t)

;; 改行
(use-package smart-newline)
(smart-newline-mode 1)


;; ============================================
;; スクロール設定
;; ============================================
;;1行ずつスクロールさせる
(setq scroll-conservatively 35
       scroll-margin 0
       scroll-step 1)

;; 画面スクロール
(defun next-line-recenter()
  (interactive)
  (next-line)
  (recenter)
  )

(defun previous-line-recenter()
  (interactive)
  (previous-line)
  (recenter)
  )

(require 'inertial-scroll)
(inertias-global-minor-mode 1)

(setq inertias-scroll-initial-velocity 10)
(setq inertias-initial-velocity 20)
(setq inertias-friction 120)
(setq inertias-update-time 50)
(setq inertias-rest-coef 0.1)

(setq scroll-preserve-screen-position t) ; スクロール時のカーソル位置を維持
(setq scroll-margin 0) ;; スクロール開始の残り行数
(setq scroll-conservatively 10000) ;; スクロール時の行数
(setq scroll-step 0) ;; スクロール時の行数（scroll-marginに影響せず）
(setq next-screen-context-lines 1) ;; 画面スクロール時の重複表示する行数
;;(setq redisplay-dont-pause t) ;; キー入力中の画面更新を抑止
(setq recenter-positions '(top bottom)) ;; recenter-top-bottomのポジション
(setq hscroll-margin 1) ;; 横スクロール開始の残り列数
(setq hscroll-step 1) ;; 横スクロール時の列数

;; ============================================
;; その他
;; ===========================================
(setq default-directory "~/")
(setq inhibit-startup-message t)       ;; 起動時の画面はいらない
(setq initial-scratch-message "")      ;; scratch message の削除
;;(set-scroll-bar-mode 'right)           ;;スクロールバーを右側に
(set-scroll-bar-mode 'nil)           ;;スクロールバーを右側に
(auto-compression-mode t)              ;;圧縮されたファイルも編集＆日本語infoの文字化け防止
(fset 'yes-or-no-p 'y-or-n-p)          ;;"yes or no"を"y or n"にする
(setq mouse-drag-copy-region t) ;; マウスコピー可にする
(setq x-select-enable-clipboard t)
(setq-default cursor-in-non-selected-windows t) ;; 非アクティブウィンドウのカーソル表示
(setq w32-ime-buffer-switch-p nil) ;; バッファ切り替え時の状態引継ぎ設定
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq recenter-positions '(middle top bottom))

;; 変更ファイルのバックアップ
(setq make-backup-files nil)

;; 変更ファイルの番号つきバックアップ
(setq version-control nil)

;; 編集中ファイルのバックアップ
(setq auto-save-list-file-name nil)
(setq auto-save-list-file-prefix nil)

;;保存時実行属性付与
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

(load "saveplace")                     ;;前回編集していた場所を記憶
(setq-default save-place t)

(setq delete-auto-save-files t)

;; (require 'session)
;; (setq session-initialize '(de-saveplace session keys menus places)
;;       session-globals-include '((kill-ring 50)
;;                                   ;;(session-file-alist 500 t)
;;                                   (file-name-history 10000)
;;                                   search-ring regexp-search-ring))
;;   ;; これがないと file-name-history に500個保存する前に max-string に達する
;;(setq session-globals-max-string 100000000)
;; ;;   ;; デフォルトでは30!
;;   (setq history-length t)
;; (setq session-undo-check -1)
;; (add-hook 'after-init-hook 'session-initialize)
;;(add-hook 'after-save-hook 'session-save-session)
;;(setq my-timer-for-session-save-session (run-at-time t 30 'session-save-session))
(require 'recentf) ;;; 最近使ったファイル」を（メニューに）表示する
(setq recentf-max-saved-items 2000)
(setq recentf-exclude '("~/.emacs.d/.recentf"))
;;(setq recentf-auto-cleanup 30)
(recentf-mode 1)
(use-package recentf-ext) ;;; 最近使ったファイル」を（メニューに）表示する

;; (require 'auto-save-buffers-enhanced)
;; (setq auto-save-buffers-enhanced-interval 1) ; 指定のアイドル秒で保存
;; (auto-save-buffers-enhanced t)

(use-package psession)
(psession-mode 1)

(use-package super-save)
(setq super-save-auto-save-when-idle t
        super-save-idle-duration 10)
(super-save-mode +1)

(use-package bm)
(defun bm-find-files-in-repository ()
  (interactive)
  (cl-loop for (key . _) in bm-repository
           when (file-exists-p key)
           do (find-file-noselect key)))
(defun bm-repository-load-and-open ()
  (interactive)
  (bm-repository-load)
  (bm-find-files-in-repository))

(setq bm-repository-file "~/.emacs.d/.bm-repository")
(setq-default bm-buffer-persistence t)
(setq bm-restore-repository-on-load t)
(add-hook 'after-init-hook 'bm-repository-load-and-open)

(defun bm-buffer-restore-safe ()
  (ignore-errors (bm-buffer-restore)))
(add-hook 'find-file-hooks 'bm-buffer-restore-safe)
(add-hook 'kill-buffer-hook 'bm-buffer-save)

(defun bm-save-to-repository ()
  (interactive)
  (unless noninteractive
    (bm-buffer-save-all)
    (bm-repository-save)))

(add-hook 'kill-emacs-hook 'bm-save-to-repository)
(run-with-idle-timer 30 t 'bm-save-to-repository)
(add-hook 'after-revert-hook 'bm-buffer-restore)
(add-hook 'vc-before-checkin-hook 'bm-buffer-save)
(add-hook 'before-save-hook 'bm-buffer-save)


(add-hook 'kill-emacs-hook '(lambda nil
                              (bm-save-to-repository)
                              (recentf-save-list)
                              ;;(session-save-session)
                              ;;(win-save-all-configurations)
                              ))

(run-with-idle-timer 10 t 'recentf-save-list)

;;Idle Auto Save Buffers
;; (setq win-auto-all-save-timer
;;       (run-with-idle-timer 10 t 'win-save-all-configurations))

;; (setq recentf-auto-save-timer
;;       (run-with-idle-timer 10 t 'recentf-save-list))
;; (setq session-auto-save-timer
;;       (run-with-idle-timer 10 t 'session-save-session))

;; (setq psession-auto-save-timer
;;       (run-with-idle-timer 10 t 'psession-save-winconf))

;; (setq bm-buffer-auto-save-timer
;;       (run-with-idle-timer 10 t 'bm-buffer-save-all))
;; (setq bm-repository-auto-save-timer
;;       (run-with-idle-timer 10 t 'bm-repository-save))
