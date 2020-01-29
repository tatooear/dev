;;; search-setting.el ---

;; ==================================
;; isearch
;; ==================================
(use-package ace-isearch)
(global-ace-isearch-mode t)
(setq ace-isearch-input-idle-jump-delay 2.5)
(setq ace-isearch-input-idle-func-delay 2.5)
(setq ace-isearch-input-length 2)

(use-package ace-pinyin)
(ace-pinyin-global-mode +1)

(use-package minibuf-isearch)

;; history から重複したのを消す
(defun minibuffer-delete-duplicate ()
  (let (list)
    (dolist (elt (symbol-value minibuffer-history-variable))
      (unless (member elt list)
        (push elt list)))
    (set minibuffer-history-variable (nreverse list))))

(add-hook 'minibuffer-setup-hook 'minibuffer-delete-duplicate)

;; ==================================
;; grep
;; ==================================
(use-package wgrep)

(custom-set-variables
 '(ag-highlight-search t)  ; 検索結果の中の検索語をハイライトする
 '(ag-reuse-window 'nil)   ; 現在のウィンドウを検索結果表示に使う
 '(ag-reuse-buffers 'nil)  ; 現在のバッファを検索結果表示に使う
 )

;; ==================================
;; moccur
;; ==================================
(use-package color-moccur)
(setq moccur-split-word t) ;; コメントだけを検索できるように設定
(setq moccur-kill-moccur-buffer t) ;; 検索結果を削除する
(setq moccur-kill-buffer-after-goto nil) ;; カーソル付近の単語をデフォルトの検索文字列とする
  ;; ディレクトリ検索のとき除外するファイル
(add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
(add-to-list 'dmoccur-exclusion-mask "^#.+#$")

(use-package moccur-edit)
;; migemo 利用できる環境であれば migemo を使う
(when (and (executable-find "cmigemo")
           (require 'migemo nil t))
  (setq moccur-use-migemo t)
  (setq moccur-edit-highlight-edited-text t)) ;; 各バッファで変更が適用された行に色をつける

;; ==================================
;; all
;; ==================================
(use-package all-ext)

;; ==================================
;; regexp
;; ==================================
;; (require 'foreign-regexp)

;; (custom-set-variables
;;  ;; 正規表現、perlかrubyを選択
;;  '(foreign-regexp/regexp-type 'perl) ;; Choose by your preference.
;;  '(reb-re-syntax 'foreign-regexp)) ;; Tell re-builder to use foreign regexp.

;; ==================================
;; imenu
;; ==================================

(require 'imenu) ;; 関数一覧
(setq imenu-auto-rescan t)
(defcustom imenu-modes
  '(emacs-lisp-mode c-mode c++-mode makefile-mode cperl-mode java-mode php-mode html-mode mmm-mode javascript-mode nxml-mode org-mode web-mode)
  "List of major modes for which Imenu mode should be used."
  :group 'imenu
  :type '(choice (const :tag "All modes" t)
                 (repeat (symbol :tag "Major mode"))))

(defun my-imenu-ff-hook ()
  "File find hook for Imenu mode."
  (if (member major-mode imenu-modes)
      (imenu-add-to-menubar "imenu")))
(add-hook 'find-file-hooks 'my-imenu-ff-hook t)

(defadvice imenu--completion-buffer
  (around mcomplete activate preactivate)
  "Support for mcomplete-mode."
  (require 'mcomplete)
  (let ((imenu-always-use-completion-buffer-p 'never)
        (mode mcomplete-mode)
        ;; the order of completion methods
        (mcomplete-default-method-set '(mcomplete-substr-method
                                        mcomplete-prefix-method))
        ;; when to display completion candidates in the minibuffer
        (mcomplete-default-exhibit-start-chars 0)
        (completion-ignore-case t))
    ;; display *Completions* buffer on entering the minibuffer
    (setq unread-command-events
          (cons (funcall (if (fboundp 'character-to-event)
                             'character-to-event
                           'identity)
                         ?\?)
                unread-command-events))
    (turn-on-mcomplete-mode)
    (unwind-protect
        ad-do-it
      (unless mode
        (turn-off-mcomplete-mode)))))

(use-package imenus)

;;; エラー対策
(defun imenu-find-default--or-current-symbol (&rest them)
  (condition-case nil
      (apply them)
    (error (thing-at-point 'symbol))))
(advice-add 'imenu-find-default :around 'imenu-find-default--or-current-symbol)
;;; なぜか現在のシンボルを取ってくれないから
(defun imenus-exit-minibuffer ()
  (exit-minibuffer))

;;; M-oでのmulti-occurをシンボル正規表現にするよう改良
(push '(occur . imenus-ido-multi-occur) imenus-actions)
(defun imenus-ido-multi-occur (buffers input)
  (multi-occur buffers
               (format "\\_<%s\\_>"
                       (regexp-quote (replace-regexp-in-string "^.*|" "" input)))))

;;; C-M-sで関数呼び出しをhelm-multi-swoopできるようにした
(push '(helm-multi-swoop . imenus-helm-multi-swoop) imenus-actions)
(defun imenus-helm-multi-swoop (buffers input)
  (helm-multi-swoop (replace-regexp-in-string "^.*|" "" input)
                    (mapcar 'buffer-name buffers)))
(define-key imenus-minibuffer-map (kbd "C-M-l") 'imenus-exit-to-helm-multi-swoop)
(defun imenus-exit-to-helm-multi-swoop ()
  "Exit from imenu prompt; start `helm-multi-swoop' with the current input."
  (interactive)
  (setq imenus-exit-status 'helm-multi-swoop)
  (imenus-exit-minibuffer))

(use-package dumb-jump)
(setq dumb-jump-selector 'helm)
(setq dumb-jump-force-searcher 'rg)

(require 'point-history)
(point-history-mode t)
(setq point-history-show-buffer-height 10)

;; ==================================
;; translate
;; ==================================
(use-package google-translate)
(require 'google-translate-default-ui)

(defvar google-translate-english-chars "[:ascii:]"
  "これらの文字が含まれているときは英語とみなす")
(defun google-translate-enja-or-jaen (&optional string)
  "regionか現在位置の単語を翻訳する。C-u付きでquery指定も可能"
  (interactive)
  (setq string
        (cond ((stringp string) string)
              (current-prefix-arg
               (read-string "Google Translate: "))
              ((use-region-p)
               (buffer-substring (region-beginning) (region-end)))
              (t
               (thing-at-point 'word))))
  (let* ((asciip (string-match
                  (format "\\`[%s]+\\'" google-translate-english-chars)
                  string)))
    (run-at-time 0.1 nil 'deactivate-mark)
    (google-translate-translate
     (if asciip "en" "ja")
     (if asciip "ja" "en")
     string)))

(push '("\*Google Translate\*" :height 0.5 :stick t) popwin:special-display-config)

(use-package google-this)
(with-eval-after-load "google-this"
    (defun my:google-this ()
      "検索確認をスキップして直接検索実行"
      (interactive)
      (google-this (current-word) t)))

;; (use-package selected)
;; (selected-global-mode 1)
;; (define-key selected-keymap (kbd "g") #'my:google-this)
