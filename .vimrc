syntax on
set nobackup
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
set number
" 改行時に前の行のインデントを継続する
set autoindent
set smarttab
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
let _curfile = expand("%:t")
if _curfile =~ "Makefile" || _curfile =~ "makefile" || _curfile =~ ".*\.mk"
  set noexpandtab
endif
" w!!でsudoで保存
cabbr w!! w !sudo tee > /dev/null %
imap <C-b> <Left>
imap <C-f> <Right>
" かっこ入力時の対応するかっこを表示
set showmatch
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索文字列が小文字の場合は大文字小文字を関係なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nnoremap <Esc><Esc> :nohlsearch<R><esc>
" backspaceの効果追加 indent:字下げ, eol:行末を削除して行を連結, start:開始点を削除
set backspace=indent,eol,start
" yankしたテキストが無名レジスタだけでなく, *レジスタにも入るようにする.
set clipboard+=unnamed
set clipboard+=unnamedplus
" xでyankを上書きされないようにする
nnoremap x "_x
nnoremap X "_X

