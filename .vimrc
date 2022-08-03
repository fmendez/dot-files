"================= Plug Section START =================

call plug#begin('~/.vim/plugged')

" Plug 'neoclide/coc.nvim', {'branch': 'release'}

let $FZF_DEFAULT_COMMAND = 'rg --files'

" Plug 'rodrigore/coc-tailwind-intellisense', {'do': 'npm install'}
"
"
"

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'https://github.com/easymotion/vim-easymotion'

" status bar
Plug 'itchyny/lightline.vim'
let g:lightline = { 
      \  'colorscheme': 'gruvbox',
      \  'active': {
      \    'left': [['mode', 'paste'], ['readonly', 'relativepath', 'modified']],
      \  },
      \  'inactive': {
      \    'left': [['relativepath']],
      \  }
      \}


Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'morhetz/gruvbox'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tomtom/tcomment_vim'
Plug 'mattn/emmet-vim'

" Plug 'SirVer/ultisnips'
" let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips']
" let g:UltiSnipsExpandTrigger="<tab>"
" " defaults to c-j and c-k
" let g:UltiSnipsJumpForwardTrigger="<c-h>"
" let g:UltiSnipsJumpBackwardTrigger="<c-t>"
" let g:UltiSnipsEditSplit="vertical"

" Common language snippets
" Plug 'honza/vim-snippets'

" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'

" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }






Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'windwp/nvim-ts-autotag'

"
" Plug 'glepnir/lspsaga.nvim' 
Plug 'tami5/lspsaga.nvim', {'branch':'nvim6.0'}
Plug 'folke/trouble.nvim' 

call plug#end()

set completeopt=menu,menuone,noselect


lua << EOF

-- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {
      capabilities = capabilities
    }
    server:setup(opts)
end)

local saga = require 'lspsaga'
saga.init_lsp_saga()
require("trouble").setup{}

require('nvim-ts-autotag').setup()
EOF


" SAGA CONFIG 

nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>

nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>

nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>

nnoremap <silent>gr <cmd>lua require('lspsaga.rename').rename()<CR>

" -- preview definition
nnoremap <silent> gd <cmd>lua require'lspsaga.provider'.preview_definition()<CR>

" -- show
nnoremap <silent><leader>cd <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>

" -- only show diagnostic if cursor is over the area
nnoremap <silent><leader>cc <cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>

" -- jump diagnostic
nnoremap <silent> [e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> ]e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>

nnoremap <leader>xx <cmd>TroubleToggle<cr>

set encoding=utf-8
set termencoding=utf-8
set termguicolors
set number                      "Line numbers are good
"set relativenumber
"set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
"set showcmd                     "Show incomplete cmds down the bottom
"set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set autoread                    "Reload files changed outside vim
set laststatus=2                "Always show status line
set mouse=a

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
"let python_highlight_all=1
syntax on


"au FocusGained,BufEnter * :checktime

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader=","
" Inserts a vusual marker when changing a word with the cw command
set cpoptions+=$

" Make sure Vim use the system clipboard as the default register
set clipboard=unnamed

" Reset search
nnoremap <F3> :noh<CR>


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

"set autoindent
"set smartindent
"set smarttab

set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Display tabs and trailing spaces visually
"set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
"set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

"set foldmethod=indent   "fold based on indent
"set foldnestmax=3       "deepest fold is 3 levels
"set nofoldenable        "dont fold by default


" ================ Completion =======================
"set wildmenu
"set wildmode=longest:full,full
"set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
"set wildignore+=*vim/backups*
"set wildignore+=*sass-cache*
"set wildignore+=*DS_Store*
"set wildignore+=vendor/rails/**
"set wildignore+=vendor/cache/**
"set wildignore+=*.gem
"set wildignore+=*.lock
"set wildignore+=log/**
"set wildignore+=tmp/**
"set wildignore+=*.png,*.jpg,*.gif

" Ignoring  certain types of files and build/target directories
let NERDTreeIgnore=['^target$[[dir]]', '^node_modules$']

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
"set sidescrolloff=15
"set sidescroll=1


