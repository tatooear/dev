;; (require 'dired+)

;; (require 'wdired) ;;dired バッファを編集
;; (setq wdired-allow-to-change-permissions t)

;; (require 'direx)

;; (require 'dired-filetype-face) ;;拡張子ベースで色を付ける

;; ;; direx:direx-modeのバッファをウィンドウ左辺に幅25でポップアップ
;; ;; :dedicatedにtを指定することで、direxウィンドウ内でのバッファの切り替えが
;; ;; ポップアップ前のウィンドウに移譲される
;; (push '(direx:direx-mode :position left :width 25 :dedicated t)
;;       popwin:special-display-config)

;; (setq direx:leaf-icon "  "
;;       direx:open-icon "▼"
;;       direx:closed-icon "▶")

;; (require 'dired-details)
;; (dired-details-install)
;; (setq dired-details-hidden-string "")
;; (setq dired-details-hide-link-targets nil)

;; (require 'dired-subtree)

;; ;;; dired-subtreeをdired-detailsに対応させる
;; (defun dired-subtree-after-insert-hook--dired-details ()
;;   (dired-details-delete-overlays)
;;   (dired-details-activate))
;; (add-hook 'dired-subtree-after-insert-hook
;;           'dired-subtree-after-insert-hook--dired-details)

;; (defadvice find-dired-sentinel (after dired-details (proc state) activate)
;;   "find-diredでもdired-detailsを使えるようにする"
;;   (ignore-errors
;;     (with-current-buffer (process-buffer proc)
;;       (dired-details-activate))))

;;フォルダを開く時, 新しいバッファを作成しない
(defvar my-dired-before-buffer nil)
(defadvice dired-advertised-find-file
  (before kill-dired-buffer activate)
  (setq my-dired-before-buffer (current-buffer)))

(defadvice dired-advertised-find-file
  (after kill-dired-buffer-after activate)
  (if (eq major-mode 'dired-mode)
      (kill-buffer my-dired-before-buffer)))

(defadvice dired-up-directory
  (before kill-up-dired-buffer activate)
  (setq my-dired-before-buffer (current-buffer)))

(defadvice dired-up-directory
  (after kill-up-dired-buffer-after activate)
  (if (eq major-mode 'dired-mode)
      (kill-buffer my-dired-before-buffer)))

(defun dired-find-alternate-file ()
  "In dired, visit this file or directory instead of the dired buffer."
  (interactive)
  (set-buffer-modified-p nil)
  (find-alternate-file (dired-get-filename)))
(put 'dired-find-alternate-file 'disabled nil)
