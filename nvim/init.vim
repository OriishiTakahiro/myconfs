let g:python3_host_prog = $PYENV_ROOT . '/shims/python3'
let g:python_host_prog = $PYENV_ROOT . '/shims/python'

autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
autocmd BufNewFile,BufRead *.uml setlocal filetype=uml
autocmd BufNewFile,BufRead *.tf setlocal filetype=terraform
autocmd BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
let g:tex_flavor='latex'

autocmd FileType go setlocal noexpandtab
autocmd FileType go setlocal tabstop=4
autocmd FileType go setlocal shiftwidth=4

"dein Scripts-----------------------------
if !&compatible
  set nocompatible               " Be iMproved
endif

let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
	let s:toml = '~/.config/nvim/dein-plugins.toml'
	let s:toml_lazy = '~/.config/nvim/dein-lazy-plugins.toml'

if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

if dein#load_state(s:dein_repo_dir)
  call dein#begin(s:dein_repo_dir)

	call dein#load_toml(s:toml, {'lazy' : 0})
	call dein#load_toml(s:toml_lazy, {'lazy' : 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()	" if found plugins which are not installed yet.
	call dein#install()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------
"
set number								" dsiplay line number
set wrap
set encoding=utf-8				" specify encoding
set fileencoding=utf-8		" specify file encoding
set ambiwidth=double      " prevent garbled
set clipboard+=unnamed		" share clipboard with OS
set vb t_vb=							" unable beep sound
set novisualbell					" unable screen flash
set mouse=a								" enable using mouse
set nostartofline					" unable moving to line head automatically when you move to other line

" for syntax highlighter
syntax on									" us syntax highlight
syntax enable							" enable syntax highlight
set cursorline						" highlights a editing line
set hlsearch							" highlights search results
set showmatch							" hilights correspondence of parentheses
set matchpairs& matchpairs+=<:>
set list                  " visualize invisible characters 
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

" safety measures for multi-byte space
syn sync fromstart
function! ActivateInvisibleIndicator()
    syntax match InvisibleJISX0208Space "　" display containedin=ALL                            " display multi-byte space as 　.
    highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=darkgray gui=underline
endfunction
augroup invisible
    autocmd! invisible
    autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
augroup END

" tab, indent
set tabstop=2							" set display size of tab to 2
set expandtab							" expand tab to space
set autoindent						" indent automatically
set shiftwidth=2					" indent size by autoindent
set smartindent						" 改行時に行末にあわせてインデント幅を増減させる
set breakindent						" 折り返し行もインデント

" 検索関係
set incsearch							" インクリメンタルサーチ
set noignorecase					" 検索時に大文字と小文字を区別しない
set smartcase							" noignorecase有効時に検索する語句に大文字が入っている場合のみ、大文字小文字を区別しない

" カーソル関係
set scrolloff=8						" 上下スクロール時に8字を常に表示
set sidescrolloff=16			" 左右スクロール時に16字を常に表示

" ファイル処理関係
set confirm    						" 保存されていないファイルがあるときは終了前に保存確認
set hidden     						" 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread   						"外部でファイルに変更がされた場合は読みなおす
set nobackup 							" ファイル保存時にバックアップファイルを作らない
set nowritebackup 				" ファイル保存時にバックアップファイルを作らない
set noswapfile						" ファイル編集中にスワップファイルを作らない
set hidden								" バッファ切り替え時に変更点を自動でファイルに保存

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Transparent konsole's background
augroup SetTransparentBG
  autocmd!
  autocmd Colorscheme * highlight! Normal ctermbg=NONE guibg=NONE
  autocmd Colorscheme * highlight! NonText ctermbg=NONE guibg=NONE
  autocmd Colorscheme * highlight! LineNr ctermbg=NONE guibg=NONE
  autocmd Colorscheme * highlight! Folded ctermbg=NONE guibg=NONE
  autocmd Colorscheme * highlight! EndOfBuffer ctermbg=NONE guibg=NONE
augroup END
" color schema
 colorscheme atom-dark
