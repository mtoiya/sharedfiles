;;; タブ幅を設定します
;; デフォルトのタブ幅
(setq-default tab-width 4)
;; TABキー押下時にタブの代わりにスペースを挿入する
(setq-default indent-tabs-mode nil)
;; TABキー押下時にスペース２個を挿入する
(setq-default tab-stop-list (number-sequence 2 120 2))
;; CやC++モードのデフォルトインデントレベル
(setq-default c-basic-offset 4)
;; C/C++/Objective-C/Java等のタブ・インデント設定
(add-hook 'c-mode-common-hook '(lambda () (setq tab-stop-list (number-sequence 4 120 4) indent-tabs-mode t)))

;;; 行番号・桁番号を表示する
(line-number-mode 1)
(column-number-mode 1)

;;; ツールバーとスクロールバーを消す
(tool-bar-mode -1)
(scroll-bar-mode -1)

;;; シェルに合わせるため、C-hは後退に割り当てる
;;; ヘルプは<f1>も使えるので
(global-set-key (kbd "C-h") 'delete-backward-char)

;;; yesと入力するのは面倒なのでyで十分
(defalias 'yes-or-no-p 'y-or-n-p)

;;; ファイル内のカーソル位置を記憶する
(setq-default save-place t)
(require 'saveplace)

;;; サーバーモードをスタートします
(server-start)
