(use-package multiple-cursors
  :preface
  ;; insert specific serial number
  (defvar ladicle/mc/insert-numbers-hist nil)
  (defvar ladicle/mc/insert-numbers-inc 1)
  (defvar ladicle/mc/insert-numbers-pad "%01d")

  (defun ladicle/mc/insert-numbers (start inc pad)
    "Insert increasing numbers for each cursor specifically."
    (interactive
     (list (read-number "Start from: " 0)
           (read-number "Increment by: " 1)
           (read-string "Padding (%01d): " nil ladicle/mc/insert-numbers-hist "%01d")))
    (setq mc--insert-numbers-number start)
    (setq ladicle/mc/insert-numbers-inc inc)
    (setq ladicle/mc/insert-numbers-pad pad)
    (mc/for-each-cursor-ordered
     (mc/execute-command-for-fake-cursor
      'ladicle/mc--insert-number-and-increase
      cursor)))

  (defun ladicle/mc--insert-number-and-increase ()
    (interactive)
    (insert (format ladicle/mc/insert-numbers-pad mc--insert-numbers-number))
    (setq mc--insert-numbers-number (+ mc--insert-numbers-number ladicle/mc/insert-numbers-inc)))
  )

(use-package avy
    :preface
    ;; fixed cursor scroll-up
    (defun scroll-up-in-place (n)
      (interactive "p")
      (forward-line (- n))
      (scroll-down n))
    ;; fixed cursor scroll-down
    (defun scroll-down-in-place (n)
      (interactive "p")
      (forward-line n)
      (scroll-up n))
    ;; yank inner sexp
    (defun yank-inner-sexp ()
      (interactive)
      (backward-list)
      (mark-sexp)
      (copy-region-as-kill (region-beginning) (region-end)))
    :config
    (use-package avy-zap)
    (use-package ace-window
    :custom-face
    (aw-leading-char-face ((t (:height 4.0 :foreground "#f1fa8c"))))
    :preface
    (defvar is-window-maximized nil)
    (defun ladicle/toggle-window-maximize ()
        (interactive)
        (progn
          (if is-window-maximized
              (balance-windows)
            (maximize-window))
          (setq is-window-maximized
                (not is-window-maximized))))
    )
    )

(require 'point-history)
(point-history-mode t)
(require 'ivy-point-history)
(use-package expand-region)
