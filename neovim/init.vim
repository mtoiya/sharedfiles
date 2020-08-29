
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
" denite 設定
"

nmap <silent> ,f :<C-u>Denite file/rec<CR>
nmap <silent> ,g :<C-u>Denite grep<CR>
nmap <silent> ,b :<C-u>Denite buffer<CR>
nmap <silent> ,l :<C-u>Denite line<CR>
nmap <silent> ,m :<C-u>Denite file_mru<CR>

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

" file/rec に ripgrep を使用する
call denite#custom#var('file/rec', 'command',
\ ['rg', '--files', '--glob', '!.git', '--color', 'never'])



inoremap <C-g> <ESC>
set tabstop=4
