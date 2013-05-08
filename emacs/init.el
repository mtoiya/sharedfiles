;;;; package

;; パッケージ取得先URLを追加します。
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)





;;;; helm

;; helm-miniのキー
(global-set-key (kbd "C-c h") 'helm-mini)

;; helm-modeの設定
(helm-mode 1)





;;;; auto-complete

(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)





;;;; ffap

(ffap-bindings)





;;;; gtags

(require 'gtags)
(add-hook 'c-mode-common-hook 'gtags-mode)
(add-hook 'c++-mode-hook 'gtags-mode)





;;;; color-theme

(require 'color-theme)
;(eval-after-load "color-theme"
;  '(progn
;     (color-theme-initialize)
;     (color-theme-hober)))     ; ここに好きなテーマを書く





;;;; Unix専用の設定

;; Shellモードの時にzshを使う。
(setq shell-file-name "/bin/zsh")





;;;; Mac特有の設定

(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))





;;;; org-remember

(require 'org)
(org-remember-insinuate)
;; メモを格納するorgファイルの設定
(setq org-directory "~/Dropbox/Documents/")
(setq org-default-notes-file (expand-file-name "memo.org" org-directory))
;; テンプレートの設定
(setq org-remember-templates
      '(("Note" ?n "** %?\n   %T" nil "Inbox")
        ("Todo" ?t "** TODO %?\n   %T" nil "Inbox")))





;;;; auto-async-byte-compile

(require 'auto-async-byte-compile)
;; 自動バイトコンパイルを無効にするファイル名の正規表現
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)





;;;; migemo

(require 'migemo)
;; cmigemoを使う
(setq migemo-command "~/bin/cmigemo")
(setq migemo-options ' ("-q" "--emacs"))
;; migemo-dictのパスを設定
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)





;;;; color-moccur

(require 'color-moccur)
;; スペースで区切られた複数の単語にマッチさせる
(setq moccur-split-word t)





;;;; ediff

;; Ediff Control Panel専用のフレームを作成しないようにする
(setq ediff-window-setup-function 'ediff-setup-windows-plain)





;;;; MacのIME用設定（専用のパッチを当ててビルドしていないと機能しない）

(mac-input-method-mode t)

;;; カーソル色を変更する
;(mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" 'cursor-color 'red)
;(mac-set-input-method-parameter "com.google.inputmethod.Japanese.Roman" 'cursor-color 'green)

;; カーソルタイプを変更する
;(mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" 'cursor-type 'box)

;; タイトルを変更する
;(mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" 'title "J")





;;;; エイリアス

(defalias 'qrr 'query-replace-regexp) ; 正規表現置換
(defalias 'lf 'load-file)
(defalias 'lt 'load-theme)





;;;; その他の設定

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

;;; テーマを設定する
;(load-theme 'whiteboard t)

;;; 対応する括弧を表示させる
(show-paren-mode 1)

;;; 他のウィンドウへ移動するコマンドの実行を楽にする
(global-set-key (kbd "C-t") 'other-window)

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
