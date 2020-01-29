;;; compile-setting.el ---

(use-package open-junk-file)
(setq open-junk-file-find-file-function 'find-file)

;; ================================
;; compile
;; ================================
(use-package auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp ".revive.el")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

;; ================================
;; flycheck
;; ================================
(use-package flycheck) ;; 文法チェック
(use-package flycheck-pos-tip)
(global-flycheck-mode)

;; (flycheck-define-checker textlint
;;   "textlint."
;;   :command ("textlint" "--format" "unix"
;;             source-inplace)
;;   :error-patterns
;;   ((warning line-start (file-name) ":" line ":" column ": "
;;             (id (one-or-more (not (any " "))))
;;             (message (one-or-more not-newline)
;;                      (zero-or-more "\n" (any " ") (one-or-more not-newline)))
;;             line-end))
;;   :modes (text-mode markdown-mode gfm-mode prog-mode))
;; (add-to-list 'flycheck-checkers 'textlint)

(flycheck-add-mode 'html-tidy 'web-mode)
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; (use-package flyspell)
;; (setq-default ispell-program-name "aspell")
;; (eval-after-load "ispell"
;;   '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
;; (setq ispell-program-name "aspell"
;;   ispell-extra-args
;;   '("--sug-mode=ultra" "--lang=en_US" "--run-together" "--run-together-limit=5" "--run-together-min=2"))
;; (add-hook 'prog-mode-hook 'flyspell-mode)
;; (add-hook 'text-mode-hook 'flyspell-mode)
;; (use-package flyspell-popup)
;; (add-hook 'flyspell-mode-hook #'flyspell-popup-auto-correct-mode)
;; ================================
;; git
;; ================================
(use-package magit)

;;(require 'git-gutter-fringe)
;;(global-git-gutter-mode t)

(use-package git-gutter-fringe+)
(global-git-gutter+-mode 1)
;;; mode-setting.el ---

(use-package lsp-mode)

;; config
(setq lsp-print-performance nil)
(setq lsp-auto-guess-root t)
(setq lsp-document-sync-method 'incremental)
(setq lsp-response-timeout 5)
(setq lsp-prefer-flymake t)

(add-hook 'php-mode-hook #'lsp)
(add-hook 'web-mode-hook #'lsp)
(add-hook 'javascript-mode-hook #'lsp)
(add-hook 'css-mode-hook #'lsp)

(require 'lsp-clients)

(use-package lsp-ui)
(setq lsp-ui-doc-enable t)
(setq lsp-ui-doc-header t)
(setq lsp-ui-doc-include-signature nil)
(setq lsp-ui-doc-position 'at-point) ;; top, bottom, or at-point
(setq lsp-ui-doc-max-width 120)
(setq lsp-ui-doc-max-height 30)
(setq lsp-ui-doc-use-childframe t)
(setq lsp-ui-doc-use-webkit t)
;; lsp-ui-flycheck
(setq lsp-ui-flycheck-enable t)
;; lsp-ui-sideline
(setq lsp-ui-sideline-enable t)
(setq lsp-ui-sideline-ignore-duplicate t)
(setq lsp-ui-sideline-show-symbol t)
(setq lsp-ui-sideline-show-hover t)
(setq lsp-ui-sideline-show-diagnostics t)
(setq lsp-ui-sideline-show-code-actions t)
(setq lsp-ui-sideline-code-actions-prefix "")
;; lsp-ui-imenu
(setq lsp-ui-imenu-enable t)
(setq lsp-ui-imenu-kind-position 'top)
;; lsp-ui-peek
(setq lsp-ui-peek-enable t)
(setq lsp-ui-peek-peek-height 20)
(setq lsp-ui-peek-list-width 50)
(setq lsp-ui-peek-fontify 'on-demand) ;; never, on-demand, or always

(add-hook 'lsp-mode-hook 'lsp-ui-mode)

(use-package company-lsp
:custom
(company-lsp-cache-candidates t) ;; auto, t(always using a cache), or nil
(company-lsp-async t)
(company-lsp-enable-snippet t)
(company-lsp-enable-recompletion t))

(use-package helm-lsp :commands helm-lsp-workspace-symbol)
(use-package lsp-treemacs
  :config
  (lsp-metals-treeview-enable t)
  (setq lsp-metals-treeview-show-when-views-received t))

;; ====================================
;; 各モードの設定
;; ====================================
(require 'generic-x)                                    ;; モードがないファイルをカラフルに

(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p) 	;; スクリプトに自動で実行権を与える

(use-package csv-mode)
(use-package markdown-mode)
(use-package json-mode)

(use-package gtags)

(use-package php-mode)
(use-package php-eldoc)
(use-package flycheck-phpstan)
(use-package ac-php)

(setq php-mode-coding-style (quote psr2))
(add-hook 'php-mode-hook
          (lambda ()
           ;;(key-combo-mode 1)
           ;;(require 'phpdocumentor)
           ;; (yas-global-mode 1)
           (gtags-mode t)
           (flycheck-mode t)
           (setq flycheck-phpcs-standard "PSR1")
           (add-to-list 'flycheck-disabled-checkers 'php-phpmd)
           (add-to-list 'flycheck-disabled-checkers 'php-phpcs)
           
           ;;(require 'company-php)
           ;; (set (make-local-variable 'company-backends) '(company-web-html))
           ;;  (company-mode t)
           ;; (ac-html-enable)
           ;; (ac-js2-mode)
           ;; (require 'ac-html-csswatcher)
           ;; (ac-html-csswatcher-setup)
           ;;(ac-php-core-eldoc-setup)
           (smart-newline-mode t)
           (rainbow-delimiters-mode)
           (rainbow-mode)
           (setq tab-width 4)
           (setq c-basic-offset 4)
           (c-set-offset 'case-label' 4)
           (c-set-offset 'arglist-intro' 4)
           (c-set-offset 'arglist-cont-nonempty' 4)
           (c-set-offset 'arglist-close' 0)
           (set (make-local-variable 'company-backends)
                ;;'((company-yasnippet company-ac-php-backend company-web-html company-files company-ispell company-dabbrev-code company-gtags company-keywords) company-capf company-dabbrev company-css company-lsp))
                '((company-yasnippet company-web-html company-files company-dabbrev-code company-keywords company-capf company-dabbrev company-css company-lsp))
)))
(setq php-mode-force-pear t) ;PEAR規約のインデント設定にする

(add-hook 'css-mode-hook
          (lambda ()
            ;;(key-combo-mode 1)
            (gtags-mode t)
            ;;(flycheck-mode t)
            (smart-newline-mode t)
            (rainbow-delimiters-mode)
            (rainbow-mode)
            ))


(use-package js2-mode)
(use-package prettier-js)
(use-package web-mode)

(add-hook 'web-mode-hook 'prettier-js-mode)
;;; インデント数
(add-hook 'web-mode-hook
          (lambda ()
            ;;(key-combo-mode 1)
            (setq web-mode-enable-auto-indentation nil)
            (setq web-mode-html-offset   2)
            (setq web-mode-css-offset    2)
            (setq web-mode-script-offset 2)
            (setq web-mode-php-offset    4)
            (setq web-mode-markup-indent-offset 2)
            (setq web-mode-css-indent-offset 2)
            (setq web-mode-code-indent-offset 4)
            (setq web-mode-disable-auto-pairing t)
            (setq web-mode-engines-alist
                  '(("php"    . "\\.tpl\\'"))
                  )
            ;; (set (make-local-variable 'company-backends) '(company-web-html))
            ;; (company-mode t)
            ;;(require 'ac-php)
            ;;(require 'phpdocumentor)
            ;; (yas-global-mode 1)
            ;; (require 'ac-html-csswatcher)
            ;; (ac-html-csswatcher-setup)
            ;;(require 'company-php)
            ;;(ac-php-core-eldoc-setup)
            (gtags-mode t)
            (smart-newline-mode t)
            (rainbow-delimiters-mode)
            (rainbow-mode)
            (auto-highlight-symbol-mode t)
            (setq imenu-create-index-function 'html-imenu-create-index)
            ;;(require 'rename-sgml-tag)
            (flycheck-mode t)
            (set (make-local-variable 'company-backends)
                 ;;'((company-yasnippet company-ac-php-backend company-web-html company-files company-ispell company-dabbrev-code company-gtags company-keywords company-capf company-dabbrev company-css company-lsp))
                 '((company-yasnippet company-web-html company-files company-dabbrev-code company-keywords company-capf company-dabbrev company-css company-lsp))
            )))

(add-hook 'sql-mode-hook 'turn-on-orgstruct)

;; text-mode
(add-hook 'text-mode-hook
          (lambda ()
            ;; (key-combo-mode 1)
            (smart-newline-mode t)
            (font-lock-mode t)
            (font-lock-fontify-buffer)
            (rainbow-mode)
            (rainbow-delimiters-mode)
            ))

(add-hook 'fundamental-mode-hook
          (lambda ()
            ;; (key-combo-mode 1)
            (smart-newline-mode t)
           (font-lock-mode t)
           (rainbow-delimiters-mode)
           (rainbow-mode)
           (font-lock-fontify-buffer)))

(add-hook 'elisp-mode-hook
          (lambda ()
            ;; (key-combo-mode 1)
            (rainbow-delimiters-mode)
            (rainbow-mode)
            (font-lock-mode t)
            (font-lock-fontify-buffer)))

(setq auto-mode-alist
      (append (list
               ;; '("\\.c$" . c-mode)
               ;; '("\\.java$" . java-mode)
               '("\.js$" . web-mode)
               ;; '("\\.sgm$" . sgml-mode)
               ;; '("\\.sgml$" . sgml-mode)
              ;; '("\\.html$" . sgml-mode)
             ;;  '("\\.htm$" . sgml-mode)
               '("\.xml$" . web-mode)
               '("\.el$" . emacs-lisp-mode)
               '("\.php$" . php-mode)
               '("\.html$" . web-mode)
               '("\.stml$" . web-mode)
               '("\.ctp$" . web-mode)
               '("\.tpl$" . web-mode)
               '("\.vue$" . web-mode)
               ;; '("\.html$" . nxml-mode)
               ;; '("\.shtml$" . nxml-mode)
               ;; '("\.ctp$" . nxml-mode)
               '("\.css$" . web-mode)
               '("\.csv$" . csv-mode)
               '("\.json$" . json-mode)
               '("\.txt$" . text-mode)
               '("\.md$" . markdown-mode)
               '("\.eml$" . text-mode)
               '("\.htaccess"   . apache-mode)
               '("httpd\.conf"  . apache-mode)
               '("\.org$" . org-mode)
               '("\.ini$" . ini-generic-mode)
               '("\.cnf$" . conf-mode)
               '("\.sh$"  . shell-script-mode)
               auto-mode-alist)))

(setq lsp-language-id-configuration '(
                                      (css-mode . "css")
                                      (web-mode . "css")
                                      (xml-mode . "xml")
                                      (web-mode . "html")
                                      (php-mode . "php")
                                      (web-mode . "php")
                                      (web-mode . "javascript")
                                      ))
