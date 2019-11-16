(windmove-default-keybindings) ;;ウィンドウ間を簡単に移動

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

(use-package persp-mode
  :disabled
  :diminish
  :defines ivy-sort-functions-alist
  :commands (get-current-persp persp-contain-buffer-p persp-add persp-by-name-and-exists)
  :hook ((after-init . persp-mode)
         (emacs-startup . toggle-frame-maximized))
  :custom
  (persp-keymap-prefix (kbd "C-x p"))
  (persp-nil-name "default")
  (persp-set-last-persp-for-new-frames nil)
  (persp-auto-resume-time 0)
  :config
  ;; NOTE: Redefine `persp-add-new' to address.
  ;; Issue: Unable to create/handle persp-mode
  ;; https://github.com/Bad-ptr/persp-mode.el/issues/96
  ;; https://github.com/Bad-ptr/persp-mode-projectile-bridge.el/issues/4
  ;; https://emacs-china.org/t/topic/6416/7
  (defun* persp-add-new (name &optional (phash *persp-hash*))
    "Create a new perspective with the given `NAME'. Add it to `PHASH'.
  Return the created perspective."
    (interactive "sA name for the new perspective: ")
    (if (and name (not (equal "" name)))
        (destructuring-bind (e . p)
            (persp-by-name-and-exists name phash)
          (if e p
            (setq p (if (equal persp-nil-name name)
                        nil (make-persp :name name)))
            (persp-add p phash)
            (run-hook-with-args 'persp-created-functions p phash)
            p))
      (message "[persp-mode] Error: Can't create a perspective with empty name.")
      nil))

  ;; Ignore temporary buffers
  (add-hook 'persp-common-buffer-filter-functions
            (lambda (b) (or (string-prefix-p "*" (buffer-name b))
                       (string-prefix-p "magit" (buffer-name b)))))

  ;; Integrate IVY
  (with-eval-after-load "ivy"
    (add-hook 'ivy-ignore-buffers
              #'(lambda (b)
                  (when persp-mode
                    (let ((persp (get-current-persp)))
                      (if persp
                          (not (persp-contain-buffer-p b persp))
                        nil)))))

    (setq ivy-sort-functions-alist
          (append ivy-sort-functions-alist
                  '((persp-kill-buffer   . nil)
                    (persp-remove-buffer . nil)
                    (persp-add-buffer    . nil)
                    (persp-switch        . nil)
                    (persp-window-switch . nil)
                    (persp-frame-switch  . nil))))))

(use-package popwin)
