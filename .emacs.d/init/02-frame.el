(use-package moe-theme)
(moe-dark)
(powerline-moe-theme)
;;(setq moe-theme-mode-line-color 'green)

(setq default-frame-alist
      (append '((width                . 150)  ; フレーム幅
                (height               . 38 ) ; フレーム高
             ;; (left                 . 70 ) ; 配置左位置
             ;; (top                  . 28 ) ; 配置上位置
                (line-spacing         . 0  ) ; 文字間隔
                (left-fringe          . 10 ) ; 左フリンジ幅
                (right-fringe         . 0 ) ; 右フリンジ幅
                (menu-bar-lines       . 1  ) ; メニューバー
                (cursor-type          . box) ; カーソル種別
                (alpha                . 85) ;  透明度
                (foreground-color . "white");; 文字が白
                (background-color . "black") ;; 背景は黒
                (border-color     . "black")
                (cursor-color     . "yellow")
                ;;(font . "Inconsolata-15")
                ) default-frame-alist) )
(setq initial-frame-alist default-frame-alist)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mode line
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(line-number-mode t)
(column-number-mode t)
;; 選択範囲の情報表示
(defun count-lines-and-chars ()
  (if mark-active
      (format "[%3d:%4d]"
              (count-lines (region-beginning) (region-end))
              (- (region-end) (region-beginning)))
    ""))
;; (add-to-list 'default-mode-line-format
;;              '(:eval (count-lines-and-chars)))

;;(setq-default header-line-format '("%f"))
;;(setq-default header-line-format '("%b : L%l C%c : %f"))
(setq frame-title-format '("%f"))
;;(setq icon-title-format "%b - %F")

(set-default 'mode-line-buffer-identification
             '(buffer-file-name ("%f")))
             ;;'(buffer-file-name ("%b")))

(defvar mode-line-cleaner-alist
  '( ;; For minor-mode, first char is 'space'
    (yas-minor-mode . " YS")
    (undo-tree-mode . " UT")
    (flycheck-mode . " FC")
    (abbrev-mode . "")
    (php-completion-mode . "")
    (gtags-mode . " GT")
    (emmet-mode . " EM")
    (git-gutter+-mode . " GG")
    (rainbow-mode . " RB")
    (helm-mode . "")
    (super-save-mode . "")
    (magit-mode . "Git")
    ;; Major modes
    (lisp-interaction-mode . "LI")
    (emacs-lisp-mode . "EL")
    ))

(defun clean-mode-line ()
  (interactive)
  (loop for (mode . mode-str) in mode-line-cleaner-alist
        do
        (let ((old-mode-str (cdr (assq mode minor-mode-alist))))
          (when old-mode-str
            (setcar old-mode-str mode-str))
          ;; major mode
          (when (eq mode major-mode)
            (setq mode-name mode-str)))))

(add-hook 'after-change-major-mode-hook 'clean-mode-line)

(defun my-copy-file-path ()
  "show the full path file name in the minibuffer and copy to kill ring."
  (interactive)
  (when buffer-file-name
    (kill-new (file-truename buffer-file-name))
    (message (buffer-file-name))))

(require 'sky-color-clock)
(sky-color-clock-initialize 35)
(setq sky-color-clock-enable-emoji-icon nil)
(setq sky-color-clock-format "%H:%M")
;; (add-to-list 'default-mode-line-format
;;              '(:eval (sky-color-clock)))

(defun powerline-my-theme ()
  "Setup the default mode-line."
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line-buffer-id (if active 'mode-line-buffer-id 'mode-line-buffer-id-inactive))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face0 (if active 'powerline-active0 'powerline-inactive0))
                          (face1 (if active 'powerline-active1 'powerline-inactive1))
                          (face2 (if active 'powerline-active2 'powerline-inactive2))
                          (separator-left (intern (format "powerline-%s-%s"
							  (powerline-current-separator)
                                                          (car powerline-default-separator-dir))))
                          (separator-right (intern (format "powerline-%s-%s"
                                                           (powerline-current-separator)
                                                           (cdr powerline-default-separator-dir))))
                          (lhs (list (powerline-raw "%*" face0 'l)
                                     (when powerline-display-buffer-size
                                       (powerline-buffer-size face0 'l))
                                     (when powerline-display-mule-info
                                       (powerline-raw mode-line-mule-info face0 'l))
                                     (powerline-buffer-id `(mode-line-buffer-id ,face0) 'l)
                                     (when (and (boundp 'which-func-mode) which-func-mode)
                                       (powerline-raw which-func-format face0 'l))
                                     (powerline-raw " " face0)
                                     (funcall separator-left face0 face1)
                                     (when (and (boundp 'erc-track-minor-mode) erc-track-minor-mode)
                                       (powerline-raw erc-modified-channels-object face1 'l))
                                     (powerline-major-mode face1 'l)
                                     (powerline-process face1)
                                     (powerline-minor-modes face1 'l)
                                     (powerline-narrow face1 'l)
                                     (powerline-raw " " face1)
                                     (funcall separator-left face1 face2)
                                     (powerline-vc face2 'r)
                                     (when (bound-and-true-p nyan-mode)
                                       (powerline-raw (list (nyan-create)) face2 'l))))
                          (rhs (list (powerline-raw global-mode-string face2 'r)
                                     (funcall separator-right face2 face1)
				     (unless window-system
				       (powerline-raw (char-to-string #xe0a1) face1 'l))
				     (powerline-raw "%4l" face1 'l)
				     (powerline-raw ":" face1 'l)
				     (powerline-raw "%3c" face1 'r)
                     (count-lines-and-chars)
				     (funcall separator-right face1 face0)
				     (powerline-raw " " face0)
				     (powerline-raw "%6p" face0 'r)
                     (sky-color-clock)
                     (when powerline-display-hud
                     (powerline-hud face0 face2))
                     (powerline-fill face0 0)
				     )))
		     (concat (powerline-render lhs)
			     (powerline-fill face2 (powerline-width rhs))
			     (powerline-render rhs)))))))


;;(require 'powerline)
(powerline-my-theme)

(use-package posframe)
