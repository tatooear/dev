 (use-package counsel
    :diminish ivy-mode counsel-mode
    :preface
    (defun ivy-format-function-pretty (cands)
      "Transform CANDS into a string for minibuffer."
      (ivy--format-function-generic
       (lambda (str)
         (concat
             (all-the-icons-faicon "hand-o-right" :height .85 :v-adjust .05 :face 'font-lock-constant-face)
             (ivy--add-face str 'ivy-current-match)))
       (lambda (str)
         (concat "  " str))
       cands
       "\n"))
    :hook
    (after-init . ivy-mode)
    (ivy-mode . counsel-mode)
    :custom
    (counsel-yank-pop-height 15)
    (enable-recursive-minibuffers t)
    (ivy-use-selectable-prompt t)
    (ivy-use-virtual-buffers t)
    (ivy-on-del-error-function nil)
    (swiper-action-recenter t)
    (counsel-grep-base-command "rg -S --noheading --nocolor --nofilename --numbers '%s' %s")
    :config
    ;; using ivy-format-fuction-arrow with counsel-yank-pop
    (advice-add
    'counsel--yank-pop-format-function
    :override
    (lambda (cand-pairs)
      (ivy--format-function-generic
       (lambda (str)
         (mapconcat
          (lambda (s)
            (ivy--add-face (concat (propertize "┃ " 'face `(:foreground "#61bfff")) s) 'ivy-current-match))
          (split-string
           (counsel--yank-pop-truncate str) "\n" t)
          "\n"))
       (lambda (str)
         (counsel--yank-pop-truncate str))
       cand-pairs
       counsel-yank-pop-separator)))

    ;; NOTE: this variable do not work if defined in :custom
    (setq ivy-format-function 'ivy-format-function-pretty)
    (setq counsel-yank-pop-separator
        (propertize "\n────────────────────────────────────────────────────────\n"
               'face `(:foreground "#6272a4")))

    ;; Integration with `projectile'
    (with-eval-after-load 'projectile
      (setq projectile-completion-system 'ivy))
    ;; Integration with `magit'
    (with-eval-after-load 'magit
      (setq magit-completing-read-function 'ivy-completing-read))

    ;; Enhance fuzzy matching
    (use-package flx)
    ;; Enhance M-x
    (use-package amx)
    ;; Ivy integration for Projectile
    (use-package counsel-projectile
      :config (counsel-projectile-mode 1))
    (use-package 'ivy-prescient)

  ;; Show ivy frame using posframe
  (use-package ivy-posframe
    :custom
    (ivy-display-function #'ivy-posframe-display-at-frame-center)
    ;; (ivy-posframe-width 130)
    ;; (ivy-posframe-height 11)
    (ivy-posframe-parameters
      '((left-fringe . 5)
        (right-fringe . 5)))
    :custom-face
    (ivy-posframe ((t (:background "#282a36"))))
    (ivy-posframe-border ((t (:background "#6272a4"))))
    (ivy-posframe-cursor ((t (:background "#61bfff"))))
    :hook
    (ivy-mode . ivy-posframe-enable))

  ;; More friendly display transformer for Ivy
  (use-package ivy-rich
    :defines (all-the-icons-dir-icon-alist bookmark-alist)
    :functions (all-the-icons-icon-family
                all-the-icons-match-to-alist
                all-the-icons-auto-mode-match?
                all-the-icons-octicon
                all-the-icons-dir-is-submodule)
    :preface
    (defun ivy-rich-bookmark-name (candidate)
      (car (assoc candidate bookmark-alist)))

    (defun ivy-rich-repo-icon (candidate)
      "Display repo icons in `ivy-rich`."
      (all-the-icons-octicon "repo" :height .9))

    (defun ivy-rich-org-capture-icon (candidate)
      "Display repo icons in `ivy-rich`."
      (pcase (car (last (split-string (car (split-string candidate)) "-")))
         ("emacs" (all-the-icons-fileicon "emacs" :height .68 :v-adjust .001))
         ("schedule" (all-the-icons-faicon "calendar" :height .68 :v-adjust .005))
         ("tweet" (all-the-icons-faicon "commenting" :height .7 :v-adjust .01))
         ("link" (all-the-icons-faicon "link" :height .68 :v-adjust .01))
         ("memo" (all-the-icons-faicon "pencil" :height .7 :v-adjust .01))
         (_       (all-the-icons-octicon "inbox" :height .68 :v-adjust .01))
         ))

    (defun ivy-rich-org-capture-title (candidate)
      (let* ((octl (split-string candidate))
             (title (pop octl))
             (desc (mapconcat 'identity octl " ")))
        (format "%-25s %s"
                 title
                 (propertize desc 'face `(:inherit font-lock-doc-face)))))

    (defun ivy-rich-buffer-icon (candidate)
      "Display buffer icons in `ivy-rich'."
      (when (display-graphic-p)
        (when-let* ((buffer (get-buffer candidate))
                    (major-mode (buffer-local-value 'major-mode buffer))
                    (icon (if (and (buffer-file-name buffer)
                                   (all-the-icons-auto-mode-match? candidate))
                              (all-the-icons-icon-for-file candidate)
                            (all-the-icons-icon-for-mode major-mode))))
          (if (symbolp icon)
              (setq icon (all-the-icons-icon-for-mode 'fundamental-mode)))
          (unless (symbolp icon)
            (propertize icon
                        'face `(
                                :height 1.1
                                :family ,(all-the-icons-icon-family icon)
                                ))))))

    (defun ivy-rich-file-icon (candidate)
      "Display file icons in `ivy-rich'."
      (when (display-graphic-p)
        (let ((icon (if (file-directory-p candidate)
                        (cond
                         ((and (fboundp 'tramp-tramp-file-p)
                               (tramp-tramp-file-p default-directory))
                          (all-the-icons-octicon "file-directory"))
                         ((file-symlink-p candidate)
                          (all-the-icons-octicon "file-symlink-directory"))
                         ((all-the-icons-dir-is-submodule candidate)
                          (all-the-icons-octicon "file-submodule"))
                         ((file-exists-p (format "%s/.git" candidate))
                          (all-the-icons-octicon "repo"))
                         (t (let ((matcher (all-the-icons-match-to-alist candidate all-the-icons-dir-icon-alist)))
                              (apply (car matcher) (list (cadr matcher))))))
                      (all-the-icons-icon-for-file candidate))))
          (unless (symbolp icon)
            (propertize icon
                        'face `(
                                :height 1.1
                                :family ,(all-the-icons-icon-family icon)
                                ))))))
    :hook (ivy-rich-mode . (lambda ()
                             (setq ivy-virtual-abbreviate
                                   (or (and ivy-rich-mode 'abbreviate) 'name))))
    :init
    (setq ivy-rich-display-transformers-list
          '(ivy-switch-buffer
            (:columns
             ((ivy-rich-buffer-icon)
              (ivy-rich-candidate (:width 30))
              (ivy-rich-switch-buffer-size (:width 7))
              (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
              (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))
              (ivy-rich-switch-buffer-project (:width 15 :face success))
              (ivy-rich-switch-buffer-path (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.3))))))
             :predicate
             (lambda (cand) (get-buffer cand)))
            ivy-switch-buffer-other-window
            (:columns
             ((ivy-rich-buffer-icon)
              (ivy-rich-candidate (:width 30))
              (ivy-rich-switch-buffer-size (:width 7))
              (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
              (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))
              (ivy-rich-switch-buffer-project (:width 15 :face success))
              (ivy-rich-switch-buffer-path (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.3))))))
             :predicate
             (lambda (cand) (get-buffer cand)))
            counsel-M-x
            (:columns
             ((counsel-M-x-transformer (:width 40))
              (ivy-rich-counsel-function-docstring (:face font-lock-doc-face))))
            counsel-describe-function
            (:columns
             ((counsel-describe-function-transformer (:width 45))
              (ivy-rich-counsel-function-docstring (:face font-lock-doc-face))))
            counsel-describe-variable
            (:columns
             ((counsel-describe-variable-transformer (:width 45))
              (ivy-rich-counsel-variable-docstring (:face font-lock-doc-face))))
            counsel-find-file
            (:columns
             ((ivy-rich-file-icon)
              (ivy-rich-candidate)))
            counsel-file-jump
            (:columns
             ((ivy-rich-file-icon)
              (ivy-rich-candidate)))
            counsel-dired-jump
            (:columns
             ((ivy-rich-file-icon)
              (ivy-rich-candidate)))
            counsel-git
            (:columns
             ((ivy-rich-file-icon)
              (ivy-rich-candidate)))
            counsel-recentf
            (:columns
             ((ivy-rich-file-icon)
              (ivy-rich-candidate (:width 110))))
            counsel-bookmark
            (:columns
             ((ivy-rich-bookmark-type)
              (ivy-rich-bookmark-name (:width 30))
              (ivy-rich-bookmark-info (:width 80))))
            counsel-projectile-switch-project
            (:columns
             ((ivy-rich-file-icon)
              (ivy-rich-candidate)))
            counsel-fzf
            (:columns
             ((ivy-rich-file-icon)
              (ivy-rich-candidate)))
            ivy-ghq-open
            (:columns
             ((ivy-rich-repo-icon)
              (ivy-rich-candidate)))
            ivy-ghq-open-and-fzf
            (:columns
             ((ivy-rich-repo-icon)
              (ivy-rich-candidate)))
            counsel-projectile-find-file
            (:columns
             ((ivy-rich-file-icon)
              (ivy-rich-candidate)))
            counsel-org-capture
            (:columns
             ((ivy-rich-org-capture-icon)
              (ivy-rich-org-capture-title)
              ))
            counsel-projectile-find-dir
            (:columns
             ((ivy-rich-file-icon)
              (counsel-projectile-find-dir-transformer)))))

    (setq ivy-rich-parse-remote-buffer nil)
    :config
    (ivy-rich-mode 1))
  )

(use-package migemo
  :custom
  (migemo-command "/home/linuxbrew/.linuxbrew/bin/cmigemo")
  (migemo-options '("-q" "--emacs"))
  (migemo-user-dictionary nil)
  (migemo-regex-dictionary nil)
  (migemo-coding-system 'utf-8-unix)
  (migemo-dictionary "/home/linuxbrew/.linuxbrew/Cellar/cmigemo/20110227/share/migemo/utf-8/migemo-dict")
  :config
  (when (eq system-type 'darwin)
    (setq migemo-dictionary "/home/linuxbrew/.linuxbrew/Cellar/cmigemo/20110227/share/migemo/utf-8/migemo-dict"))
  (migemo-init)
  (use-package avy-migemo
    :after swiper
    :config
    ;; (avy-migemo-mode 1)
    (require 'avy-migemo-e.g.swiper))
  )

(use-package ace-pinyin)
(use-package find-file-in-project)

(defmacro with-suppressed-message (&rest body)
  "Suppress new messages temporarily in the echo area and the `*Messages*' buffer while BODY is evaluated."
  (declare (indent 0))
  (let ((message-log-max nil))
    `(with-temp-message (or (current-message) "") ,@body)))

(require 'recentf)
(setq recentf-save-file "~/.emacs.d/.recentf")
(setq recentf-max-saved-items 200)             ;; recentf に保存するファイルの数
(setq recentf-exclude '(".recentf"))           ;; .recentf自体は含まない
(setq recentf-auto-cleanup 'never)             ;; 保存する内容を整理
(run-with-idle-timer 30 t '(lambda () (with-suppressed-message (recentf-save-list))))
(use-package recentf-ext) ;; ちょっとした拡張

(use-package dumb-jump)
(use-package imenu-anywhere)
(use-package bm)

(when (require 'bm nil t)
  (defun counsel-bm-get-list (bookmark-overlays)
    (-map (lambda (bm)
            (with-current-buffer (overlay-buffer bm)
              (let* ((line (replace-regexp-in-string
                            "\n$" ""
                            (buffer-substring (overlay-start bm)
                                              (overlay-end bm))))
                     ;; line numbers start on 1
                     (line-num
                      (+ 1 (count-lines (point-min) (overlay-start bm))))
                     (name (format "%s:%d - %s" (buffer-name) line-num line)))
                `(,name . ,bm))))
          bookmark-overlays))

  (defun counsel-bm ()
    (interactive)
    (let* ((bm-list (counsel-bm-get-list (bm-overlays-lifo-order t)))
           (bm-hash-table (make-hash-table :test 'equal))
           (search-list (-map (lambda (bm) (car bm)) bm-list)))
      (-each bm-list (lambda (bm)
                       (puthash (car bm) (cdr bm) bm-hash-table)
                       ))
      (ivy-read "Find bookmark(bm.el): "
                search-list
                :require-match t
                :keymap counsel-describe-map
                :action (lambda (chosen)
                          (let ((bookmark (gethash chosen bm-hash-table)))
                            (switch-to-buffer (overlay-buffer bookmark))
                            (bm-goto bookmark)
                            ))
                :sort t)))
  )