" let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
" let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

noremap <special> <Esc> <Esc>hl

" don't blink the cursor
"set guicursor+=i:blinkwait0
"set timeoutlen=1000 ttimeoutlen=0


set incsearch

"let g:mustache_abbreviations = 1
" nnoremap ,n :NERDTreeToggle<CR>
"that will make is so html files are only checked if you explicitly run
":SyntasticCheck
"
set lazyredraw
set ttyfast


nnoremap <C-n> :NERDTreeToggle<CR>

nnoremap <silent> ,t :FZF<CR>
nnoremap <silent> ,g :Rg<CR>
set background=dark
colorscheme gruvbox

" Limits the symbols available for marks to be only the alphabet
let g:showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXY"

" Inserts a vusual marker when changing a word with the cw command
set cpoptions+=$

" Make sure Vim use the system clipboard as the default register
"set clipboard=unnamed

" Sane tab navigation
nnoremap <c-h> :tabp<cr>
nnoremap <c-l> :tabn<cr>

" Turn on search highlight
set hlsearch
hi Search ctermbg=LightYellow ctermfg=Red

" Reset search
nnoremap // :noh<CR>


" Highlight color in visual mode
" hi Visual term=reverse cterm=reverse guibg=Grey

" force file type detection with rust files due to some weird bug
" https://github.com/rust-lang/rust.vim/issues/10
" au BufRead,BufNewFile *.rs set filetype=rust

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>


" push current line up or down
nnoremap <leader><Up> ddkP
nnoremap <leader><Down> ddp

" exchange character under cursor with the next character without moving the cursor
nnoremap gch xph

" exchange word under cursor with the next word without moving the cursor
nnoremap gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o><C-l>

" push word under cursor to the left
nnoremap <leader><Left> "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o><C-l>

" push word under cursor to the right
nnoremap <leader><Right> "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o>/\w\+\_W\+<CR><C-l>

" refactor block if into inline if 
nnoremap <leader>rif  ddkP3Jd$

nnoremap <leader>co :copen<CR>

"autocmd Filetype html setlocal ts=2 sts=2 sw=2
"autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
"autocmd Filetype javascript setlocal ts=4 sts=4 sw=4

" Python indentation
"au BufNewFile,BufRead *.py
"    \ set tabstop=4 |
"    \ set softtabstop=4 |
"    \ set shiftwidth=4 |
"    \ set textwidth=79 |
"    \ set expandtab |
"    \ set autoindent |
"    \ set fileformat=unix |


" coc config
" let g:coc_global_extensions = [
"   \ 'coc-snippets',
"   \ 'coc-pairs',
"   \ 'coc-tsserver',
"   \ 'coc-eslint',
"   \ 'coc-prettier',
"   \ 'coc-json',
"   \ 'coc-rust-analyzer',
"   \ 'coc-python',
"   \ 'coc-html',
"   \ ]

" let g:rustfmt_autosave = 1
" let g:python3_host_prog = '/Library/Frameworks/Python.framework/Versions/3.6/bin/python3'  " Python 3


" ===== COC Config =====
" if hidden is not set, TextEdit might fail.

" Some servers have issues with backup files, see #649
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" Use <c-space> to trigger completion.
" if has('nvim')
"   inoremap <silent><expr> <c-space> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
" if exists('*complete_info')
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif


" Use `[g` and `]g` to navigate diagnostics
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
" nnoremap <silent> K :call <SID>show_documentation()<CR>
"
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
" nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
" xmap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap if <Plug>(coc-funcobj-i)
" omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
" command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" nnoremap <expr><C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
" nnoremap <expr><C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"


" nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
" nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
" inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"


"" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

set hidden
" let g:LanguageClient_serverCommands = {
"     \ 'rust': ['~/.config/coc/extensions/coc-rust-analyzer-data/rust-analyzer'],
"     \ }


" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>


nnoremap ,b :Buffers<CR>

if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

nmap ,d :b#<bar>bd#<CR>

let g:user_emmet_leader_key='<C-e>'

map <Leader> <Plug>(easymotion-prefix)
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
