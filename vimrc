" Initial setup
" =============
set nocompatible
filetype off

" Plugins
" =======
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" Required
Plugin 'gmarik/vundle'

" Essential
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'kien/ctrlp.vim'
Plugin 'honza/vim-snippets'
Plugin 'bling/vim-airline'
"Plugin 'bling/vim-bufferline'
Plugin 'nvie/vim-flake8'
Plugin 'reedes/vim-pencil'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'mileszs/ack.vim'

" Themes
Plugin 'chriskempson/base16-vim'
Plugin 'w0ng/vim-hybrid'

" Syntax highlighting
Plugin 'zaiste/tmux.vim'
Plugin 'dpwright/vim-tup'
Plugin 'nachumk/systemverilog.vim'

call vundle#end()
filetype plugin indent on

if has("mac")
endif

" General
" =======
let mapleader='-'
"noremap <Space> <Leader>
"nnoremap <Leader>x i
set showcmd
set encoding=utf-8
set exrc            " Load .vimrc from cwd
set secure
set hidden          " Allow switching buffers without saving
set splitright
set splitbelow
set nowrap
"set number
set numberwidth=1
set relativenumber
set autoread
set ttyfast
set ruler           " Add column number
set cursorline      " Highlight cursorline
set incsearch
set laststatus=2
"set ttimeoutlen=50
set scrolloff=5
set visualbell t_vb=
set mouse=a

" Backup and swap
" ===============
set nobackup
set noswapfile
set nowritebackup

" Tab settings
" ============
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2

" Indent settings
" ===============
set cindent
set cinoptions+=g0      " C++ scope declarations in first column
set cinoptions+=(0,W4   " Align line breaks within parenthesis

" Code folding
" ============
set foldmethod=indent
set foldlevel=99
set foldnestmax=20
set foldcolumn=0

set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" YouCompleteMe
" =============
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_collect_identifiers_from_tags = 1
let g:ycm_extra_conf_globlist = ['~/Programming/*', '!~/*']
let g:ycm_filetype_whitelist = { 'cpp': 1, 'python': 1 }
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_key_list_select_completion = []
let g:ycm_key_list_previous_completion = []

" UltiSnips
" =========
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Run flake8 every time a python file is saved
" autocmd BufWritePost *.py call Flake8()

" vim-airline
" ===========
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='|'

" ctrlp
" =====
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
" nnoremap <C-O> :CtrlPBuffer<cr>
nnoremap <leader>. :CtrlPTag<cr>

" vim-pencil
" ==========
let g:pencil#textwidth = 74
let g:pencil#wrapModeDefault = 'hard'
let g:pencil#autoformat = 0

augroup pencil
  autocmd!
  autocmd FileType tex call pencil#init({'wrap': 'soft', 'autoformat': 1})
  autocmd FileType rst call pencil#init({'wrap': 'hard', 'autoformat': 1})
  autocmd FileType gitcommit call pencil#init({'wrap': 'hard', 'autoformat': 1, 'textwidth': 72})
  autocmd FileType text call pencil#init({'wrap': 'hard'})
augroup END

nnoremap <silent> <leader>ps :SoftPencil<cr>
nnoremap <silent> <leader>ph :HardPencil<cr>
nnoremap <silent> <leader>pn :NoPencil<cr>
nnoremap <silent> <leader>pt :TogglePencil<cr>
nnoremap <silent> <leader>pa :AutoPencil<cr>
nnoremap <silent> <leader>pm :ManualPencil<cr>
nnoremap <silent> <leader>pp :ShiftPencil<cr>

" vim-commentary
" ==============
autocmd FileType cpp set commentstring=//\ %s

" Theme
" =====
syntax enable
"colorscheme hybrid
let &t_Co=256
let base16colorspace=256
set background=dark
colorscheme base16-ocean
set linespace=0

" GUI settings
set guifont=Consolas:h12,Menlo\ Regular:h11,Courier\ New:h11
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" Commands
" ========
inoremap jk <Esc>
inoremap <Esc> <nop>

inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>

nnoremap K i<Enter><Esc>
nnoremap H ^
nnoremap L $
nnoremap <F5> :setlocal spell! spelllang=en_gb<CR>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Filetype settings
autocmd FileType gitcommit setlocal spell textwidth=72
autocmd FileType html,css setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType vim setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType tex setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Emulate US keyboard
if has("mac")
  noremap € $
else
  noremap ¤ $
endif
noremap å <C-J>
noremap ö [
noremap ä ]
noremap Ö {
noremap Ä }
"noremap - /

