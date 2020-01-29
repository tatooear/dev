;;; completions-setting.el ---

;; ==================================
;; 補完
;; ==================================

;; コマンドの複数回実効
(defun my-repeat (arg)
  (interactive "p")
  (unless (eq real-last-command this-command)
    (let ((i 0))
      (while (< i arg)
        (repeat 1)
        (setq i (1+ i))))))

;; 繰り返し処理
(require 'dmacro)
(defconst *dmacro-key* [?\C-:] "繰返し指定キー")
(global-set-key *dmacro-key* 'dmacro-exec)
(autoload 'dmacro-exec "dmacro" nil t)

;; (require 'key-combo)
;; (key-combo-mode 1)

;; (setq key-combo-lisp-default
;;       '(
;;         ("-" . (" - " "-" ))
;;         ("(" . ("( `!!' )" "(`!!')" "("))
;;         ("[" . ("[ `!!' ]" "[`!!']" "【`!!'】" ))
;;         ("'" . ("\'`!!''" "\'"))
;;         ("\"" . ("\"`!!'\"" "\""))
;;         ("<" . ("< `!!' >" "<`!!'>"))
;;         ("," . (" , " "," ))
;;         ("=" . (" = " "=" ))
;;         ("`" . ("\``!!'\`" "`"))
;;         )
;;       )

;; (setq key-combo-lisp-mode-hooks
;;       '(lisp-mode-hook
;;         emacs-lisp-mode-hook
;;         lisp-interaction-mode-hook
;;         text-mode-hook
;;         sql-mode-hook))

;; (setq key-combo-common-default
;;       '(("," . (" , " ","))
;;         ("=" . (" = " " === " "=" " == " ))
;;         ("+" . (" + " "++" " += " "+"))
;;         ("-" . (" - " "--" "->" " -= " "-"))
;;         (">" . (" > " " => " " >= " "=>" ">" "&gt;"))
;;         ("%" . (" % " " %= " "%"))
;;         ("!" . (" !== " " ! " "!"))
;;         ("~" . (" =~ " "~"))
;;         (":" . (" : " ":"))
;;         ("&" . (" & " " && " "&" " &= " "&amp;" "&nbsp;"))
;;         ("*" . (" * "  "*"))
;;         ("<" . (" < " " <= " "<" "&lt;"))
;;         ("|" . (" | "" || " "|"))
;;         ("/" . ( " / " "// " "/"))
;;         ("{" . ("{\n`!!'\n}" "{ `!!' }" "{`!!'}" " { " "{"))
;;         ("[" . ("[ `!!' ]" "[ " "["))
;;         ("'" . ("'`!!''" "'"))
;;         ("\"" . ("\"`!!'\"" "\""))
;;         ("(" . ("( `!!' )" "(`!!')" " ( " "(" ))
;;         ("?" . ("<?php `!!' ?>" "<?php" "?>" "<?=" "?" ))
;;         ))

;; (setq key-combo-common-mode-hooks
;;       '(php-mode-hook
;;         javascript-mode-hook
;;         js-mode-hook
;;         js2-mode-hook
;;         web-mode-hook
;;         html-mode-hook
;;         nxml-mode-hook))

;; (key-combo-define-hook key-combo-common-mode-hooks
;;                        'key-combo-common-load-default
;;                        key-combo-common-default)

;; (key-combo-define-hook key-combo-lisp-mode-hooks
;;                        'key-combo-lisp-load-default
;;                        key-combo-lisp-default)

