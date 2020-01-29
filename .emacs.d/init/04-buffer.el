;;; buffer-setting.el ---

(windmove-default-keybindings) ;;ウィンドウ間を簡単に移動
(iswitchb-mode 1)
(msb-mode 1)

;; elscreen
;; (setq elscreen-prefix-key (kbd "C-z"))
;; (elscreen-start)
;;(elscreen-persist-mode 1)
;; (setq elscreen-tab-display-kill-screen nil) ;;; タブの先頭に[X]を表示しない
;; (setq elscreen-tab-display-control nil) ;;; header-lineの先頭に[<->]を表示しない

;; window 分割形態を保存
;; (require 'windows)
;; (setq win:use-frame nil) ;; 新規にフレームを作らない
;;(win:startup-with-window)
;; (setq win:switch-prefix "\C-q")
;; (define-key global-map win:switch-prefix nil)
;; (define-key global-map "\C-q1" 'win-switch-to-window)
;; (define-key win:switch-map ";" 'win-switch-menu)
;;(setq revive:ignore-buffer-pattern "^ \\*")

;; タブを追加
(use-package tabbar)
(tabbar-mode)
(setq tabbar-buffer-groups-function nil) ;; グループ化しない

(defun my-tabbar-buffer-list ()
  (delq nil
        (mapcar #'(lambda (b)
                    (cond
                     ;; Always include the current buffer.
                     ((eq (current-buffer) b) b)
                     ((buffer-file-name b) b)
                     ((char-equal ?\  (aref (buffer-name b) 0)) nil)
		     ((equal "*scratch*" (buffer-name b)) b) ; *scratch*バッファは表示する
		     ((char-equal ?* (aref (buffer-name b) 0)) nil) ; それ以外の * で始まるバッファは表示しない
                     ((buffer-live-p b) b)))
                (buffer-list))))
(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)

(tabbar-mode (if window-system 1 -1))
(remove-hook 'kill-buffer-hook 'tabbar-buffer-kill-buffer-hook)

(defun switch-to-previous-buffer ()
  "直前のバッファと行き来する"
  (interactive)
  (switch-to-buffer nil))

(use-package popwin)
;;(setq special-display-function 'popwin:special-display-popup-window)
(setq display-buffer-function 'popwin:display-buffer)
(setq anything-samewindow nil)
;;(push '("*translated*" :height 50 :position bottom :noselect t) popwin:special-display-config)
;;(push '("*Incremental Grep*" :height 50 :position bottom) popwin:special-display-config)
;;(push '("*anything*" :height 20 :position bottom) popwin:special-display-config)
(push '(" *auto-async-byte-compile*" :height 10 :position bottom :noselect t) popwin:special-display-config)
(push '("*Compile-Log*" :height 5 :position bottom :noselect t) popwin:special-display-config)
(push '("*Completions*" :height 20 :position bottom) popwin:special-display-config)

;; 画面分割
(use-package rotate)

;; 特定のメジャーモードを選択する
(use-package quick-buffer-switch)
(setq qbs-prefix-key "C-j") ;プレフィクスキー、C-x C-cは潰していいよね
(qbs-init)

(qbs-add-predicates ;カスタマイズするときに囲む必要ある
 ;; M-x qbs-php-modeを定義
 (make-qbs:predicate
    :name 'php-mode   ;名前
    :shortcut "C-p"
    ;; enh-ruby-modeかruby-modeかつファイルバッファ
    :test '(and (memq major-mode '(php-mode web-mode))
                qbs:buffer-file-name)))

(qbs-add-predicates ;カスタマイズするときに囲む必要ある
 ;; M-x qbs-php-modeを定義
 (make-qbs:predicate
    :name 'html-mode   ;名前
    :shortcut "C-j"
    :test '(and (memq major-mode '(html-mode nxml-mode web-mode css-mode js-mode javascript-mode))
                qbs:buffer-file-name)))

(qbs-add-predicates ;カスタマイズするときに囲む必要ある
 ;; M-x qbs-php-modeを定義
 (make-qbs:predicate
    :name 'text-mode   ;名前
    :shortcut "C-t"
    :test '(and (memq major-mode '(text-mode))
                qbs:buffer-file-name)))

;; (require 'perspective)
;; (persp-mode 1)
;; ;;; モードラインに現在のみのperspective名を表示させるように再定義
;; (defun persp-update-modestring ()
;;   (when persp-show-modestring
;;     (setq persp-modestring
;;           (list (nth 0 persp-modestring-dividers)
;;                 (persp-name persp-curr)
;;                 (nth 1 persp-modestring-dividers)))))

;; (defun persp-register-buffers-on-create ()
;;   (interactive)
;;   (dolist (bufname (condition-case _
;;                        (helm-comp-read
;;                         "Buffers: "
;;                         (mapcar 'buffer-name (buffer-list))
;;                         :must-match t
;;                         :marked-candidates t)
;;                      (quit nil)))
;;     (persp-add-buffer (get-buffer bufname))))
;; (add-hook 'persp-created-hook 'persp-register-buffers-on-create)
