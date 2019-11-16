(set-frame-parameter nil 'alpha 90)

(set-face-attribute 'default nil :family "Inconsolata" :height 150) ;; デフォルト フォント
(set-face-attribute 'variable-pitch nil :family "Inconsolata" :height 150) ;; プロポーショナル フォント
(set-face-attribute 'fixed-pitch nil :family "Inconsolata" :height 150 ) ;; 等幅フォント
(set-face-attribute 'tooltip nil :family "Inconsolata" :height 150) ;; ツールチップ表示フォント

(fringe-mode)
(tool-bar-mode 0) 

(use-package doom-themes
  :custom
  (doom-themes-enable-italic t)
  (doom-themes-enable-bold t)
  :custom-face
  ;; (vertical-bar   (doom-darken base5 0.4))
  ;; (doom-darken bg 0.4)
  :config
  (load-theme 'doom-dracula t)
  (doom-themes-neotree-config)
  (doom-themes-org-config)
  ;; Modeline
  (use-package doom-modeline
    :custom
    (doom-modeline-buffer-file-name-style 'truncate-with-project)
    (doom-modeline-icon t)
    (doom-modeline-major-mode-icon t)
    (doom-modeline-minor-modes t)
    :hook
    (after-init . doom-modeline-mode)
    :config
    (set-cursor-color "cyan")
    (line-number-mode t)
    (column-number-mode t)
    (doom-modeline-def-modeline 'main
      '(bar workspace-number window-number evil-state god-state ryo-modal xah-fly-keys matches buffer-info remote-host buffer-position parrot selection-info)
      '(misc-info persp-name lsp github debug minor-modes input-method major-mode process vcs checker))))

(use-package powerline)
(use-package moe-theme)
(moe-dark)
(powerline-moe-theme)

(use-package neotree
  :after
  projectile
  :commands
  (neotree-show neotree-hide neotree-dir neotree-find)
  :custom
  (neo-theme 'nerd2)
  :bind
  ("<f8>" . neotree-current-dir-toggle)
  ("<f9>" . neotree-projectile-toggle)
  :preface
  (defun neotree-projectile-toggle ()
    (interactive)
    (let ((project-dir
           (ignore-errors
           ;;; Pick one: projectile or find-file-in-project
             (projectile-project-root)
             ))
          (file-name (buffer-file-name))
          (neo-smart-open t))
      (if (and (fboundp 'neo-global--window-exists-p)
               (neo-global--window-exists-p))
          (neotree-hide)
        (progn
          (neotree-show)
          (if project-dir
              (neotree-dir project-dir))
          (if file-name
              (neotree-find file-name))))))
  (defun neotree-current-dir-toggle ()
    (interactive)
    (let ((project-dir
           (ignore-errors
             (ffip-project-root)
             ))
          (file-name (buffer-file-name))
          (neo-smart-open t))
      (if (and (fboundp 'neo-global--window-exists-p)
               (neo-global--window-exists-p))
          (neotree-hide)
        (progn
          (neotree-show)
          (if project-dir
              (neotree-dir project-dir))
          (if file-name
              (neotree-find file-name)))))))
