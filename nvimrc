" vim-plug setup {{{
if has("nvim")
  call plug#begin('~/.nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

" Themes
Plug 'chriskempson/base16-vim'
Plug 'bling/vim-airline'
Plug 'edkolev/tmuxline.vim'

" Navigation
Plug 'christoomey/vim-tmux-navigator'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'

" Behaviour
Plug 'kopischke/vim-stay'
Plug 'konfekt/fastfold'

" Auto-completion
Plug 'valloric/youcompleteme', {'do': './install.py --clang-completer'}
Plug 'SirVer/ultisnips'
" Plug 'ervandew/supertab'

" Syntax highlighting
Plug 'beyondmarc/glsl.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rust-lang/rust.vim'
Plug 'zaiste/tmux.vim'

" Writing
Plug 'reedes/vim-pencil'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-commentary'

call plug#end()
" }}}

filetype plugin indent on

" Appearance {{{
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
" }}}

" General Settings {{{
let mapleader=' '   " Space
let maplocalleader='\\'
set showcmd
set encoding=utf-8
set exrc            " Load .vimrc from cwd
set secure
set hidden          " Allow switching buffers without saving
set splitright
set splitbelow
set nowrap
set numberwidth=1
set number
set relativenumber
set autoread
set ruler           " Add column number
set cursorline      " Highlight cursorline
set scrolloff=5
set visualbell t_vb=
set mouse=a
set backspace=indent,eol,start
set clipboard=unnamed
set viewoptions=cursor,folds,options,slash,unix

" Search settings
set incsearch
set nohlsearch
set ignorecase " Case-insensitive search by default.
set smartcase  " Case-sensitive if there are capital-letters in search string.

" Backup and swap
set nobackup
set noswapfile
set nowritebackup

" Tab settings
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Indent settings
set cindent
set cinoptions+=g0      " C++ scope declarations in first column
set cinoptions+=(0,W4   " Align line breaks within parenthesis

" Code folding
set foldmethod=indent
set foldlevel=99
set foldlevelstart=99
set foldnestmax=20
set foldcolumn=0

" Ignore files and folders
set wildignore+=*.so,*.o,*.exe,*.pyc,*/pycache/*
" }}}

" Keybindings ---- {{{
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
nnoremap <Space> <nop>
nnoremap <cr> <nop>
nnoremap <bs> <nop>

nnoremap K i<Enter><Esc>
nnoremap <F5> :setlocal spell! spelllang=en_gb<CR>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap - :set hlsearch! hlsearch?<CR>

onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap il{ :<c-u>normal! F{vi{<cr>

" Convert current word to uppercase
inoremap <c-u> <esc>viwUea

" Buffer switching
nnoremap H :bp<CR>
nnoremap L :bn<CR>

" fzf keybindings
nnoremap <silent> <c-p> :Files<cr>
nnoremap <silent> <cr> :Tags<cr>

" Neovim terminal
if has("nvim")
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l

  augroup Terminal
    autocmd!
    autocmd BufEnter term://* startinsert
  augroup END
endif
" }}}

" Filetype settings {{{
augroup FileTypeVim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

augroup FileTypeCpp
  autocmd!
  autocmd FileType c,cpp setlocal foldmethod=syntax
  autocmd FileType c,cpp setlocal commentstring=//\ %s
augroup END

augroup FileTypeTex
  autocmd!
  autocmd FileType tex,plaintex setlocal foldmethod=marker
  autocmd FileType tex,plaintex setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

augroup FileTypeBib
  autocmd!
  autocmd FileType bib setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

let g:tex_flavor = "latex"
" }}}

" YouCompleteMe {{{
let g:ycm_global_ycm_extra_conf = "~/.nvim/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0
let g:ycm_filetype_whitelist = { 'cpp': 1, 'python': 1 }
" }}}

" Tab Completion {{{
" Make YCM compatible with UltiSnips
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:SuperTabDefaultCompletionType = '<C-n>'

" UltiSnips bindings
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" }}}

" vim-airline {{{
set laststatus=2 " Make sure airline is always visible
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
" }}}

" tmuxline.vim {{{
let g:tmuxline_preset = {
  \'a'    : '#S',
  \'b'    : '',
  \'c'    : '',
  \'win'  : '#I #W',
  \'cwin' : '#I #W',
  \'x'    : '',
  \'y'    : '%R',
  \'z'    : '#h'}
" }}}

" CtrlP {{{
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlPMixed'
" let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_custom_ignore = {
"   \ 'dir': '\v[\/]\.(git|hg|svn|bzr)$',
"   \ 'file': '\v\.(exe|so|dll|o|acn|acr|alg|aux|bbl|blg|brf|glg|glo|gls|idx|log|nlg|nlo|nls|out|toc|xdy)$',
"   \ }

" noremap <Tab> :CtrlPTag<cr>
" }}}

" ack.vim {{{
let g:ackprg = 'ag --nogroup --nocolor --column'
" }}}

" vim-pencil {{{
let g:pencil#textwidth = 74
let g:pencil#wrapModeDefault = 'soft'
let g:airline_section_x = '%{PencilMode()}'
" let g:pencil#mode_indicators = {'hard': '␍', 'soft': '⤸', 'off': '',}
let g:pencil#conceallevel = 0

nnoremap <leader>ps :SoftPencil<CR>
nnoremap <leader>ph :HardPencil<CR>
nnoremap <leader>pn :NoPencil<CR>
nnoremap <leader>pt :PFormatToggle<CR>
" }}}

" Tabular {{{
nnoremap <leader>= :Tabularize /=<CR>
vnoremap <leader>= :Tabularize /=<CR>
nnoremap <leader>& :Tabularize /&<CR>
vnoremap <leader>& :Tabularize /&<CR>
nnoremap <leader>: :Tabularize /:\zs<CR>
vnoremap <leader>: :Tabularize /:\zs<CR>
" }}}

