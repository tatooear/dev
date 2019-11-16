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
                (cursor-color     . "yellow")
                ;;(font . "Inconsolata-15")
                ) default-frame-alist) )
(setq initial-frame-alist default-frame-alist)

(set-face-background 'cursor "yellow")
(set-face-foreground 'mode-line-highlight "bule" )
(set-face-foreground 'mode-line-emphasis "yellow" )

(set-face-foreground 'font-lock-constant-face "#87d7af" )
(set-face-foreground 'font-lock-variable-name-face "#ffff87" )
(set-face-foreground 'font-lock-keyword-face "#5fafd7" )
(set-face-foreground 'font-lock-string-face "LightSalmon" )
(set-face-foreground 'font-lock-comment-face "chocolate1" )
(set-face-foreground 'font-lock-comment-delimiter-face "chocolate1" )

(set-face-background 'hl-line "dark slate gray")
(set-face-background 'region "blue" )
(set-face-foreground 'bm-face nil )
(set-face-background 'bm-face "dim gray" )
(set-face-foreground 'bm-persistent-face nil )
(set-face-background 'bm-persistent-face "dim gray" )

(set-face-attribute 'tabbar-default nil :height 1.0)
(set-face-background 'tabbar-selected "dark red" )
(set-face-foreground 'tabbar-selected "white" )
(set-face-background 'tabbar-default "#afd7ff" )
(set-face-foreground 'tabbar-default "#005f87" )
(set-face-foreground 'tabbar-modified "dark red" )

(set-face-foreground 'web-mode-html-tag-face "LightSkyBlue")
(set-face-foreground 'web-mode-html-tag-bracket-face "white")
(set-face-foreground 'web-mode-html-attr-name-face "LightGoldenrod")
(set-face-foreground 'web-mode-html-attr-value-face "LightSalmon")
(set-face-foreground 'web-mode-html-attr-equal-face "white")
(set-face-foreground 'web-mode-function-call-face "pale green")
(set-face-foreground 'web-mode-comment-face "chocolate1")
(set-face-foreground 'web-mode-block-comment-face "chocolate1")
(set-face-foreground 'web-mode-param-name-face "#5fafd7" )

