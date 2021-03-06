"=============================================================================
"    Description: .vimrcサンプル設定
"         Author: anonymous
"  Last Modified: 0000-00-00 00:00
"        Version: 7.40
"=============================================================================
set nocompatible
scriptencoding cp932
" scriptencodingと、このファイルのエンコーディングが一致するよう注意！
" scriptencodingは、vimの内部エンコーディングと同じものを推奨します。
" 改行コードは set fileformat=unix に設定するとunixでも使えます。

" Windowsで内部エンコーディングを cp932以外にしていて、
" 環境変数に日本語を含む値を設定したい場合は Let を使用します。
" Letは vimrc(オールインワンパッケージの場合)と encode.vim で定義されます。
" Let $HOGE=$USERPROFILE.'/ほげ'

" test

"----------------------------------------
" ユーザーランタイムパス設定
"----------------------------------------
" Windows, unixでのruntimepathの違いを吸収するためのもの。
" $MY_VIMRUNTIMEはユーザーランタイムディレクトリを示す。
" :echo $MY_VIMRUNTIMEで実際のパスを確認できます。
if isdirectory($HOME . '/.vim')
  let $MY_VIMRUNTIME = $HOME.'/.vim'
elseif isdirectory($HOME . '\vimfiles')
  let $MY_VIMRUNTIME = $HOME.'\vimfiles'
elseif isdirectory($VIM . '\vimfiles')
  let $MY_VIMRUNTIME = $VIM.'\vimfiles'
endif

" ランタイムパスを通す必要のあるプラグインを使用する場合、
" $MY_VIMRUNTIMEを使用すると Windows/Linuxで切り分ける必要が無くなります。
" 例) vimfiles/qfixapp (Linuxでは~/.vim/qfixapp)にランタイムパスを通す場合
" set runtimepath+=$MY_VIMRUNTIME/qfixapp

"----------------------------------------
" 内部エンコーディング指定
"----------------------------------------
" 内部エンコーディングのUTF-8化と文字コードの自動認識設定をencode.vimで行う。
" オールインワンパッケージの場合 vimrcで設定されます。
" エンコーディング指定や文字コードの自動認識設定が適切に設定されている場合、
" 次行の encode.vim読込部分はコメントアウトして下さい。
" silent! source $MY_VIMRUNTIME/pluginjp/encode.vim
" scriptencodingと異なる内部エンコーディングに変更する場合、
" 変更後にもscriptencodingを指定しておくと問題が起きにくくなります。
" scriptencoding cp932

"----------------------------------------
" neo bundle setting
"----------------------------------------
filetype off

if has("vim_starting")
set rtp+=$HOME/_vim/bundle/neobundle.vim/
call neobundle#rc(expand('~/_vim/bundle'))
endif

" general
NeoBundle "Shougo/neocomplcache"
NeoBundle "Shougo/neosnippet"
NeoBundle "thinca/vim-quickrun" "即時実行

