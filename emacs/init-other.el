;; タブ幅を設定します。
(setq-default tab-width 4)
(setq default-tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))

;; サーバーモードをスタートします。
(server-start)

;;; 現在行に色を付ける
;(global-hl-line-mode t)
;; 色
;(set-face-background 'hl-line "Gray")

;;; 履歴を次回Emacs起動時にも保存する
;(savehist-mode 1)

;;; ファイル内のカーソル位置を記憶する
(setq-default save-place t)
(require 'saveplace)

;;; 対応する括弧を表示させる。
(show-paren-mode 1)

;;; シェルに合わせるため、C-hは後退に割り当てる
;;; ヘルプは<f1>も使えるので
(global-set-key (kbd "C-h") 'delete-backward-char)

;;; モードラインに時刻を表示する
;(display-time)

;;; 行番号・桁番号を表示する
(line-number-mode 1)
(column-number-mode 1)

;;; リージョンに色を付ける
;(transient-mark-mode 1)

;;; GCを減らして軽くする（デフォルトの10倍）
;(setq gc-cons-threshold (* 10 gc-cons-threshold))

;;; ログの記録行数を増やす
;(setq message-log-max 10000)

;;; ミニバッファを再帰的に呼び出せるようにする
;(setq enable-recursive-minibuffers t)

;;; ダイアログボックスを使わないようにする
;(setq use-dialog-box nil)
;(defalias 'message-box 'message)

;;; 履歴をたくさん保存する
(setq history-length 1000)

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

;;; yesと入力するのは面倒なのでyで十分
(defalias 'yes-or-no-p 'y-or-n-p)

;;; ツールバーとスクロールバーを消す
(tool-bar-mode -1)
(scroll-bar-mode -1)
