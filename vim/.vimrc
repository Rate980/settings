" setting
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" 挿入モードでバックスペースで削除できるようにする
set backspace=indent,eol,start
" vim の矩形選択で文字が無くても右へ進める
set virtualedit=block

" 見た目系
" 行番号を表示
set number
" シンタックスハイライトの有効化
syntax enable
" 現在の行を強調表示
"set cursorline
" インデントはスマートインデント
set smartindent


" Tab系
" 不可視文字を可視化(タブが「-」と表示される)
set list listchars=tab:\\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2


" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch

set runtimepath+=~/.vim/bundle/neobundle.vim/

set virtualedit=onemore
" エンコード
set fileencodings=utf8,cp932
set smartindent
set laststatus=2
set wildmenu
set background=dark
" カーソル設定
if has('vim_starting')
  let &t_SI .= "\e[5 q"
  let &t_EI .= "\e[6 q"  
  let &t_SR .= "\e[3 q"
  let &t_te .= "\e[0 q"
  let &t_ti .= "\e[6 q"
endif
"nomal mode keymap
map Zq ZQ
map Zz ZZ

" dein.vim settings {{{

let g:lightline = {
      \ 'colorscheme': 'one',
      \ }
" install dir {{{
inoremap <silent> jj <ESC>
set noshowmode
let s:dein_dir = expand('$HOME/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}

" dein installation check {{{
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}

" begin settings {{{
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " .toml file
  let s:rc_dir = expand('$HOME/.vim')
  if !isdirectory(s:rc_dir)
    call mkdir(s:rc_dir, 'p')
  endif
  let s:toml = s:rc_dir . '/dein.toml'
  let s:lazy_toml = s:rc_dir . '/dein_lazy.toml'

  " read toml and cache
  if filereadable(s:toml)
    call dein#load_toml(s:toml, {'lazy': 0})
  endif

  if filereadable(s:lazy_toml)
    call dein#load_state(s:lazy_toml, {'lazy': 0})
  endif

  " end settings
  call dein#end()
  call dein#save_state()
endif
" }}}

" plugin installation check {{{
if dein#check_install()
  call dein#install()
endif
" }}}

" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
" }}}
syntax enable
