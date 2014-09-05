" Uses vim settings instead of vi
set nocompatible

" Pathogen
call pathogen#infect()
call pathogen#helptags()

" ============== General ==============
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

" Macro to insert python debug line
let @d = "Oimport ipdb; ipdb.set_trace(),w"

" Change the mapleader from '\' to ','
let mapleader=","

" Allow quick edit/reload of the .vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>

" Prevents vim from unindenting the line if it starts with '#'
inoremap # X#

" Toggle paste mode
set pastetoggle=<F2>

" :diffthis shortcut
nnoremap <leader>dt :diffthis<CR>
nnoremap <leader>do :diffoff<CR>

" Toggle mouse
nnoremap <leader>m  :set mouse=a<CR>
nnoremap <leader>mo :set mouse=<CR>

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

" Map cpp file to cpp11
au BufNewFile,BufRead *.cpp set syntax=cpp11

" Map .md to markdown
au BufRead,BufNewFile *.md set filetype=markdown

" Make Y behave like C and D
nnoremap Y y$

" Fast saving
nnoremap <leader>w :w!<cr>

" Highlights the currently selected line
"set cursorline
"hi CursorLine   cterm=NONE ctermbg=black
"hi CursorColumn cterm=NONE ctermbg=black

" ============== Search ==============
set wildmenu                                    " Enable the search menu
set wildmode=longest,list,full                  " Bash like autocompletion on tab in the command line
set wildignore+=*.o,*~,*.pyc,*.swp,*.so,*.out   " Files to ignore when searching
set incsearch                                   " Incremental search
set hlsearch                                    " Highlight search matches
set viminfo='100,f1                             " Save up to 100 marks, enable capital marks

" Quickly deactivates search highlighting
nmap <silent> ,/ :nohlsearch<CR>

" Centers the buffer on the next/previous item in a search
nnoremap n nzz
nnoremap N Nzz

" Ignore search case, except if there is upper case characters in the search
" pattern (/Foo will not find "foo", but /foo will find "foo" or "Foo")
set ignorecase
set smartcase

" ============== Persistent Undo ==============
" Keep undo history across sessions, by storing in file.
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

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

" ============== Syntastic ==============
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--ignore=E124,E128,F403,E501'
let g:syntastic_cpp_compiler='g++'
let g:syntastic_cpp_compiler_options='-std=c++11'

" ============== Jedi VIM ==============
"let g:jedi#use_tabs_not_buffers = 0

" ============== Powerline ==============
"set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
