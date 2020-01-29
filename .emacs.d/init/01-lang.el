;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 文字コード
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package cp5022x)
(define-coding-system-alias 'iso-2022-jp 'cp50220)
(define-coding-system-alias 'euc-jp 'cp51932)
(define-coding-system-alias 'shift_jis 'cp932)

;; decode-translation-table の設定
(coding-system-put 'euc-jp :decode-translation-table
     (get 'japanese-ucs-jis-to-cp932-map 'translation-table))
(coding-system-put 'iso-2022-jp :decode-translation-table
     (get 'japanese-ucs-jis-to-cp932-map 'translation-table))
(coding-system-put 'utf-8 :decode-translation-table
     (get 'japanese-ucs-jis-to-cp932-map 'translation-table))

;; encode-translation-table の設定
(coding-system-put 'euc-jp :encode-translation-table
     (get 'japanese-ucs-cp932-to-jis-map 'translation-table))
(coding-system-put 'iso-2022-jp :encode-translation-table
     (get 'japanese-ucs-cp932-to-jis-map 'translation-table))
(coding-system-put 'cp932 :encode-translation-table
     (get 'japanese-ucs-jis-to-cp932-map 'translation-table))
(coding-system-put 'utf-8 :encode-translation-table
     (get 'japanese-ucs-jis-to-cp932-map 'translation-table))

;; charset と coding-system の優先度設定
(set-charset-priority 'ascii 'japanese-jisx0208 'latin-jisx0201
          'katakana-jisx0201 'iso-8859-1 'cp1252 'unicode)
(set-coding-system-priority 'utf-8 'euc-jp 'iso-2022-jp 'cp932)

