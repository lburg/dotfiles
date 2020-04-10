" Uses vim settings instead of vi
set nocompatible

" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" ============== Vundle ===============

Plugin 'gmarik/Vundle.vim'

Plugin 'rbgrouleff/bclose.vim.git'
Plugin 'ctrlpvim/ctrlp.vim.git'
Plugin 'd11wtq/ctrlp_bdelete.vim.git'
Plugin 'myusuf3/numbers.vim.git'
Plugin 'saltstack/salt-vim.git'
Plugin 'itchyny/lightline.vim'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat.git'
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-unimpaired.git'
Plugin 'wesQ3/vim-windowswap.git'
Plugin 'w0rp/ale'

" Syntax plugins
Plugin 'sheerun/vim-polyglot'  " Collection of syntax highlighting plugins

" Vim orgmode and dependencies/QoL
Plugin 'jceb/vim-orgmode'
Plugin 'vim-scripts/utl.vim'  " Hyperlinks support
Plugin 'majutsushi/tagbar'  " Source code explorer, used for tags
Plugin 'tpope/vim-speeddating'  " C-a/C-x dates
Plugin 'mattn/calendar-vim'  " Calendar window for timestamp insertion
Plugin 'vim-scripts/SyntaxRange'  " Allow for different syntax highlighting in a file

call ctrlp_bdelete#init()


" ============== General ==============
set background=dark " Dark solarized mode
set autoread        " Automatically reload changed files
set ruler           " Display line number, column number, etc.. of the cursor
set history=1000    " Store up to a 1000 :cmd
set showcmd         " Show incomplete command in the bottom right corner
set showmode        " Show current mode at the bottom
set gcr=a:blinkon0  " Disable cursor blink
set hidden          " Do not write changes when changing buffers (and conserves editing history)
syntax enable       " Syntax highlighting
set encoding=utf8   " Set the encoding to utf-8
set autochdir       " Changes directory when opening a file in a subdirectory
set number          " Displays line numbers
set title           " Change the terminal's title to show the focused opened file
set laststatus=2    " Always show the statusline

set t_Co=16         " Use 16 colors (required for solarized to work well in tmux)
let g:solarized_termcolors = 16 " Not sure if this is required, but I keep it to know it exists
colorscheme solarized

" Smartly join comments lines
if v:version > 703 || v:version == 703 && has('patch541')
    set formatoptions+=j
endif

" Mark long lines as an error (more than 120 characters)
match ErrorMsg '\%>120v.\+'
" Mark trailing spaces as a error
match ErrorMsg '\s\+$'

" Macro to insert python debug line
let @d = "Oimport ipdb; ipdb.set_trace(),w"
let @e = "Oimport epdb; epdb.serve(port=5555),w"

" Change the mapleader from '\' to ','
let mapleader=","

" Allow quick edit/reload of the .vimrc file
nnoremap <silent> <leader>ev :edit $MYVIMRC<CR>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>

" Prevents vim from unindenting the line if it starts with '#'
inoremap # X#

" Make EMACS-like shortcuts available in vim commandline
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>d <S-right><Delete>
cnoremap <C-g>  <C-c>

" Prevent the command-line window from opening
map q: :q

" Toggle paste mode
set pastetoggle=<F2>

" :diffthis shortcut
nnoremap <leader>dt :diffthis<CR>
nnoremap <leader>do :diffoff<CR>

" j and k go up exactly one row, even if the line spans multiple rows
nnoremap j gj
nnoremap k gk

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Auto resize of panels (thx tom_ahh)
set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=10
set winminheight=10
set winheight=999

" Make Y behave like C and D
nnoremap Y y$

" Fast saving
nnoremap <leader>w :w!<cr>

" Sudo write
cmap w!! w !sudo tee % >/dev/null

" Highlights the currently selected line
set cursorline
" Disable underlining the cursor line number
highlight CursorLineNr cterm=NONE
"hi CursorLine   cterm=NONE ctermbg=black
"hi CursorColumn cterm=NONE ctermbg=black


" ============== Syntax ==============

