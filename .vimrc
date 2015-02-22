set nocompatible              " be iMproved, required
filetype off                  " required

so $HOME/general_vim_cfg.vim
so $HOME/vundle_vim_cfg.vim

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default


" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" Ignoring  certain types of files and build/target directories
let NERDTreeIgnore=['target$[[dir]]']
"
" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1


let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

noremap <special> <Esc> <Esc>hl

" don't blink the cursor
set guicursor+=i:blinkwait0
set timeoutlen=1000 ttimeoutlen=0


set incsearch

let g:mustache_abbreviations = 1
map ,n :NERDTreeToggle<CR>
"that will make is so html files are only checked if you explicitly run
":SyntasticCheck
let syntastic_mode_map = { 'passive_filetypes': ['html'] }

" Allow Ctrp to search only on the currect directory
"
nnoremap <silent> ,e :CtrlPCurWD<cr>
set lazyredraw
set ttyfast


map <C-n> :NERDTreeToggle<CR>

" Solarized theme
so $HOME/ctrlp_custom.vim
set background=dark
colorscheme solarized

" RSpec.vim mappings
nnoremap ,rs :Dispatch<CR>

let g:rspec_command = "Dispatch rspec {spec}"
let g:rspec_runner = "os_x_iterm"
map <Leader>cs :call RunCurrentSpecFile()<CR>
map <Leader>ns :call RunNearestSpec()<CR>
map <Leader>ls :call RunLastSpec()<CR>
map <Leader>as :call RunAllSpecs()<CR>

" Limits the symbols available for marks to be only the alphabet
let g:showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXY"

" Inserts a vusual marker when changing a word with the cw command
set cpoptions+=$

" Make sure Vim use the system clipboard as the default register
set clipboard=unnamed

" Sane tab navigation
map <c-h> :tabp<cr>
map <c-l> :tabn<cr>

" Turn on search highlight
set hlsearch


" Highlight color in visual mode
hi Visual term=reverse cterm=reverse guibg=Grey
