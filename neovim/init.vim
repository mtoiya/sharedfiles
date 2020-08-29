
"
" plug.vim の設定
"

call plug#begin(stdpath('data') . '/plugged')

" NERDTree
Plug 'scrooloose/nerdtree'

" denite.nvim
if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/denite.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" neomru
"" denite の file_mru ソースを使うのに必要
Plug 'Shougo/neomru.vim'

call plug#end()



"
" プラグインがインストールされているかどうかを判定する関数定義
" from https://qiita.com/b4b4r07/items/fa9c8cceb321edea5da0
"

let s:plug = {
  \ "plugs": get(g:, 'plugs', {})
  \ }
function! s:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction



"
" denite 設定
"

nmap <silent> ,f :<C-u>Denite file/rec<CR>
nmap <silent> ,g :<C-u>Denite grep<CR>
nmap <silent> ,b :<C-u>Denite buffer<CR>
nmap <silent> ,l :<C-u>Denite line<CR>
nmap <silent> ,r :<C-u>Denite file_mru<CR>

" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
    \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
    \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
    \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
    \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
    \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
    \ denite#do_map('toggle_select').'j'
endfunction

if s:plug.is_installed("denite")
  " file/rec に ripgrep を使用する
  call denite#custom#var('file/rec', 'command',
    \ ['rg', '--files', '--glob', '!.git', '--color', 'never'])

  " Floating Window を使用する
  "" https://qiita.com/lighttiger2505/items/d4a3371399cfe6dbdd56
  let s:denite_win_width_percent = 0.85
  let s:denite_win_height_percent = 0.7
  call denite#custom#option('default', {
    \ 'split': 'floating',
    \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
    \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
    \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
    \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
    \ })

endif



inoremap <C-g> <ESC>
set tabstop=4
