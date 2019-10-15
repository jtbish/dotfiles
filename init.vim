" =============================================================================
" plugin manager
" =============================================================================
packadd minpac
call minpac#init({'verbose': 3})
call minpac#add('k-takata/minpac', {'type': 'opt'})

" utility commands
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
command! PackStatus call minpac#status()
" for headless plugin install
command! PackUpdateAndQuit call minpac#update('', {'do': 'quit'})

" =============================================================================
" plugin sources
" =============================================================================
call minpac#add('dense-analysis/ale')
call minpac#add('altercation/vim-colors-solarized')

" =============================================================================
" plugin settings
" =============================================================================
" -----------------------------------------------------------------------------
" ale
" -----------------------------------------------------------------------------
let g:ale_linters = {
\	'python': ['flake8']
\}
let g:ale_fixers = {
\	'*': ['remove_trailing_lines', 'trim_whitespace'],
\	'python': ['isort', 'yapf']
\}
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1

" -----------------------------------------------------------------------------
" solarized
" -----------------------------------------------------------------------------
syntax enable
set background=dark
colorscheme solarized

" =============================================================================
" in-built settings
" =============================================================================
" for netrw
filetype plugin on

" -----------------------------------------------------------------------------
" buffers
" -----------------------------------------------------------------------------
set hidden

" -----------------------------------------------------------------------------
" files
" -----------------------------------------------------------------------------
" display all matching files when tab completing
set wildmenu
" search for matching files recursively under current directory
set path+=**

" -----------------------------------------------------------------------------
" formatting
" -----------------------------------------------------------------------------
set textwidth=79
" number of visual spaces per tab to display when reading a file
set tabstop=4
" number of spaces per tab when inserting tab while editing a file
set softtabstop=4
" tabs are spaces in insert mode
set expandtab
" number of columns to indent with reindent (<< and >>) operators,
" plus automatic C-style indentation
set shiftwidth=4
" automatically indent to previous line's level on new line
set autoindent

" -----------------------------------------------------------------------------
" navigation
" -----------------------------------------------------------------------------
" move up and down by display lines
nnoremap j gj
nnoremap k gk
" show (absolute) line numbers
set number
" show (relative) line numbers
set relativenumber
" highlight the line the cursor is on
set cursorline
" make backspace work like 'normal'
set backspace=indent,eol,start

" -----------------------------------------------------------------------------
" searching
" -----------------------------------------------------------------------------
" highlight search matches
set hlsearch
" search as characters are entered
set incsearch

" -----------------------------------------------------------------------------
" windows
" -----------------------------------------------------------------------------
" open vertical split on right
set splitright
" open horizontal split below
set splitbelow

" =============================================================================
" commands / key mappings / abbreviations
" =============================================================================
" write buffer as root
command Wroot :write !sudo tee % > /dev/null
" change leader to spacebar
nnoremap <Space> <Nop>
let mapleader="\<Space>"
" vertical split and find
cabbrev vsf vert sf

" =============================================================================
" nvim specific settings
" =============================================================================
if has('nvim')
    " get out of terminal mode using esc
    tnoremap <Esc> <C-\><C-n>
    " allow sending esc to underlying terminal program
    tnoremap <C-v><Esc> <C-c>
endif
