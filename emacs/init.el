;; ツールバーを非表示にします。
(custom-set-variables '(tool-bar-mode nil))

;; タブ幅を設定します。
(setq-default tab-width 4)
(setq default-tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))

;; サーバーモードをスタートします。
(server-start)

;; Shellモードの時にzshを使います。
(setq shell-file-name "/bin/zsh")

;; プロキシサーバーの設定
(setq url-using-proxy t)
(setq url-proxy-services '(("http" . "192.168.10.2:8080")))

;; パッケージ取得先URLを追加します。
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)





;; helmの設定

;; helm-miniのキー
(global-set-key (kbd "C-c h") 'helm-mini)

;; helm-modeの設定
(helm-mode 1)





;; auto-completeの設定
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
