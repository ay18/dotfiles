"sksea [vimrc standard]

"============================================================================
" Plugins - managed by vim plug
"============================================================================

call plug#begin('~/.vim/plugged')

" Install plugs via their github repos.

Plug 'w0ng/vim-hybrid'

" ycm: requires compiling with cmake. install cmake with 'brew install cmake'.
" cd ~/.vim/bundle/YouCompleteMe
" ./install.py
Plug 'valloric/youcompleteme'

" temporary fix for YCM when vim resolves $PATH incorrectly and selects wrong
" python version.
" In vim, use ':py import sys; print(sys.executable)' to check py version.
let $PATH='/usr/bin/:'.$PATH

Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

Plug 'jiangmiao/auto-pairs'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'scrooloose/nerdcommenter'

Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-gitgutter'

" ag: requires the-silver-searcher, install via brew
Plug 'rking/ag.vim'

Plug 'scrooloose/nerdtree'

" vim-airline: install suitable font (like Hack) and set as shell's font.
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
	set laststatus=2
	let g:airline_powerline_fonts = 1
	let g:airline_theme='tomorrow'

call plug#end()

"============================================================================
" Aesthetic
"============================================================================
syntax on
set background=dark
set nu
set title
set hlsearch
let base16colorspace=256
colorscheme hybrid

"============================================================================
" Behavior
"============================================================================
let mapleader=" "                                 "set leader key

set shiftwidth=2                                  "num of columns text is indented with reindent operations
set softtabstop=2                                 "num of spaces tab is expanded to
set tabstop=2                                     "size of hard tab stop
set expandtab                                     "set soft tab

set backspace=indent,eol,start                    "fix backspace behavior
set cino=i0,+0,t0                                 "options for c-indentation

"set foldmethod=indent                            "code fold settings
"set foldnestmax=10
"set foldlevel=2

autocmd BufWritePre <buffer> :%s/\s\+$//e         "remove trailing white space on save

nnoremap <C-j> :m .+1<CR>==                       "move lines up and down
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

map <leader>k :Sexplore<cr>                       "map explore mode
let g:netrw_liststyle=3                           "explore mode list style

nnoremap <leader>h :nohl<CR>                      "map key for unhighlight

filetype plugin on

