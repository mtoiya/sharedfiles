;(load-file "~/sharedfiles/emacs/init-package.el")
;(load-file "~/sharedfiles/emacs/init-helm.el")
;(load-file "~/sharedfiles/emacs/init-auto-complete.el")
;(load-file "~/sharedfiles/emacs/init-ffap.el")
;(load-file "~/sharedfiles/emacs/init-other.el")
;(load-file "~/sharedfiles/emacs/init-unix-only.el")
;(load-file "~/sharedfiles/emacs/init-mac-only.el")

;;; テーマを設定する
;(load-theme 'whiteboard t)

;;; 対応する括弧を表示させる
;(show-paren-mode 1)

;;; 現在行に色を付ける
;(global-hl-line-mode t)
;; 色
;(set-face-background 'hl-line "Gray")

;;; 履歴を次回Emacs起動時にも保存する
;(savehist-mode 1)

;;; ログの記録行数を増やす
;(setq message-log-max 10000)

;;; 履歴をたくさん保存する
;(setq history-length 1000)

;;; モードラインに時刻を表示する
;(display-time)

;;; リージョンに色を付ける
;(transient-mark-mode 1)

;;; GCを減らして軽くする（デフォルトの10倍）
;(setq gc-cons-threshold (* 10 gc-cons-threshold))

;;; ミニバッファを再帰的に呼び出せるようにする
;(setq enable-recursive-minibuffers t)

;;; ダイアログボックスを使わないようにする
;(setq use-dialog-box nil)
;(defalias 'message-box 'message)

;;; キーストロークをエコーエリアに早く表示する
;(setq echo-keystrokes 0.1)

;;; 大きいファイルを開こうとした時に警告を発生させる
;;; デフォルトは10MBなので25MBに拡張する
;(setq large-file-warning-threshold (* 25 1024 1024))

;;; ミニバッファで入力を取り消しても履歴に残す
;;; 誤って取り消して入力が失われるのを防ぐため
;(defadvice abort-recursive-edit (before minibuffer-save activate)
;  (when (eq (selected-window) (active-minibuffer-window))
;	(add-to-history minibuffer-history-variable (minibuffer-contents))))
