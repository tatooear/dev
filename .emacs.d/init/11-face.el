;;; face-setting.el ---
(if window-system
    (progn
      (set-background-color "#000000")
      (set-foreground-color "#ffffff")))

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
                (cursor-colqor     . "yellow")
                ;;(font . "Inconsolata-15")
                ) default-frame-alist) )
(setq initial-frame-alist default-frame-alist)

(defun font-lock-user-keywords (mode &optional keywords)
  "Add user highlighting to KEYWORDS to MODE.
See `font-lock-add-keywords' and `font-lock-defaults'."
  (unless mode
    (error "mode should be non-nil "))
  (font-lock-remove-keywords mode (get mode 'font-lock-user-keywords))
  (font-lock-add-keywords mode keywords)
  (put mode 'font-lock-user-keywords keywords))

(font-lock-user-keywords
 'php-mode
 '((";" . 'mode-line-emphasis)
   ("\\," . 'rainbow-delimiters-depth-2-face)
   ("\\." . 'rainbow-delimiters-depth-2-face)))

(set-face-background 'cursor "yellow")
;;モード行の背景, 文字の色を変更
;; (set-face-background 'mode-line "grey10")
;; (set-face-foreground 'mode-line "green")
;;(set-face-foreground 'mode-line-buffer-id "red" )
(set-face-foreground 'mode-line-highlight "bule" )
(set-face-foreground 'mode-line-emphasis "yellow" )
;;(set-face-foreground 'mode-line-buffer-id "#005f87" )

(set-face-foreground 'font-lock-constant-face "#87d7af" )
(set-face-foreground 'font-lock-variable-name-face "#ffff87" )
(set-face-foreground 'font-lock-keyword-face "#5fafd7" )
(set-face-foreground 'font-lock-string-face "LightSalmon" )
(set-face-foreground 'font-lock-comment-face "chocolate1" )
(set-face-foreground 'font-lock-comment-delimiter-face "chocolate1" )

;;(set-face-background 'highlight "grey10")
;;(set-face-foreground 'highlight "red")
(set-face-background 'hl-line "dark slate gray")
;;(set-face-background 'col-highlight "dark slate gray")
;;(set-face-foreground 'hl-line "white")
(set-face-background 'region "blue" )
(set-face-foreground 'region nil )
(set-face-background 'sense-region-face "blue" )
(set-face-foreground 'sense-region-face nil )
(set-face-foreground 'bm-face nil )
(set-face-background 'bm-face "dim gray" )
(set-face-foreground 'bm-persistent-face nil )
(set-face-background 'bm-persistent-face "dim gray" )
(set-face-bold-p 'moccur-face nil )
(set-face-foreground 'moccur-face nil )
(set-face-background 'moccur-face "royal blue" )
(set-face-background 'moccur-edit-face "dark red" )
;;(set-face-foreground 'flymake-errline nil )
;;(set-face-background 'flymake-errline "red4")
;;(set-face-foreground 'flymake-warnline nil )
;;(set-face-background 'flymake-warnline "khaki4")
(set-face-foreground 'linum "green" )
(set-face-background 'linum "black" )
;; (set-face-foreground 'linum-highlight-face "green" )
;; (set-face-background 'linum-highlight-face "dark slate gray" )
(set-face-bold-p 'linum t )
;;(set-face-bold-p 'linum-highlight-face t )
;; (set-face-bold-p 'tabbar-selected t )

(set-face-attribute 'tabbar-default nil :height 1.0)
;; (set-face-attribute ; アクティブなタブ
;;   'tabbar-selected nil
;;    :background "black"
;;    :foreground "white"
;;    :weight 'bold
;;    :box nil)
;; (set-face-attribute ; 非アクティブなタブ
;;   'tabbar-unselected nil
;;    :background "white"
;;    :foreground "black"
;;    :box nil)

(set-face-background 'tabbar-selected "dark red" )
(set-face-foreground 'tabbar-selected "white" )
(set-face-background 'tabbar-default "#afd7ff" )
(set-face-foreground 'tabbar-default "#005f87" )
(set-face-foreground 'tabbar-modified "dark red" )
;; (set-face-foreground 'anything-visible-mark nil )
;; (set-face-background 'anything-visible-mark "dark slate blue")
(set-face-background 'jaunte-hint-face "gray10")
(set-face-foreground 'jaunte-hint-face "red")
(set-face-background 'jaunte-hint-face2 "gray30")
(set-face-foreground 'jaunte-hint-face2 "cyan")
;; (set-face-foreground 'dired-header "yellow")

;; (set-face-foreground 'org-date "white")
;; (set-face-underline 'org-date nil )
;; (set-face-foreground 'org-link "DarkTurquoise")
;; (set-face-underline 'org-link nil )

(set-face-foreground 'ahs-plugin-defalt-face nil )
(set-face-background 'ahs-plugin-defalt-face "blue")

;; (set-face-underline-p 'helm-action nil)
;; (set-face-underline-p 'helm-selection nil)
;; (set-face-underline-p 'helm-selection-line nil)
;; (set-face-underline-p 'helm-source-header nil)
;; (set-face-background 'helm-selection "DarkGreen")

(set-face-background 'helm-css-scss-target-line-face "#005f87")
(set-face-foreground 'helm-css-scss-target-line-face nil )
;; (set-face-background 'helm-css-scss-selector-depth-face-1 nil)
;; (set-face-foreground 'helm-css-scss-selector-depth-face-1 nil)

(set-face-foreground 'web-mode-html-tag-face "LightSkyBlue")
(set-face-foreground 'web-mode-html-tag-bracket-face "white")
(set-face-foreground 'web-mode-html-attr-name-face "LightGoldenrod")
(set-face-foreground 'web-mode-html-attr-value-face "LightSalmon")
(set-face-foreground 'web-mode-html-attr-equal-face "white")
(set-face-foreground 'web-mode-function-call-face "pale green")
(set-face-foreground 'web-mode-comment-face "chocolate1")
(set-face-foreground 'web-mode-block-comment-face "chocolate1")
(set-face-foreground 'web-mode-param-name-face "#5fafd7" )

(set-face-foreground 'whitespace-trailing "red" )
(set-face-background 'whitespace-trailing nil )
(set-face-foreground 'whitespace-empty "yellow" )
(set-face-background 'whitespace-empty nil )

;;(set-face-attribute 'whitespace-trailing nil :foreground "red" :background nil :underline t)
(set-face-attribute 'whitespace-tab nil :foreground "gray20" :background "gray20" :underline nil)
(set-face-attribute 'whitespace-space nil :foreground "LightBlue" :background "LightBlue" :underline nil)
;;(set-face-attribute 'whitespace-empty nil :foreground "yellow" :background nil :underline t)

;; (set-face-foreground 'ediff-current-diff-A nil )
;; (set-face-background 'ediff-current-diff-A "dark slate blue")
;; (set-face-foreground 'ediff-current-diff-B nil )
;; (set-face-background 'ediff-current-diff-B "dark slate blue")
;; (set-face-foreground 'ediff-fine-diff-A nil )
;; (set-face-background 'ediff-fine-diff-A "red4")
;; (set-face-foreground 'ediff-fine-diff-B nil )
;; (set-face-background 'ediff-fine-diff-B "navy")
;; (set-face-foreground 'ediff-even-diff-A nil )
;; (set-face-background 'ediff-even-diff-A "gray20")
;; (set-face-foreground 'ediff-even-diff-Ancestor nil )
;; (set-face-background 'ediff-even-diff-Ancestor "gray20")
;; (set-face-foreground 'ediff-even-diff-B nil )
;; (set-face-background 'ediff-even-diff-B "gray20")
;; (set-face-foreground 'ediff-odd-diff-A nil )
;; (set-face-background 'ediff-odd-diff-A "gray30")
;; (set-face-foreground 'ediff-odd-diff-B nil )
;; (set-face-background 'ediff-odd-diff-B "gray30")

;; (set-face-foreground 'rainbow-delimiters-depth-1-face "white")
;; (set-face-foreground 'rainbow-delimiters-depth-2-face "red")
;; (set-face-foreground 'rainbow-delimiters-depth-3-face "DodgerBlue")
;; (set-face-foreground 'rainbow-delimiters-depth-4-face "HotPink")
;; (set-face-foreground 'rainbow-delimiters-depth-5-face "limegreen")
;; (set-face-foreground 'rainbow-delimiters-depth-6-face "purple")
;; (set-face-foreground 'rainbow-delimiters-depth-7-face "CornflowerBlue")
;; (set-face-foreground 'rainbow-delimiters-depth-8-face "magenta")
;; (set-face-foreground 'rainbow-delimiters-depth-9-face "OrangeRed")

;; (set-face-foreground 'highlight-changes "white")
;; (set-face-background 'highlight-changes "red")
;; (set-face-background 'highlight-changes-1 "red1")
;; (set-face-foreground 'highlight-changes-1 "white")
;; (set-face-background 'highlight-changes-2 "red2")
;; (set-face-foreground 'highlight-changes-2 "white")
;; (set-face-background 'highlight-changes-3 "red3")
;; (set-face-foreground 'highlight-changes-3 "white")
;; (set-face-background 'highlight-changes-4 "red4")
;; (set-face-foreground 'highlight-changes-4 "white")
;; (set-face-background 'highlight-changes-5 "DeepPink4")
;; (set-face-foreground 'highlight-changes-5 "white")
;; (set-face-background 'highlight-changes-6 "HotPink4")
;; (set-face-foreground 'highlight-changes-6 "white")

;;(setq ibus-cursor-color '("red" "yellow" "limegreen")) ;; IBusの状態によってカーソル色を変化させる


;;モードライン
;; (require 'mode-line-color)
;; (mode-line-color-mode)

;; (set-face-foreground 'dired-filetype-source"DarkSeaGreen")
;; (set-face-foreground 'dired-filetype-omit "gray" )
;; (set-face-foreground 'dired-filetype-compress "firebrick" )
;; (set-face-foreground 'dired-filetype-document "white" )