;; East Asian Ambiguous
(defun set-east-asian-ambiguous-width (width)
  (while (char-table-parent char-width-table)
    (setq char-width-table (char-table-parent char-width-table)))
  (let ((table (make-char-table nil)))
    (dolist (range
         '(#x00A1 #x00A4 (#x00A7 . #x00A8) #x00AA (#x00AD . #x00AE)
          (#x00B0 . #x00B4) (#x00B6 . #x00BA) (#x00BC . #x00BF)
          #x00C6 #x00D0 (#x00D7 . #x00D8) (#x00DE . #x00E1) #x00E6
          (#x00E8 . #x00EA) (#x00EC . #x00ED) #x00F0
          (#x00F2 . #x00F3) (#x00F7 . #x00FA) #x00FC #x00FE
          #x0101 #x0111 #x0113 #x011B (#x0126 . #x0127) #x012B
          (#x0131 . #x0133) #x0138 (#x013F . #x0142) #x0144
          (#x0148 . #x014B) #x014D (#x0152 . #x0153)
          (#x0166 . #x0167) #x016B #x01CE #x01D0 #x01D2 #x01D4
          #x01D6 #x01D8 #x01DA #x01DC #x0251 #x0261 #x02C4 #x02C7
          (#x02C9 . #x02CB) #x02CD #x02D0 (#x02D8 . #x02DB) #x02DD
          #x02DF (#x0300 . #x036F) (#x0391 . #x03A9)
          (#x03B1 . #x03C1) (#x03C3 . #x03C9) #x0401
          (#x0410 . #x044F) #x0451 #x2010 (#x2013 . #x2016)
          (#x2018 . #x2019) (#x201C . #x201D) (#x2020 . #x2022)
          (#x2024 . #x2027) #x2030 (#x2032 . #x2033) #x2035 #x203B
          #x203E #x2074 #x207F (#x2081 . #x2084) #x20AC #x2103
          #x2105 #x2109 #x2113 #x2116 (#x2121 . #x2122) #x2126
          #x212B (#x2153 . #x2154) (#x215B . #x215E)
          (#x2160 . #x216B) (#x2170 . #x2179) (#x2190 . #x2199)
          (#x21B8 . #x21B9) #x21D2 #x21D4 #x21E7 #x2200
          (#x2202 . #x2203) (#x2207 . #x2208) #x220B #x220F #x2211
          #x2215 #x221A (#x221D . #x2220) #x2223 #x2225
          (#x2227 . #x222C) #x222E (#x2234 . #x2237)
          (#x223C . #x223D) #x2248 #x224C #x2252 (#x2260 . #x2261)
          (#x2264 . #x2267) (#x226A . #x226B) (#x226E . #x226F)
          (#x2282 . #x2283) (#x2286 . #x2287) #x2295 #x2299 #x22A5
          #x22BF #x2312 (#x2460 . #x24E9) (#x24EB . #x254B)
          (#x2550 . #x2573) (#x2580 . #x258F) (#x2592 . #x2595)
          (#x25A0 . #x25A1) (#x25A3 . #x25A9) (#x25B2 . #x25B3)
          (#x25B6 . #x25B7) (#x25BC . #x25BD) (#x25C0 . #x25C1)
          (#x25C6 . #x25C8) #x25CB (#x25CE . #x25D1)
          (#x25E2 . #x25E5) #x25EF (#x2605 . #x2606) #x2609
          (#x260E . #x260F) (#x2614 . #x2615) #x261C #x261E #x2640
          #x2642 (#x2660 . #x2661) (#x2663 . #x2665)
          (#x2667 . #x266A) (#x266C . #x266D) #x266F #x273D
          (#x2776 . #x277F) (#xE000 . #xF8FF) (#xFE00 . #xFE0F)
          #xFFFD
          ))
  (set-char-table-range table range width))
    (optimize-char-table table)
    (set-char-table-parent table char-width-table)
    (setq char-width-table table)))
(set-east-asian-ambiguous-width 2)

;; 全角チルダ/波ダッシュをWindowsスタイルにする
(let ((table (make-translation-table-from-alist '((#x301c . #xff5e))) ))
  (mapc
   (lambda (coding-system)
     (coding-system-put coding-system :decode-translation-table table)
     (coding-system-put coding-system :encode-translation-table table)
     )
   '(utf-8 cp932 utf-16le)))

;; cp932エンコードの表記変更
(coding-system-put 'cp932 :mnemonic ?P)
(coding-system-put 'cp932-dos :mnemonic ?P)
(coding-system-put 'cp932-unix :mnemonic ?P)
(coding-system-put 'cp932-mac :mnemonic ?P)

;; UTF-8エンコードの表記変更
(coding-system-put 'utf-8 :mnemonic ?U)
(coding-system-put 'utf-8-with-signature :mnemonic ?u)

;; 改行コードの表記追加
(setq eol-mnemonic-dos       ":Dos ")
(setq eol-mnemonic-mac       ":Mac ")
(setq eol-mnemonic-unix      ":Unx ")
(setq eol-mnemonic-undecided ":??? ")

;; ============================================
;; 言語設定
;; ============================================
(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8-unix) ;; デフォルトの文字コード
(prefer-coding-system 'utf-8-unix) ;; テキストファイル／新規バッファの文字コード
(set-file-name-coding-system 'utf-8-unix) ;; ファイル名の文字コード
;;(set-file-name-coding-system 'japanese-shift-jis) ;; ファイル名の文字コード
;;(set-file-name-coding-system 'shift-jis) ;; ファイル名の文字コード
;;(set-file-name-coding-system 'cp932)
;;(setq default-file-name-coding-system 'japanese-shift-jis)
(set-keyboard-coding-system 'utf-8-unix) ;; キーボード入力の文字コード
(setq default-process-coding-system '(undecided-dos . utf-8-unix)) ;; サブプロセスのデフォルト文字コード


(set-face-attribute 'default nil :family "Inconsolata" :height 210) ;; デフォルト フォント
(set-face-attribute 'variable-pitch nil :family "Inconsolata" :height 210) ;; プロポーショナル フォント
(set-face-attribute 'fixed-pitch nil :family "Inconsolata" :height 210 ) ;; 等幅フォント
(set-face-attribute 'tooltip nil :family "Inconsolata" :height 210) ;; ツールチップ表示フォント
;; (set-face-attribute 'default nil :family "Myrica M" :height 210) ;; デフォルト フォント
;; (set-face-attribute 'variable-pitch nil :family "Myrica M" :height 210) ;; プロポーショナル フォント
;; (set-face-attribute 'fixed-pitch nil :family "Myrica M" :height 210 ) ;; 等幅フォント
;; (set-face-attribute 'tooltip nil :family "Myrica M" :height 210) ;; ツールチップ表示フォント

;;
(dolist (target '(japanese-jisx0212
                  japanese-jisx0213-2
                  japanese-jisx0213.2004-1
                  katakana-jisx0201
                  japanese-jisx0208
                  latin-jisx0201
                  ))

  (set-fontset-font (frame-parameter nil 'font)
                    target
                    ;;(font-spec :family "MeiryoKe_Gothic" :registry "unicode-bmp" :lang 'ja :height 210)))
                    ;;(font-spec :family "Noto Sans Mono CJK JP Regular" :registry "unicode-bmp" :lang 'ja :height 210)))
                    ;;(font-spec :family "Gen Shin Gothic Monospace Regular" :registry "unicode-bmp" :lang 'ja :height 210)))
                    ;;(font-spec :family "TakaoGothic" :registry "unicode-bmp" :lang 'ja :height 21)))
                    (font-spec :family "VLGothic" :registry "unicode-bmp" :lang 'ja :height 21)))
                    ;;(font-spec :family "Myrica M" :registry "unicode-bmp" :lang 'ja :height 21)))
                    ;;(font-spec :family "MyricaM M" :registry "unicode-bmp" :lang 'ja :height 21)))
                    ;;(font-spec :family "RictyDiminished" :registry "unicode-bmp" :lang 'ja :height 21)))
;;1234567890|
;;ぱぴぷぺぽ|
;;パピプペポ|
;;影響削除|


(use-package mozc :ensure t)
(use-package mozc-im)
(require 'mozc-posframe)
(setq default-input-method "japanese-mozc")
(setq mozc-candidate-style 'posframe)
(require 'mozc-isearch)
(require 'mozc-mode-line-indicator)

;; mozc-cursor-color を利用するための対策
;; (defvar mozc-im-mode nil)
;; (make-variable-buffer-local 'mozc-im-mode)
(defvar-local mozc-im-mode nil)
(add-hook 'mozc-im-activate-hook (lambda () (setq mozc-im-mode t)))
(add-hook 'mozc-im-deactivate-hook (lambda () (setq mozc-im-mode nil)))
(advice-add 'mozc-cursor-color-update
            :around (lambda (orig-fun &rest args)
                      (let ((mozc-mode mozc-im-mode))
                        (apply orig-fun args))))

;; isearch を利用する前後で IME の状態を維持するための対策
(add-hook 'isearch-mode-hook (lambda () (setq im-state mozc-im-mode)))
(add-hook 'isearch-mode-end-hook
          (lambda ()
            (unless (eq im-state mozc-im-mode)
              (if im-state
                  (activate-input-method default-input-method)
                (deactivate-input-method)))))

(add-hook 'input-method-activate-hook
          (function (lambda ()
                      (set-cursor-color "red")
                      ;; (set-face-background 'mode-line "grey10")
                      ;; (set-face-foreground 'mode-line "hot pink")
                      )))
(add-hook 'input-method-inactivate-hook
          (function (lambda ()
                     (set-cursor-color "yellow")
          ;; (set-face-background 'mode-line "grey10")
          ;; (set-face-foreground 'mode-line "green")
          )))

;; ============================================
;; タブ、スペースの設定
;; ============================================
(setq-default tab-width 4) ;;タブ幅を 4 に設定
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60)) ;;タブ幅の倍数を設定
;;タブではなくスペースを使う
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)

(use-package all-the-icons)
