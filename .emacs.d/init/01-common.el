(use-package diminish)

(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8-unix) ;; デフォルトの文字コード
(prefer-coding-system 'utf-8-unix) ;; テキストファイル／新規バッファの文字コード
(set-file-name-coding-system 'utf-8-unix) ;; ファイル名の文字コード
(set-keyboard-coding-system 'utf-8-unix) ;; キーボード入力の文字コード

(use-package server
  :ensure nil
  :hook (after-init . server-mode))

(setq-default indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")

(show-paren-mode t)
(transient-mark-mode 1)                ;;選択範囲に色を付ける
(setq highlight-nonselected-windows t) ;;バッファを切り替えても色はついたままの状態にする

(setq inhibit-startup-message t)       ;; 起動時の画面はいらない
(setq initial-scratch-message "")      ;; scratch message の削除

(set-scroll-bar-mode 'nil)           ;;スクロールバーを右側に
(auto-compression-mode t)              ;;圧縮されたファイルも編集＆日本語infoの文字化け防止
(fset 'yes-or-no-p 'y-or-n-p)          ;;"yes or no"を"y or n"にする
(setq mouse-drag-copy-region t) ;; マウスコピー可にする
(setq x-select-enable-clipboard t)
(setq-default cursor-in-non-selected-windows t) ;; 非アクティブウィンドウのカーソル表示
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq recenter-positions '(middle top bottom))

;; 変更ファイルのバックアップ
(setq make-backup-files nil)

;; 変更ファイルの番号つきバックアップ
(setq version-control nil)

;; 編集中ファイルのバックアップ
(setq auto-save-list-file-name nil)
(setq auto-save-list-file-prefix nil)

(load "saveplace")                     ;;前回編集していた場所を記憶
(setq-default save-place t)

(setq delete-auto-save-files t)

(use-package psession :ensure t)
(psession-mode 1)

(use-package super-save :ensure t)
(setq super-save-auto-save-when-idle t
        super-save-idle-duration 10)
(super-save-mode +1)

(use-package auto-async-byte-compile :ensure t)
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)