" system
NeoBundle "Shougo/vimproc", {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle "Shougo/vimshell"

" launcher/filer
NeoBundle "Shougo/unite.vim"
NeoBundle "scrooloose/nerdtree" "ファイラ

" edit
NeoBundle "tpope/vim-surround"
NeoBundle "mattn/emmet-vim" "Zen-coding
NeoBundle "scrooloose/nerdcommenter"

" indent
NeoBundle "jiangmiao/simple-javascript-indenter"

" completion
NeoBundle "jsx/jsx.vim" "jsx補完
NeoBundle "teramako/jscomplete-vim" "js補完
NeoBundle "myhere/vim-nodejs-complete" "node補完

" syntax highlight
NeoBundle "tpope/vim-markdown" "markdown
NeoBundle "jelera/vim-javascript-syntax" "javascript
NeoBundle "kchmck/vim-coffee-script" "coffee scropt
NeoBundle "digitaltoad/vim-jade" "jade
NeoBundle "groenewege/vim-less" "less
NeoBundle "scrooloose/syntastic" " シンタックスチェッカ


filetype plugin indent on


"----------------------------------------
" システム設定
"----------------------------------------
" mswin.vimを読み込む
" source $VIMRUNTIME/mswin.vim
" behave mswin

" ファイルの上書きの前にバックアップを作る/作らない
" set writebackupを指定してもオプション 'backup' がオンでない限り、
" バックアップは上書きに成功した後に削除される。
set nowritebackup

" バックアップ設定
set nobackup
if version >= 703
  " 再読込、vim終了後も継続するアンドゥ(7.3)
  " set undofile
  " アンドゥの保存場所(7.3)
  " set undodir=.
endif

" スワップファイル設定
set swapfile
set directory=~/_vim/swp

" viminfoを作成しない
" set viminfo=

" クリップボードを共有
set clipboard+=unnamed

" 8進数を無効にする。<C-a>,<C-x>に影響する
set nrformats-=octal

" キーコードやマッピングされたキー列が完了するのを待つ時間(ミリ秒)
set timeout timeoutlen=3000 ttimeoutlen=100

" 編集結果非保存のバッファから、新しいバッファを開くときに警告を出さない
set hidden

" ヒストリの保存数
set history=50

" 日本語の行の連結時には空白を入力しない
set formatoptions+=mM

" Visual blockモードでフリーカーソルを有効にする
set virtualedit=block

" カーソルキーで行末／行頭の移動可能に設定
set whichwrap=b,s,h,l,[,],<,>

" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start

" □や○の文字があってもカーソル位置がずれないようにする
set ambiwidth=double

" コマンドライン補完するときに強化されたものを使う
set wildmenu

" マウスを有効にする
if has('mouse')
  set mouse=a
endif

" pluginを使用可能にする
filetype plugin indent on

"----------------------------------------
" 検索
"----------------------------------------
" 検索の時に大文字小文字を区別しない
" ただし大文字小文字の両方が含まれている場合は大文字小文字を区別する
set ignorecase
set smartcase

" 検索時にファイルの最後まで行ったら最初に戻る
set wrapscan

" インクリメンタルサーチ
set incsearch

" 検索文字の強調表示
set hlsearch
" w,bの移動で認識する文字
" set iskeyword=a-z,A-Z,48-57,_,.,-,>
" vimgrep をデフォルトのgrepとする場合internal
" set grepprg=internal

"----------------------------------------
" 表示設定
"----------------------------------------
" スプラッシュ(起動時のメッセージ)を表示しない
" set shortmess+=I
" エラー時の音とビジュアルベルの抑制(gvimは.gvimrcで設定)
set noerrorbells
set novisualbell
set visualbell t_vb=
" マクロ実行中などの画面再描画を行わない
" WindowsXpまたはWindowテーマが「Windowsクラシック」で
" Google日本語入力を使用するとIビームカーソルが残る場合にも有効
" set lazyredraw
" Windowsでディレクトリパスの区切り文字表示に / を使えるようにする
set shellslash
" 行番号表示
set number
if version >= 703
  " 相対行番号表示(7.3)
  " set relativenumber
endif

" 括弧の対応表示時間
set showmatch matchtime=1

" カーソル行ハイライト
set cursorline

" タブを設定
" set ts=4 sw=4 sts=4

" tabをspaceに変換
set expandtab

" tabスペース数
set tabstop=2

" 自動的にインデントする
set autoindent

" オートインデント数
set shiftwidth=2

" Cインデントの設定
set cinoptions+=:0

" タイトルを表示
set title

" コマンドラインの高さ (gvimはgvimrcで指定)
" set cmdheight=2
set laststatus=2

" コマンドをステータス行に表示
set showcmd

" 画面最後の行をできる限り表示する
set display=lastline

" Tab、行末の半角スペースを明示的に表示する
set list
set listchars=tab:^\ ,trail:~

" ハイライトを有効にする
if &t_Co > 2 || has('gui_running')
  syntax on
endif

" 色テーマ設定
" gvimの色テーマは.gvimrcで指定する
" colorscheme mylight



""""""""""""""""""""""""""""""
" ステータスラインに文字コード等表示
" iconvが使用可能の場合、カーソル上の文字コードをエンコードに応じた表示にするFencB()を使用
""""""""""""""""""""""""""""""
if has('iconv')
  set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=[0x%{FencB()}]\ (%v,%l)/%L%8P\ 
else
  set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\ 
endif

" FencB() : カーソル上の文字コードをエンコードに応じた表示にする
function! FencB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return s:Byte2hex(s:Str2byte(c))
endfunction

function! s:Str2byte(str)
  return map(range(len(a:str)), 'char2nr(a:str[v:val])')
endfunction

function! s:Byte2hex(bytes)
  return join(map(copy(a:bytes), 'printf("%02X", v:val)'), '')
endfunction

"----------------------------------------
" diff/patch
"----------------------------------------
" diffの設定
if has('win32') || has('win64')
  set diffexpr=MyDiff()
  function! MyDiff()
    " 7.3.443 以降の変更に対応
    silent! let saved_sxq=&shellxquote
    silent! set shellxquote=
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let cmd = '!diff ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
    silent execute cmd
    silent! let &shellxquote = saved_sxq
  endfunction
endif

" 現バッファの差分表示(変更箇所の表示)
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" ファイルまたはバッファ番号を指定して差分表示。#なら裏バッファと比較
command! -nargs=? -complete=file Diff if '<args>'=='' | browse vertical diffsplit|else| vertical diffsplit <args>|endif
" パッチコマンド
set patchexpr=MyPatch()
function! MyPatch()
   call system($VIM."\\'.'patch -o " . v:fname_out . " " . v:fname_in . " < " . v:fname_diff)
endfunction


"----------------------------------------
" ファイルタイプ設定
"----------------------------------------
" ejs -> html
au BufNewFile,BufRead *.ejs set filetype=html

" ---------------------------------------
" 折り畳み設定
" ---------------------------------------
" folding基本設定
set foldenable
"set foldmethod=syntax
set foldmethod=indent
"set foldopen=all  " fold内に移動すれば自動で開く
"set foldclose=all  " fold外に移動しfoldlevelより深ければ閉じる
set foldlevel=10   " 折りたたみの具合
set foldnestmax=10  " 最大折りたたみ深度$
set foldcolumn=2 " 左側に折りたたみガイド表示$



"----------------------------------------
" ノーマルモード
"----------------------------------------
" ヘルプ検索
nnoremap <F1> K

" 現在開いているvimスクリプトファイルを実行
nnoremap <F8> :source %<CR>

" 強制全保存終了を無効化
nnoremap ZZ <Nop>

" カーソルをj k では表示行で移動する。物理行移動は<C-n>,<C-p>
" キーボードマクロには物理行移動を推奨
" h l は行末、行頭を超えることが可能に設定(whichwrap)
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap h <Left>zv
nnoremap j gj
nnoremap k gk
nnoremap l <Right>zv

" SPC+. / .vimrcを開く
nnoremap <Space>.v :<C-u>edit $MYVIMRC<CR>
nnoremap <Space>.g :<C-u>edit $MYGVIMRC<CR>

" SPC + , / source ~/.vimrc を実行する。
nnoremap <Space>,v  :<C-u>source $MYVIMRC<CR>
nnoremap <Space>,g  :<C-u>source $MYGVIMRC<CR>

" , i s / vimshell起動
noremap <silent> ,is :VimShell<CR>

" ウィンドウ移動簡単に
nnoremap <C-J> <C-W>j
nnoremap <C-H> <C-W>h
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" バッファ関連
noremap <C-N> :bnext<CR>
noremap <C-P> :bprevious<CR>

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" ノーマルモードでも改行可能
nnoremap <CR> i<CR><ESC>

" 折り畳み操作
noremap [space] <Nop>
nmap <Space> [space]

noremap [space]j zj
noremap [space]k zk
noremap [space]h ]z
noremap [space]l [z
noremap [space]c zc
noremap [space]o zO
noremap [space]a za
noremap [space]m zM
noremap [space]i zMzv
noremap [space]r zR
noremap [space]f zf


"----------------------------------------
" 挿入モード
"----------------------------------------

"かっこ入力時，中に戻る
inoremap {} {}<Left>
inoremap [] []<Left>
inoremap () ()<Left>
inoremap “” “”<Left>
inoremap ” ”<Left>
inoremap <> <><Left>
inoremap “ “<Left>
inoremap '' ''<Left>
inoremap "" ""<Left>

"insertmodeでのdel,bs
inoremap <C-D> <Del>
inoremap <C-G> <BS>

" insertmode抜ける
inoremap <silent> jj <ESC>
inoremap <silent> kk <ESC>

" insertmodeでも簡単な移動ができるようにする
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-e> <END>
inoremap <C-a> <HOME>
nnoremap <C-e> <END>
nnoremap <C-a> <HOME>
vnoremap <C-e> <END>
vnoremap <C-a> <HOME>

"----------------------------------------
" ビジュアルモード
"----------------------------------------

"----------------------------------------
" コマンドモード
"----------------------------------------

"----------------------------------------
" Vimスクリプト
"----------------------------------------
""""""""""""""""""""""""""""""
" ファイルを開いたら前回のカーソル位置へ移動
" $VIMRUNTIME/vimrc_example.vim
""""""""""""""""""""""""""""""
augroup vimrcEx
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line('$') | exe "normal! g`\"" | endif
augroup END

""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインのカラー変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif
" if has('unix') && !has('gui_running')
"   " ESCですぐに反映されない対策
"   inoremap <silent> <ESC> <ESC>
" endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
    redraw
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

""""""""""""""""""""""""""""""
" 全角スペースを表示
""""""""""""""""""""""""""""""
" コメント以外で全角スペースを指定しているので、scriptencodingと、
" このファイルのエンコードが一致するよう注意！
" 強調表示されない場合、ここでscriptencodingを指定するとうまくいく事があります。
" scriptencoding cp932
function! ZenkakuSpace()
  silent! let hi = s:GetHighlight('ZenkakuSpace')
  if hi =~ 'E411' || hi =~ 'cleared$'
    highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
  endif
endfunction
if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

""""""""""""""""""""""""""""""
" grep,tagsのためカレントディレクトリをファイルと同じディレクトリに移動する
""""""""""""""""""""""""""""""
" if exists('+autochdir')
"   "autochdirがある場合カレントディレクトリを移動
"   set autochdir
" else
"   "autochdirが存在しないが、カレントディレクトリを移動したい場合
"   au BufEnter * execute ":silent! lcd " . escape(expand("%:p:h"), ' ')
" endif

"----------------------------------------
" 各種プラグイン設定
"----------------------------------------

" *************
" NERDTree
" *************
" 自動起動
autocmd Vimenter * NERDTree ./

"ctrl-eでtoggle
nmap <silent> <C-x><C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-x><C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-x><C-e>      :NERDTreeToggle<CR>
imap <silent> <C-x><C-e> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-x><C-e> <C-u>:NERDTreeToggle<CR>

" *********
" neoComplcache
" *********

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" add jsx completion
" jsx.vim の jsx#complete が自動で呼び出されます
if !exists("g:neocomplcache_force_omni_patterns")
    let g:neocomplcache_force_omni_patterns = {}
endif

" . を打った時にオムニ補完が呼び出されるようにする
let g:neocomplcache_force_omni_patterns.jsx = '\.'

" add nodejs completion
autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS
if !exists('g:neocomplcache_omni_functions')
  let g:neocomplcache_omni_functions = {}
endif

 let g:neocomplcache_omni_functions.javascript = 'nodejscomplete#CompleteJS'
 let g:node_usejscomplete = 1
" automatically open and close the popup menu / preview window
 au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
" inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>
" inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
" inoremap <expr><C-e>  neocomplcache#cancel_popup()

" **************
" simple-javascript-indenter
" **************
" この設定入れるとshiftwidthを1にしてインデントしてくれる
let g:SimpleJsIndenter_BriefMode = 1
" この設定入れるとswitchのインデントがいくらかマシに
let g:SimpleJsIndenter_CaseIndentLevel = -1

" ***************
" syntastic
" ***************
" このようにするとjshintを必ず使ってチェックしてくれるようになる
"let g:syntastic_javascript_checker = "jshint"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" ***************
" vim-coffee-script
" ***************
autocmd BufWritePost *.coffee silent make -cb | cwindow | redraw!


" ***************
" vim-ref
" ***************

"----------------------------------------
" 一時設定
"----------------------------------------
