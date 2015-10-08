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
set encoding=utf-8              " Force UTF-8
set showcmd                     " Always show the current command
set exrc                        " Load rc from current directory if present
set secure                      " Disallow shell commands in exrc
set hidden                      " Allow switching buffers without saving
set splitright                  " Vertical split to the right
set splitbelow                  " Horizontal split below
set nowrap                      " Do not wrap lines
set numberwidth=1               " Mininum number of columns in line number gutter
set number                      " Show current line number
set relativenumber              " Use relative line numbers
set autoread                    " Automatically reload changed files
set ruler                       " Add column number
set cursorline                  " Highlight current line
set scrolloff=5                 " Minimum no. lines visible above and below the cursor
set visualbell t_vb=            " Disable bell sound and visual flash
set mouse=a                     " Enable mouse in all modes
set backspace=indent,eol,start  " Sane backspace behaviour
set clipboard=unnamed           " Use the '*' register as the unnamed register

set incsearch                   " Show search matches continously
set nohlsearch                  " Do not highlight matches
set ignorecase                  " Case-insensitive search by default.
set smartcase                   " Case-sensitive if there are capital-letters in search string

set nobackup                    " Don't use backup files
set noswapfile                  " Don't use swapfiles

set expandtab                   " Insert spaces when pressing tab
set smarttab                    " Insert shiftwidth no. blanks when pressing tab
set shiftwidth=4                " Size of indentation (autoindent, <<, >>)
set tabstop=4                   " The no. spaces a tab represents
set softtabstop=4               " Make sure vim uses the appropriate number of spaces

set cindent                     " Enable C autoindent
set cinoptions+=g0              " C++ scope declarations in first column
set cinoptions+=(0,W4           " Align line breaks within parenthesis

set foldmethod=indent           " Fold based on indentation
set foldlevel=99                " Don't autofold
set foldlevelstart=99           " Don't autofold
set foldnestmax=20              " Max no. nested folds
set foldcolumn=0                " Don't show folds in the line number gutter

" Options to save into views
set viewoptions=cursor,folds,options,slash,unix

" Ignore files and folders
set wildignore+=*.so,*.o,*.exe,*.pyc,*/pycache/*
" }}}

" Keybindings ---- {{{
let mapleader=' '
let maplocalleader='\\'

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

