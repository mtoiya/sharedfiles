;;;; 各環境ごとの設定を書いたファイルのロード

;; 以下の変数が定義されていることを前提としている
;;   tse-p
(when (file-exists-p "~/.emacs.d/my-config")
  (load-file "~/.emacs.d/my-config"))





;;;; 環境の判定に使う変数の定義

(setq darwin-p  (eq system-type 'darwin)
      ns-p      (eq window-system 'ns)
      linux-p   (eq system-type 'gnu/linux)
      cygwin-p  (eq system-type 'cygwin)
      nt-p      (eq system-type 'windows-nt)
      windows-p (or cygwin-p nt-p)
      unix-p    (or darwin-p linux-p cygwin-p))





;;;; エイリアス定義

(defalias 'bcf 'byte-compile-file)
(defalias 'lf 'load-file)
(defalias 'lt 'load-theme)
(defalias 'obm 'occur-by-moccur)
(defalias 'plp 'package-list-packages)
(defalias 'plpn 'package-list-packages-no-fetch)
(defalias 'qrr 'query-replace-regexp) ; 正規表現置換
(defalias 'rb 'revert-buffer)
(defalias 'ssn 'shell-switcher-new-shell)
(defalias 'tff 'toggle-frame-fullscreen)
(defalias 'tfm 'toggle-frame-maximized)





;;;; いろいろな設定

;;; requireに失敗してもエラーにならないようにする対応

;; 未インストールのパッケージをrequireしてもエラーにしない関数定義
(defun require-safe (pkg)
  (let ((val (require pkg nil t)))
    (if val
        val
      (progn (warn (concat "failed to require: " (symbol-name pkg)))
             nil))))
;; requireに成功した時にのみ実行する処理を簡単に書くためのマクロ
(defmacro when-required (pkg &rest body)
  (declare (indent 1))
  `(when (require-safe ,pkg)
     ,@body))

;; kill-ring-save-whole-lineのキー割り当て
(global-set-key (kbd "M-W") 'kill-ring-save-whole-line)

;;; タブ幅を設定します
;; デフォルトのタブ幅
(setq-default tab-width 4)
;; TABキー押下時にタブの代わりにスペースを挿入する
;(setq-default indent-tabs-mode nil)
;; TABキー押下時にスペース２個を挿入する
;(setq-default tab-stop-list (number-sequence 2 120 2))
;; CやC++モードのデフォルトインデントレベル
;(setq-default c-basic-offset 4)
;; C/C++/Objective-C/Java等のタブ・インデント設定
;(add-hook 'c-mode-common-hook '(lambda () (setq tab-stop-list (number-sequence 4 120 4) indent-tabs-mode t)))

;; インデントスタイル
(setq c-default-style "stroustrup")

;;; 行番号・桁番号を表示する
(line-number-mode 1)
(column-number-mode 1)

;;; ツールバーとスクロールバーを消す
(tool-bar-mode -1)
(when (not cygwin-p)
  (scroll-bar-mode -1))

;;; シェルに合わせるため、C-hは後退に割り当てる
;;; ヘルプは<f1>も使えるので
(global-set-key (kbd "C-h") 'delete-backward-char)

;;; yesと入力するのは面倒なのでyで十分
(defalias 'yes-or-no-p 'y-or-n-p)

;;; ファイル内のカーソル位置を記憶する
(setq-default save-place t)
(require 'saveplace)

;; 最近のファイル1000個を保存する
(setq recentf-max-saved-items 1000)

;; 最近使ったファイルに加えないファイルを正規表現で指定する
;(setq recentf-exclude '("/TAGS$" "/var/tmp/"))

;; 起動時に*GNU Emacs*バッファを表示しないようにする
(setq inhibit-startup-message t)

;; scratchバッファの空にします
(setq initial-scratch-message "")

;;; Shellモードの時にzshを使う。
(when unix-p
  (setq shell-file-name "/bin/zsh"))

;;; Macのメタキーの設定
(when ns-p
  (setq ns-command-modifier (quote meta))
  (setq ns-alternate-modifier (quote super)))

;;; サーバーモードをスタートします
(server-start)

;; emacsclientから開いたバッファを閉じる機能を「C-x C-c」に割り当てる。
(global-set-key (kbd "C-x C-c") 'server-edit)
;; 逆にEmacsの終了方法を変更する。
(defalias 'quit 'save-buffers-kill-emacs)

;;; 対応する括弧を表示させる
(show-paren-mode 1)

;;; 他のウィンドウへ移動するコマンドの実行を楽にする
(global-set-key (kbd "C-l") 'other-window)

;;; view-modeの切り替えを楽にする
(global-set-key (kbd "C-j") 'view-mode)
;; jk同時押しでview-mode切り替え
;(key-chord-define-global "jk" 'view-mode)

;;; 直前のバッファに移動する
(global-set-key (kbd "C-^") '(lambda () (interactive) (switch-to-buffer nil)))

;;; フォント設定（http://sakito.jp/emacs/emacs23.htmlから）
(when ns-p
  (when (>= emacs-major-version 23)
    (set-face-attribute 'default nil
                        :family "monaco"
                        :height 120)
    (set-fontset-font
     (frame-parameter nil 'font)
     'japanese-jisx0208
     '("Hiragino Maru Gothic Pro" . "iso10646-1"))
    (set-fontset-font
     (frame-parameter nil 'font)
     'japanese-jisx0212
     '("Hiragino Maru Gothic Pro" . "iso10646-1"))
    (set-fontset-font
     (frame-parameter nil 'font)
     'mule-unicode-0100-24ff
     '("monaco" . "iso10646-1"))
    (setq face-font-rescale-alist
          '(("^-apple-hiragino.*" . 1.2)
            (".*osaka-bold.*" . 1.2)
            (".*osaka-medium.*" . 1.2)
            (".*courier-bold-.*-mac-roman" . 1.0)
            (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
            (".*monaco-bold-.*-mac-roman" . 0.9)
            ("-cdac$" . 1.3)))))

;;; バックアップファイルを作成する場所
(if unix-p
    (setq backup-directory-alist
          (cons (cons "\\.*$" (expand-file-name "~/tmp"))
                backup-directory-alist))
  (when nt-p
    (setq backup-directory-alist
          (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
                backup-directory-alist))))

;; Alt+`で英語／日本語を切り替えた時に出るエラーメッセージを無視する設定。
(when nt-p
  (global-set-key [M-kanji] 'ignore)
  (global-set-key [kanji] 'ignore))

;; revert-buffer時、バッファが編集中でない場合は確認しない（すべてのファイルを対象としている）。
(setq revert-without-query (list ".*"))

;; exec-pathの設定
(when darwin-p
  (add-to-list 'exec-path "/usr/local/bin"))

;; Proxyサーバーの設定
(when tse-p
  (setq url-using-proxy t)
  (setq url-proxy-services '(("http" . "192.168.10.2:8080"))))





;;;; package

;; パッケージ取得先URLを追加します。
(when-required 'package
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (package-initialize))





;;;; auto-async-byte-compile

(when-required 'auto-async-byte-compile
  ;; 自動バイトコンパイルを無効にするファイル名の正規表現
  (setq auto-async-byte-compile-exclude-files-regexp "/junk/")
  (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode))





;;;; key-chord

(when-required 'key-chord
  (setq key-chord-two-keys-delay 0.04)
  (key-chord-mode 1))





;;;; helm

(global-set-key (kbd "C-c j") 'helm-for-files)
(global-set-key (kbd "C-t") 'helm-mini)

;; helm-modeの設定
;(helm-mode 1)





;;;; helm-ag

(when-required 'helm-ag
  (global-set-key (kbd "C-c k") 'helm-ag)
  (global-set-key (kbd "C-c K") 'helm-ag-pop-stack)
  (global-set-key (kbd "C-c C-k") 'helm-ag-this-file))





;;;; auto-complete

(when-required 'auto-complete
  (when-required 'auto-complete-config
	(global-auto-complete-mode t)

	;; 自動で候補を表示しないようにする
	(setq ac-auto-start nil)
	;; その代わりTAB（C-i）キーで候補を出せるようにする
	(ac-set-trigger-key "TAB")))





;;;; ffap

(ffap-bindings)





;;;; gtags

(when-required 'gtags
  (add-hook 'c-mode-common-hook 'gtags-mode)
  (add-hook 'c++-mode-hook 'gtags-mode))





;;;; color-theme

(when (not (eq window-system nil))
  (when-required 'color-theme
	(eval-after-load "color-theme"
	  '(progn
		 (color-theme-initialize)
		 ;; この下に好きなテーマを書く
		 (color-theme-snowish)
		 ;(color-theme-sitaramv-solaris)
		 ))))





;;;; uniquify

(when-required 'uniquify
  ;; filename<dir>形式のバッファ名にする
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
  ;; *で囲まれたバッファ名は対象外にする
  (setq uniquify-ignore-buffers-re "*[^*]+*"))





;;;; bm

;(setq bm-restore-repository-on-load t)
(when-required 'bm
  (setq-default bm-buffer-persistence t)
  (setq bm-repository-file "~/.emacs.d/.bm-repository")
  (add-hook' after-init-hook 'bm-repository-load)
  (add-hook 'find-file-hooks 'bm-buffer-restore)
  (add-hook 'kill-buffer-hook 'bm-buffer-save)
  (add-hook 'after-save-hook 'bm-buffer-save)
  (add-hook 'after-revert-hook 'bm-buffer-restore)
  (add-hook 'vc-before-checkin-hook 'bm-buffer-save)
  (add-hook 'kill-emacs-hook '(lambda nil
								(bm-buffer-save-all)
								(bm-repository-save)))
  (global-set-key (kbd "M-@") 'bm-toggle)
  (global-set-key (kbd "M-[") 'bm-previous)
  (global-set-key (kbd "M-]") 'bm-next))





;;;; shell-switcher

(when-required 'shell-switcher
  (setq shell-switcher-mode t))





;;;; viewer

(when-required 'viewer

  ;; 特定のファイルをview-modeで開く
  (setq view-mode-by-default-regexp "\.log$") ; 全ファイルを対象にする

  ;; すべてのファイルをview-modeで開く
										;(viewer-aggressive-setup 'force) ; これが何故か効かない

  ;; 書き込み不能ファイルでview-modeから抜けなくなる
  (viewer-stay-in-setup)

  ;; view-modeの時にモードラインに色を付ける
										;(setq viewer-modeline-color-unwritable "tomato"
										;      viewer-modeline-color-view "orange")
										;(viewer-change-modeline-color-setup)

  ;; こうしないとview-modeを切り替えた時にモードラインの色が変わらなかった。
										;(add-hook 'view-mode-hook 'viewer-change-modeline-color)
  )





;;;; org-remember

(when-required 'org
  (when-required 'org-remember

	(org-remember-insinuate)

	;; メモを格納するorgファイルの設定
	(if darwin-p
		(setq org-directory "~/Dropbox/Documents/")
	  (when nt-p
		(setq org-directory "~/Dropbox/Documents/"))) ; HOME環境変数が設定されていることが前提

	(setq org-default-notes-file (expand-file-name "memo.org" org-directory))

	;; テンプレートの設定
	(setq org-remember-templates
		  '(("Note" ?n "** %?\n   %T" nil "Inbox")
			("Todo" ?t "** TODO %?\n   %T" nil "Inbox")))))





;;;; migemo

(when-required 'migemo

  ;; cmigemoを使う
  (if unix-p
	  (setq migemo-command "~/bin/cmigemo")
	(when nt-p
	  (setq migemo-command "C:/Applications/cmigemo-default-win64/cmigemo")))

  (setq migemo-options ' ("-q" "--emacs"))

  ;; migemo-dictのパスを設定
  (if darwin-p
	  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
	(when nt-p
	  (setq migemo-dictionary "C:/Applications/cmigemo-default-win64/dict/cp932/migemo-dict")))

  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)

  (if unix-p
	  (setq migemo-coding-system 'utf-8)
	(when nt-p
	  (setq migemo-coding-system 'cp932))))





;;;; color-moccur

(when-required 'color-moccur
  ;; スペースで区切られた複数の単語にマッチさせる
  (setq moccur-split-word t))





;;;;  recentf-ext

(require-safe 'recentf-ext)





;;;; point-undo

(when-required 'point-undo
  (define-key global-map (kbd "<f7>") 'point-undo)
  (define-key global-map (kbd "S-<f7>") 'point-redo))





;;;; ediff

(require 'ediff)

;; Ediff Control Panel専用のフレームを作成しないようにする
(setq ediff-window-setup-function 'ediff-setup-windows-plain)





;;;; view

(require 'view)

;; less感覚の操作
(define-key view-mode-map (kbd "N") 'View-search-last-regexp-backward)
(define-key view-mode-map (kbd "?") 'View-search-regexp-backward)
(define-key view-mode-map (kbd "G") 'View-goto-line-last)
(define-key view-mode-map (kbd "b") 'View-scroll-page-backward)
(define-key view-mode-map (kbd "f") 'View-scroll-page-forward)

;; vi/w3m感覚の操作
(define-key view-mode-map (kbd "h") 'backward-char)
(define-key view-mode-map (kbd "j") 'next-line)
(define-key view-mode-map (kbd "k") 'previous-line)
(define-key view-mode-map (kbd "l") 'forward-char)
(define-key view-mode-map (kbd "J") 'View-scroll-line-forward)
(define-key view-mode-map (kbd "K") 'View-scroll-line-backward)

;; bm.elの設定
(when-required 'bm
  (define-key view-mode-map (kbd "m") 'bm-toggle)
  (define-key view-mode-map (kbd "[") 'bm-previous)
  (define-key view-mode-map (kbd "]") 'bm-next))





;;;; markdown

(when nt-p
  (setq markdown-command "kramdown"))





;;;; yasnippet

(when-required 'yasnippet

  ;; スニペット置き場を追加する。
  (add-to-list 'yas-snippet-dirs "~/.emacs.d/my-snippets")

  (yas-global-mode 1))





;;;; elscreen

(when-required 'elscreen
  ;; プレフィックスキーの設定
  (elscreen-set-prefix-key "\C-q"))





;;;; 関数

;; １行をキルリングに追加する。
;; ※実行すると編集状態になってしまう問題があるので、下のキーボードマクロで対応することにした。
;(defun kill-ring-save-whole-line (&optional arg)
;  "Save current line as if killed."
;  (interactive "p")
;  (let (linenum (line-number-at-pos))
;    (kill-whole-line arg)
;    (yank)
;    ;(goto-line linenum)
;    ))





;;;; キーボードマクロ

(fset 'kill-ring-save-whole-line
   [?\C-a ?\C-  ?\C-e ?\M-w ?\C-a])





;;;; その他の設定


;;; 起動時に最大化する
;(toggle-frame-maximized) ; <M-f10>で可能なので起動時自動実行しなくても良さそう

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

;;; MacのIME用設定（専用のパッチを当ててビルドしていないと機能しない）
;(mac-input-method-mode t)
;;; カーソル色を変更する
;(mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" 'cursor-color 'red)
;(mac-set-input-method-parameter "com.google.inputmethod.Japanese.Roman" 'cursor-color 'green)
;; カーソルタイプを変更する
;(mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" 'cursor-type 'box)
;; タイトルを変更する
;(mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" 'title "J")