" Map cpp file to cpp11
au BufNewFile,BufRead *.cpp set syntax=cpp11

" Map .md to markdown
au BufRead,BufNewFile *.md set filetype=markdown

" Map .yaml to vim-yaml
au BufNewFile,BufRead *.yaml,*.yml set syntax=yaml

" Map HTML to jinja syntax
au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja

" ============== Search ==============
set wildmenu                                    " Enable the search menu
set wildmode=longest,list,full                  " Bash like autocompletion on tab in the command line
set wildignore+=*.o,*~,*.pyc,*.swp,*.so,*.out   " Files to ignore when searching
set incsearch                                   " Incremental search
set hlsearch                                    " Highlight search matches
set viminfo='100,f1                             " Save up to 100 marks, enable capital marks

" Quickly deactivates search highlighting
nmap <silent> <leader>/ :nohlsearch<CR>

" Centers the buffer on the next/previous item in a search
nnoremap n nzz
nnoremap N Nzz

" Ignore search case, except if there is upper case characters in the search
" pattern (/Foo will not find "foo", but /foo will find "foo" or "Foo")
set ignorecase
set smartcase

" ============== Persistent Undo ==============
" Keep undo history across sessions, by storing in file.
silent !mkdir ~/.vim/undos > /dev/null 2>&1
set undodir=~/.vim/undos
set undofile

" ============== Backups ==============
" Save backups in a decicated folder, to reduce risks of deleting the source file along with its backups
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set backupdir=~/.vim/backups//,.
set backup

" ============== Formatting ===============
set autoindent      " Automatically indents on newline based on previous one
set copyindent      " Copy the previous indentation on autoindenting
set smartindent     " Indent automatically inside blocks
set smarttab        " Use shiftwidth for the beginning of a line, (soft)tabstop otherwise
set shiftwidth=4    " Space to insert at beginning of line
set shiftround      " Use multiple of shiftwidth when indenting with '<' or '>'
set tabstop=4       " Space to insert..
set softtabstop=4   " ..anywhere else
set expandtab       " Use a number of space for tabs

set cino+=(0        " Aligns parentheses content on newline
set cino+=N-s       " Prevents indentation within namespace
set cinoptions+=g0  " Prevent access specifier indentation in C++ class

" Detects the opened file type and applies syntax highlighting etc..
" accordingly
filetype on         " filetype detection
filetype plugin on  " filetype specific plugins
filetype indent on  " filetype indentation

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap
" 120 characters max per line
set textwidth=120

" ============== Scrolling ==============
set scrolloff=3
set sidescrolloff=15
set sidescroll=1

" Disables arrow keys
"for prefix in ['i', 'n', 'v']
"    for key in ['<Up>', '<Down>', '<Left>', '<Right>']
"        exe prefix . "noremap " . key . " <Nop>"
"    endfor
"endfor

" ================= ALE =================

let g:ale_lint_on_save=1
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_enter=0

let g:ale_sign_error='⊘'
let g:ale_sign_warning='⚠'

let g:ale_echo_msg_info_str='I'
let g:ale_echo_msg_warning_str='W'
let g:ale_echo_msg_error_str='E'
let g:ale_echo_msg_format='[%linter%] %code%: %s [%severity%]'

let g:ale_linters={
\   'javascript': ['eslint'],
\   'pug': ['puglint'],
\   'python': ['flake8', 'pylint'],
\   'yaml': ['yamllint'],
\}

let g:ale_python_flake8_options='--ignore=E128,W503 --max-line-length=120'

" ================ CtrlP ================
let g:ctrlp_cmd='CtrlPBuffer'
let g:ctrlp_custom_ignore='node_modules'

" =============== Vim-org ===============

" Open hyperlinks using firefox
let g:utl_cfg_hdl_scm_http_system = "silent !firefox -remote 'ping()' && firefox -remote 'openURL( %u )' || firefox '%u#%f' &"

" =============== Tagbar ==================

nmap <F8> :TagbarToggle<CR>

" =============== lightline ===============

set noshowmode  " hide default mode information (i.e. -- INSERT --)
let g:lightline = {'colorscheme': 'solarized'}
