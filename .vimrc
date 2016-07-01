set nocompatible
filetype off   

""""""""""""""""
" Vundle setup
""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'                  " let Vundle manage Vundle, required

Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'rking/ag.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ervandew/supertab'
Plugin 'terryma/vim-expand-region'
Plugin 'tpope/vim-fugitive'
Plugin 'danro/rename.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-scripts/argtextobj.vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'vim-scripts/gitignore'
Plugin 'matze/vim-move'
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-abolish'
Plugin 'padde/jump.vim'
Plugin 'kana/vim-textobj-user'              " ruby block text object
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'mattn/emmet-vim'
Plugin 'tommcdo/vim-exchange'
Plugin 'vim-scripts/paredit.vim'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-unimpaired'
Plugin 'easymotion/vim-easymotion'
Plugin 'FooSoft/vim-argwrap'

" Language support
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'
Plugin 'kchmck/vim-coffee-script'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'burnettk/vim-angular'
Plugin 'scrooloose/syntastic'
Plugin 'dag/vim2hs'
Plugin 'lambdatoast/elm.vim'
Plugin 'guns/vim-clojure-static'
Plugin 'rhysd/vim-crystal'
Plugin 'elixir-lang/vim-elixir'
Plugin 'keith/swift.vim'

" Themes
Plugin 'w0ng/vim-hybrid'
Plugin 'juanedi/predawn.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()

""""""""""""""""
" Plugins setup
""""""""""""""""
let mapleader = "\<Space>"

" ag
" binding to ack
let g:ackprg = 'ag --nogroup --nocolor --column' 
" prevent first jump
ca Ag Ag!

" airline
set laststatus=2
let g:airline_section_b = '%{fnamemodify(getcwd(), ":t")}'

" ctrlp
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_working_path_mode=0
nnoremap <leader><leader> :CtrlPMRU<cr>

" vim-move
let g:move_key_modifier = 'C'

" paredit
let g:paredit_mode=1

" NERDTree
let NERDTreeRespectWildIgnore = 1
map <leader>ntt :NERDTreeToggle<CR>
map <leader>ntf :NERDTreeFind<CR>

" Easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap <leader>s <Plug>(easymotion-bd-f2)
nmap <leader>f <Plug>(easymotion-bd-f)
nmap <leader>w <Plug>(easymotion-bd-w)
nmap <leader>l <Plug>(easymotion-bd-jk)

" JSX
let g:jsx_ext_required = 0

"vim-argwrap
nnoremap <silent> <leader>a :ArgWrap<CR>

""""""""""""""""
" Misc settings
""""""""""""""""

" base16 (colors configuration options are order specific)
set t_Co=256
let base16colorspace=256
colorscheme hybrid
set background=dark

" Visual options
set ruler
syntax on
set number

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Filetypes
filetype on
filetype plugin indent on

set tabstop=2
set shiftwidth=2
set smartindent
set expandtab

set autoread

" Needed for ruby block text objects
runtime macros/matchit.vim

set guifont=Monaco:h12

set splitbelow
set splitright

set wildignore+=.git,*.beam

set guioptions-=L
set guioptions-=l

set cursorline
set relativenumber

set visualbell

" store .swp files at home directory
set directory=~/tmp//,.,/var/tmp//,/tmp//

" enable mouse
set mouse=a

" allow to delete old text in insert mode
set backspace=indent,eol,start

"""""""""""""""""
" Misc mappings
"""""""""""""""""

" shortcuts
nmap <leader>h :noh<CR>

" I don't know why these two with the <plug> don't work with 'nore'
vmap v <plug>(expand_region_expand)
vmap <c-v> <plug>(expand_region_shrink)

" copy and paste from clipboard
vnoremap <leader>y "+y
vnoremap <leader>d "+d
nnoremap <leader>p "+p

" edit .vimrc
nnoremap <leader>ev :e $MYVIMRC<cr>

map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

nnoremap <leader>nn :set relativenumber!<cr>

" Duplicate line and comment
nnoremap <leader>d yy:Commentary<cr>p

" Moving to beginning/end of line
nnoremap <c-h> ^
nnoremap <c-l> $

" Switch to normal mode
inoremap jk <esc>

" Paste in insert mode
inoremap PP <esc>pa

" Center search results
nnoremap n nzz
nnoremap N Nzz
nnoremap G Gzz

" Keep cursor at current position when searching for current word
nnoremap * *N

" Avoid showing command history for q: (use <c-f> instead)
nnoremap q: <nop>

" Toggle background
nnoremap <leader>bl :set background=light<cr>
nnoremap <leader>bd :set background=dark<cr>

" Split navigation
nnoremap <s-j> <c-w>j
nnoremap <s-k> <c-w>k
nnoremap <s-h> <c-w>h
nnoremap <s-l> <c-w>l

" alternative mapping for joining lines
nnoremap <leader>jl <s-j>

nnoremap <leader>r <c-l>

nnoremap <c-w> :q<CR>

""""""""""""""""""
" Theme tunning
""""""""""""""""""
hi link markdownBold String
hi link markdownItalic String
hi link markdownCode markdownHeadingRule

