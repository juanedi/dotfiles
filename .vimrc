set nocompatible
filetype off   

" Vundle setup 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'rking/ag.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ervandew/supertab'
Plugin 'terryma/vim-expand-region'

" Language support
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'
Plugin 'kchmck/vim-coffee-script'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'burnettk/vim-angular'
Plugin 'scrooloose/syntastic'
Plugin 'dag/vim2hs'
Plugin 'lambdatoast/elm.vim'

" Themes
Plugin 'w0ng/vim-hybrid'
Plugin 'juanedi/predawn.vim'
Plugin 'chriskempson/base16-vim'

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

" Ruby block text object
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'

call vundle#end()

" Plugins

" ag binding to ack
let g:ackprg = 'ag --nogroup --nocolor --column'

" airline
set laststatus=2
let g:airline_section_b = '%{fnamemodify(getcwd(), ":t")}'

" ctrlp
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_working_path_mode=0

" vim-move
let g:move_key_modifier = 'C'

" base16 
" colors configuration options are order specific
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


""""""""""
" Mappings
""""""""""
let mapleader = "\<Space>"

" shortcuts
nnoremap <leader>h :noh<cr>
" I don't know why these two with the <plug> don't work with 'nore'
vmap v <plug>(expand_region_expand)
vmap <c-v> <plug>(expand_region_shrink)
" copy and paste from clipboard
" vnoremap <leader>y "+y
" vnoremap <leader>d "+d
" nnoremap <leader>p "+p
" vnoremap <leader>p "+p

" edit .vimrc
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" NERDTree
map <leader>ntt :NERDTreeToggle<CR>
map <leader>ntf :NERDTreeFind<CR>
" cntrp: recent buffers MRU
nnoremap <leader>bs :CtrlPMRU<cr>
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

nnoremap <leader>rn :set relativenumber!<cr>

" Duplicate line and comment
nnoremap <leader>d yy:Commentary<cr>p

" Moving to beginning/end of line
nnoremap H ^
nnoremap L $

" Switch to normal mode
inoremap jk <esc>

" Duplicate and comment
nnoremap <leader>d yygccp

" Center search results
nnoremap n nzz

" Avoid showing command history for q: (use <c-f> instead)
nnoremap q: <nop>

""""""""""
" Misc
""""""""""
set guifont=Monaco:h12

set ignorecase
set smartcase

set splitbelow
set splitright

set wildignore+=.git,*.beam
let NERDTreeRespectWildIgnore = 1

set guioptions-=L
set cursorline

set visualbell

" store .swp files at home directory
set directory=~/tmp//,.,/var/tmp//,/tmp//

" customize markdown highlighting
hi link markdownBold String
hi link markdownItalic String
hi link markdownCode markdownHeadingRule

""""""""""""""""""""""""""""""
" Project specific settings
""""""""""""""""""""""""""""""
if filereadable(".vimrc.local")
   set secure
   so .vimrc.local
endif
