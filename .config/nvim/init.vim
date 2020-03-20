"dein Scripts--------------------------------------------------------
if &compatible
  set nocompatible
endif


let g:python3_host_prog = '/usr/local/bin/python3'

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.config/nvim/')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable

"End dein Scripts----------------------------------------------------
set number
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set clipboard=unnamed
set hls
set smarttab
set smartindent
set clipboard+=unnamedplus
" 置換がインタラクティブになる
set inccommand=split
"makefileの時はtabのままにする
let _curfile = expand("%:t")
if _curfile =~ "Makefile" || _curfile =~ "makefile" || _curfile =~ ".*\.mk"
  set noexpandtab
endif
imap <C-b> <Left>
imap <C-f> <Right>
"no highlight esc x 2
nnoremap <silent><ESC><ESC> :nohl<CR>
"一見意味ないような設定だがcohama/leximal.vimは<BS>を使って設定されているので
"<C-h>もそれと同じように機能させる. inoremapでなくimapでないと機能しない
imap <C-h> <BS>
"()の対応を表示する機能が見づらすぎて死にそうなので切る(terminal上で)
if !has('gui_running')
  let g:loaded_matchparen = 1
endif
"マウスのミドルクリックによる貼り付けは大体不意なのでやめる
map <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>
"w!!でsudoで保存
cabbr w!! w !sudo tee > /dev/null %
" Swapファイル?Backupファイル?前時代的すぎなので全て無効化する
set nowritebackup
set nobackup
set noswapfile
" 一文字消すだけなのに無名レジスタを上書きされるのは嫌なのでブラックホールレジスタに入れる
nnoremap x "_x
nnoremap X "_X

nnoremap j gj
nnoremap k gk

augroup MyAutoCmd
  autocmd!
  autocmd FileType help setlocal number
augroup END

augroup BinaryXXD
  autocmd!
  autocmd BufReadPre *.bin let &binary =1
  " -g 1で1byte表示, defaultは2byte
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END
" tagsでなく./tagsと指定するとカレントディレクトリではなく開いているファイルのディレクトリからtagsファイルを探す
" ;$HOMEとすることでホームディレクトリまで遡ってtagsファイルを探してくれる
set tags=./tags;$HOME
nnoremap <C-]> g<C-]>
inoremap <C-]> g<C-]>