(require 'smartchr) ;;特定入力補完
(defun smartchr-custom-keybindings ()
  (local-set-key (kbd "=") (smartchr '(" = " " == "  "=")))
  (local-set-key (kbd "+") (smartchr '(" + " "++"  "+" " += " )))
  (local-set-key (kbd "-") (smartchr '(" - " "--"  "-" " -= " )))
  (local-set-key (kbd "&") (smartchr '("&" " && "  " & ")))
  ;; !! がカーソルの位置
  (local-set-key (kbd "(") (smartchr '("( `!!' )" "(`!!')" "(")))
  (local-set-key (kbd "[") (smartchr '("[ `!!' ]" "[`!!']" "[ [`!!'] ]" "[")))
  (local-set-key (kbd "{") (smartchr '("{" "{\n`!!'\n}" "{ `!!' }" "{`!!'}")))
  (local-set-key (kbd "'") (smartchr '("\'`!!''" "\'")))
  (local-set-key (kbd "\"") (smartchr '("\"`!!'\"" "\"")))
  (local-set-key (kbd "/") (smartchr '("/" "// " " / ")))
  (local-set-key (kbd ">") (smartchr '(" > " " >= " ">")))
  (local-set-key (kbd "<") (smartchr '(" < " " <= " "<")))
  (local-set-key (kbd ",") (smartchr '(" , " "," )))
  )

(defun smartchr-custom-keybindings-text ()
  (local-set-key (kbd "-") (smartchr '(" - " "-" )))
  (local-set-key (kbd "(") (smartchr '("( `!!' )" "(`!!')" "(")))
  (local-set-key (kbd "[") (smartchr '("[ `!!' ]" "[`!!']" "【`!!'】" )))
  (local-set-key (kbd "'") (smartchr '("\'`!!''" "\'")))
  (local-set-key (kbd "\"") (smartchr '("\"`!!'\"" "\"")))
  (local-set-key (kbd "<") (smartchr '("< `!!' >" "<`!!'>")))
  (local-set-key (kbd ",") (smartchr '(" , " "," )))
  )

(defun smartchr-custom-keybindings-html ()
  (local-set-key (kbd "\"") (smartchr '("\"`!!'\"" "\"" "&quot;")))
  (local-set-key (kbd "`") (smartchr '("\``!!''" "\`")))
  (local-set-key (kbd "<") (smartchr '("<" "&lt;" )))
  (local-set-key (kbd ">") (smartchr '(">" "&gt;" )))
  (local-set-key (kbd "&") (smartchr '("&" "&amp;" "&nbsp;")))
  (local-set-key (kbd "?") (smartchr '("<?php `!!' ?>" "<?php" "?>" "<?=" "?")))
  )

(defun smartchr-custom-keybindings-php ()
  (local-set-key (kbd "=") (smartchr '(" = " " === " "=" "=>" "==" )))
  (local-set-key (kbd "+") (smartchr '(" + " "++"  "+" " += " )))
  (local-set-key (kbd "-") (smartchr '( "->" " - " "--" "-"  )))
  (local-set-key (kbd "(") (smartchr '("( `!!' )" "(`!!')" "(")))
  (local-set-key (kbd "[") (smartchr '("[ `!!' ]" "[`!!']" "[")))
  (local-set-key (kbd "{") (smartchr '("{" "{\n`!!'\n}" "{ `!!' }" "{`!!'}")))
  (local-set-key (kbd "'") (smartchr '("\'`!!''" "\'")))
  (local-set-key (kbd "\"") (smartchr '("\"`!!'\"" "\"")))
  (local-set-key (kbd ">") (smartchr '(" > " " >= " ">")))
  (local-set-key (kbd "<") (smartchr '(" < " " <= " "<")))
  (local-set-key (kbd "/") (smartchr '("/" "// " " / ")))
  (local-set-key (kbd ",") (smartchr '(" , " "," )))
  (local-set-key (kbd "?") (smartchr '("<?php `!!' ?>" "<?php" "?>" "<?=" "?")))
  (local-set-key (kbd "`") (smartchr '("\``!!'\`" "`")))
  (local-set-key (kbd "&") (smartchr '("&" " && "  " & ")))
  (local-set-key (kbd "!") (smartchr '("!" " !== "  " !! " " != " )))
  )

(defun smartchr-custom-keybindings-sql ()
  (local-set-key (kbd "=") (smartchr '(" = " "=" )))
  (local-set-key (kbd "'") (smartchr '("\'`!!''" "\'")))
  (local-set-key (kbd "(") (smartchr '("( `!!' )" "(`!!')" "(")))
  (local-set-key (kbd "`") (smartchr '("\``!!'\`" "`")))
  (local-set-key (kbd ",") (smartchr '(" , " "," )))
  )

(add-hook 'c-mode-common-hook 'smartchr-custom-keybindings)
(add-hook 'js2-mode-hook 'smartchr-custom-keybindings)
(add-hook 'emacs-lisp-mode-common-hook 'smartchr-custom-keybindings)
(add-hook 'text-mode-hook 'smartchr-custom-keybindings-text)
(add-hook 'css-mode-hook 'smartchr-custom-keybindings-text)
;; (add-hook 'mmm-global-mode 'smartchr-custom-keybindings-html)
(add-hook 'nxml-mode-hook 'smartchr-custom-keybindings-html)
(add-hook 'html-mode-hook 'smartchr-custom-keybindings-html)
(add-hook 'php-mode-hook 'smartchr-custom-keybindings-php)
(add-hook 'sql-mode-hook 'smartchr-custom-keybindings-sql)
(add-hook 'web-mode-hook 'smartchr-custom-keybindings-php)
(add-hook 'fundamental-mode-hook 'smartchr-custom-keybindings-php)

;; 囲む
;; (use-package emacs-surround)
;; (add-to-list 'emacs-surround-alist '("(" . (" ( " . " ) ")))
;; (add-to-list 'emacs-surround-alist '("p" . ("<p>" . "</p>")))
;; (add-to-list 'emacs-surround-alist '("v" . ("<div>" . "</div>")))
;; (add-to-list 'emacs-surround-alist '("s" . ("<span>" . "</span>")))
;; (add-to-list 'emacs-surround-alist '("h" . ("<th>" . "</th>")))
;; (add-to-list 'emacs-surround-alist '("r" . ("<tr>" . "</tr>")))
;; (add-to-list 'emacs-surround-alist '("t" . ("<td>" . "</td>")))

(ffap-bindings)

;; yasnippet
;; スニペットの位置を設定します。
(require 'yasnippet)
(require 'yasnippet-snippets)

(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"))
(yas-global-mode 1)
(custom-set-variables '(yas-trigger-key "TAB"))

(use-package emmet-mode)
(add-hook 'php-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'nxml-mode-hook 'emmet-mode)
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; indent 2 spaces
(setq emmet-move-cursor-between-quotes t) ;; 最初のクオートの中にカーソル

(use-package company)
(global-company-mode) ;; 全バッファで有効にする
(setq company-transformers '(company-sort-by-backend-importance)) ;; ソート順
(setq company-idle-delay 0) ;; デフォルトは0.5
(setq company-minimum-prefix-length 2) ;; デフォルトは4
(setq company-selection-wrap-around t) ;; 候補の一番下でさらに下に行こうとすると一番上に戻る

(use-package company-posframe
  :hook (company-mode . company-posframe-mode))

(use-package company-box
    :diminish
    :hook (company-mode . company-box-mode)
    :init (setq company-box-icons-alist 'company-box-icons-all-the-icons)
    :config
    (setq company-box-backends-colors nil)
    (setq company-box-show-single-candidate t)
    (setq company-box-max-candidates 50)

    (defun company-box-icons--elisp (candidate)
      (when (derived-mode-p 'emacs-lisp-mode)
        (let ((sym (intern candidate)))
          (cond ((fboundp sym) 'Function)
                ((featurep sym) 'Module)
                ((facep sym) 'Color)
                ((boundp sym) 'Variable)
                ((symbolp sym) 'Text)
                (t . nil)))))

    (with-eval-after-load 'all-the-icons
      (declare-function all-the-icons-faicon 'all-the-icons)
      (declare-function all-the-icons-fileicon 'all-the-icons)
      (declare-function all-the-icons-material 'all-the-icons)
      (declare-function all-the-icons-octicon 'all-the-icons)
      (setq company-box-icons-all-the-icons
            `((Unknown . ,(all-the-icons-material "find_in_page" :height 0.7 :v-adjust -0.15))
              (Text . ,(all-the-icons-faicon "book" :height 0.68 :v-adjust -0.15))
              (Method . ,(all-the-icons-faicon "cube" :height 0.7 :v-adjust -0.05 :face 'font-lock-constant-face))
              (Function . ,(all-the-icons-faicon "cube" :height 0.7 :v-adjust -0.05 :face 'font-lock-constant-face))
              (Constructor . ,(all-the-icons-faicon "cube" :height 0.7 :v-adjust -0.05 :face 'font-lock-constant-face))
              (Field . ,(all-the-icons-faicon "tags" :height 0.65 :v-adjust -0.15 :face 'font-lock-warning-face))
              (Variable . ,(all-the-icons-faicon "tag" :height 0.7 :v-adjust -0.05 :face 'font-lock-warning-face))
              (Class . ,(all-the-icons-faicon "clone" :height 0.65 :v-adjust 0.01 :face 'font-lock-constant-face))
              (Interface . ,(all-the-icons-faicon "clone" :height 0.65 :v-adjust 0.01))
              (Module . ,(all-the-icons-octicon "package" :height 0.7 :v-adjust -0.15))
              (Property . ,(all-the-icons-octicon "package" :height 0.7 :v-adjust -0.05 :face 'font-lock-warning-face)) ;; Golang module
              (Unit . ,(all-the-icons-material "settings_system_daydream" :height 0.7 :v-adjust -0.15))
              (Value . ,(all-the-icons-material "format_align_right" :height 0.7 :v-adjust -0.15 :face 'font-lock-constant-face))
              (Enum . ,(all-the-icons-material "storage" :height 0.7 :v-adjust -0.15 :face 'all-the-icons-orange))
              (Keyword . ,(all-the-icons-material "filter_center_focus" :height 0.7 :v-adjust -0.15))
              (Snippet . ,(all-the-icons-faicon "code" :height 0.7 :v-adjust 0.02 :face 'font-lock-variable-name-face))
              (Color . ,(all-the-icons-material "palette" :height 0.7 :v-adjust -0.15))
              (File . ,(all-the-icons-faicon "file-o" :height 0.7 :v-adjust -0.05))
              (Reference . ,(all-the-icons-material "collections_bookmark" :height 0.7 :v-adjust -0.15))
              (Folder . ,(all-the-icons-octicon "file-directory" :height 0.7 :v-adjust -0.05))
              (EnumMember . ,(all-the-icons-material "format_align_right" :height 0.7 :v-adjust -0.15 :face 'all-the-icons-blueb))
              (Constant . ,(all-the-icons-faicon "tag" :height 0.7 :v-adjust -0.05))
              (Struct . ,(all-the-icons-faicon "clone" :height 0.65 :v-adjust 0.01 :face 'font-lock-constant-face))
              (Event . ,(all-the-icons-faicon "bolt" :height 0.7 :v-adjust -0.05 :face 'all-the-icons-orange))
              (Operator . ,(all-the-icons-fileicon "typedoc" :height 0.65 :v-adjust 0.05))
              (TypeParameter . ,(all-the-icons-faicon "hashtag" :height 0.65 :v-adjust 0.07 :face 'font-lock-const-face))
              (Template . ,(all-the-icons-faicon "code" :height 0.7 :v-adjust 0.02 :face 'font-lock-variable-name-face))))))
    ;; Show quick tooltip
    (use-package company-quickhelp
      :defines company-quickhelp-delay
      :bind (:map company-active-map
                  ("M-h" . company-quickhelp-manual-begin))
      :hook (global-company-mode . company-quickhelp-mode)
      :custom (company-quickhelp-delay 0.8))

(use-package company-web)
(require 'company-web-html)
(require 'company-yasnippet)

(setq company-backends
  '((company-ispell
    company-yasnippet
    company-dabbrev-code company-gtags company-keywords
    company-files          ; files & directory
    company-capf           ; completion-at-point-functions
    company-dabbrev    ; 動的略称展開
    company-web-html
    company-css
)))

;; (defvar company-mode/enable-yas t
;;   "Enable yasnippet for all backends.")
;; (defun company-mode/backend-with-yas (backend)
;;   (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
;;       backend
;;     (append (if (consp backend) backend (list backend))
;;             '(:with company-yasnippet))))
;; (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

;; ;;(global-set-key (kbd "C-i") 'company-complete)
;; ;;(global-set-key [tab] 'company-complete)
;; (define-key company-active-map (kbd "C-i") 'company-complete-selection)
;; (define-key company-active-map [tab] 'company-complete-selection)

(require 'git-complete)
(setq git-complete-enable-autopair t)

;;zlc
;; (use-package zlc)
;; (zlc-mode 1)
;; (setq zlc-select-completion-immediately t)
;; (let ((map minibuffer-local-map))
;;   ;;; like menu select
;;   (define-key map (kbd "<down>")  'zlc-select-next-vertical)
;;   (define-key map (kbd "<up>")    'zlc-select-previous-vertical)
;;   (define-key map (kbd "<right>") 'zlc-select-next)
;;   (define-key map (kbd "<left>")  'zlc-select-previous)

;;   ;;; reset selection
;;   ;;(define-key map (kbd "C-c") 'zlc-reset)
;;   )

;;カーソルの位置にある数字列をインクリメント
(defun operate-string-as-number (number op)
  (let ((col (current-column))
        (p (if (integerp number) number 1))
        )
    (skip-chars-backward "-0123456789")
    (or (looking-at "-?[0123456789]+")
        (error "No number at point"))
      (replace-match
       (number-to-string (funcall op (string-to-number (match-string 0)) p)))
    (move-to-column col)))

(defun increment-string-as-number (number)
  (interactive "P")
  (operate-string-as-number number (lambda (x y) (+ x y)))
  )

(defun decrement-string-as-number (number)
  (interactive "P")
  (operate-string-as-number number (lambda (x y) (- x y)))
  )
