(use-package git-gutter-fringe)

(use-package php-mode)
(use-package flycheck-phpstan)
(use-package web-mode)

(use-package lsp-mode
:custom
;; debug
(lsp-print-io nil)
(lsp-trace nil)
(lsp-print-performance nil)
;; general
(lsp-auto-guess-root t)
(lsp-document-sync-method 'incremental) ;; none, full, incremental, or nil
(lsp-response-timeout 10)
(lsp-prefer-flymake t) ;; t(flymake), nil(lsp-ui), or :none
;; go-client
(lsp-clients-go-server-args '("--cache-style=always" "--diagnostics-style=onsave" "--format-style=goimports"))
:hook
;;((php-mode web-mode css-mode) . lsp)
:config
(require 'lsp-clients)
;; LSP UI tools
(use-package lsp-ui
:custom
;; lsp-ui-doc
(lsp-ui-doc-enable nil)
(lsp-ui-doc-header t)
(lsp-ui-doc-include-signature nil)
(lsp-ui-doc-position 'at-point) ;; top, bottom, or at-point
(lsp-ui-doc-max-width 120)
(lsp-ui-doc-max-height 30)
(lsp-ui-doc-use-childframe t)
(lsp-ui-doc-use-webkit t)
;; lsp-ui-flycheck
(lsp-ui-flycheck-enable nil)
;; lsp-ui-sideline
(lsp-ui-sideline-enable nil)
(lsp-ui-sideline-ignore-duplicate t)
(lsp-ui-sideline-show-symbol t)
(lsp-ui-sideline-show-hover t)
(lsp-ui-sideline-show-diagnostics nil)
(lsp-ui-sideline-show-code-actions t)
(lsp-ui-sideline-code-actions-prefix "")
;; lsp-ui-imenu
(lsp-ui-imenu-enable t)
(lsp-ui-imenu-kind-position 'top)
;; lsp-ui-peek
(lsp-ui-peek-enable t)
(lsp-ui-peek-peek-height 20)
(lsp-ui-peek-list-width 50)
(lsp-ui-peek-fontify 'on-demand) ;; never, on-demand, or always
:preface
(defun ladicle/toggle-lsp-ui-doc ()
  (interactive)
  (if lsp-ui-doc-mode
    (progn
      (lsp-ui-doc-mode -1)
      (lsp-ui-doc--hide-frame))
     (lsp-ui-doc-mode 1)))
:hook
(lsp-mode . lsp-ui-mode))
)

(use-package company-lsp
:custom
(company-lsp-cache-candidates t) ;; auto, t(always using a cache), or nil
(company-lsp-async t)
(company-lsp-enable-snippet t)
(company-lsp-enable-recompletion t))
