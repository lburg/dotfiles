" Uses vim settings instead of vi
set nocompatible

" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" ============== Vundle ===============

Plugin 'VundleVim/Vundle.vim'

Plugin 'rbgrouleff/bclose.vim.git'
Plugin 'ctrlpvim/ctrlp.vim.git'
Plugin 'd11wtq/ctrlp_bdelete.vim.git'
Plugin 'myusuf3/numbers.vim.git'
Plugin 'saltstack/salt-vim.git'
Plugin 'itchyny/lightline.vim'
" Plugin 'altercation/vim-colors-solarized.git'
Plugin 'morhetz/gruvbox'
Plugin 'shinchu/lightline-gruvbox.vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-dispatch'
Plugin 'tartansandal/vim-compiler-pytest'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'junegunn/gv.vim'  " git commit browser, requires vim-fugitive
Plugin 'tpope/vim-repeat.git'
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-unimpaired.git'
Plugin 'wesQ3/vim-windowswap.git'
Plugin 'w0rp/ale'
Plugin 'maximbaz/lightline-ale'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-test/vim-test'

" Language plugins
Plugin 'sheerun/vim-polyglot'  " Collection of syntax highlighting plugins
Plugin 'neoclide/coc.nvim'  " Powerful code completion, exploration and manipulation

" Vim orgmode and dependencies/QoL
Plugin 'jceb/vim-orgmode'
Plugin 'vim-scripts/utl.vim'  " Hyperlinks support
Plugin 'majutsushi/tagbar'  " Source code explorer, used for tags
Plugin 'tpope/vim-speeddating'  " C-a/C-x dates
Plugin 'mattn/calendar-vim'  " Calendar window for timestamp insertion
Plugin 'vim-scripts/SyntaxRange'  " Allow for different syntax highlighting in a file

call ctrlp_bdelete#init()


" ============== General ==============
set background=dark " Dark mode
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

" set t_Co=16         " Use 16 colors (required for solarized to work well in tmux)
" let g:solarized_termcolors = 16 " Not sure if this is required, but I keep it to know it exists
colorscheme gruvbox

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

" Reselect pasted text
nnoremap gp `[v`]

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

" Quickly jump between errors/warnings
nmap <silent> [w <Plug>(ale_previous_wrap)
nmap <silent> ]w <Plug>(ale_next_wrap)

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
let g:lightline = {
\   'colorscheme': 'gruvbox',
\}

" ============= lightline ALE =============

let g:lightline.component_expand = {
\   'linter_checking': 'lightline#ale#checking',
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'linter_ok': 'lightline#ale#ok',
\}

let g:lightline.component_type = {
\   'linter_checking': 'left',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error',
\   'linter_ok': 'left',
\}

let g:lightline.active = {
\   'left': [
\       [ 'mode', 'paste' ],
\       [ 'readonly', 'filename', 'modified' ],
\   ],
\   'right': [
\       [ 'lineinfo' ],
\       [ 'percent' ],
\       [ 'fileformat', 'fileencoding', 'filetype' ],
\       [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
\   ],
\}

let g:lightline.inactive = {
\   'left': [
\       [ 'filename' ],
\   ],
\   'right': [
\       [ 'lineinfo' ],
\       [ 'percent' ],
\   ],
\}

" Remove close button from tabline right side
let g:lightline.tabline = {
\   'left': [
\       [ 'tabs' ],
\   ],
\   'right': [],
\}

" ============= git gutter =============

set signcolumn=yes  " always show gutter
let g:gitgutter_sign_added = '⚫'
let g:gitgutter_sign_modified = '⚫'
let g:gitgutter_sign_removed = '⚫'
let g:gitgutter_sign_removed_first_line = '⚫'
let g:gitgutter_sign_removed_above_and_below = '⚫'
let g:gitgutter_sign_modified_removed = '⚫'

" ============= vim test =============

let test#strategy = "dispatch"

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" ============= CoC =============
let g:coc_global_extensions = [
    \ 'coc-css',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-prettier',
    \ 'coc-pyright',
    \ 'coc-tsserver'
\ ]

" The following was taken from
" https://github.com/neoclide/coc.nvim#example-vim-configuration

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor for 300ms
set updatetime=300
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Map function and class text objects (selecting in/around function/class)
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
