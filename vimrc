runtime! debian.vim

" enable syntax highlighting
if has("syntax")
  syntax on
endif

" jump to line before file closed
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" indentation rules and plugins based on filetype
"filetype plugin indent on

set showcmd
set showmatch
set ignorecase
set smartcase
set incsearch
set autowrite
set hidden

set mouse=a
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set showmatch

"relative numbering in normal mode and absolute in insert mode
set number relativenumber
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
