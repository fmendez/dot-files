set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

Plugin 'scrooloose/nerdtree'

Plugin 'https://github.com/kien/ctrlp.vim'

Plugin 'https://github.com/rking/ag.vim'

Plugin 'vim-ruby/vim-ruby'
Plugin 'https://github.com/skwp/vim-colors-solarized'

Plugin 'https://github.com/itchyny/lightline.vim'
Plugin 'https://github.com/tpope/vim-surround'
Plugin 'https://github.com/thoughtbot/vim-rspec'
Plugin 'https://github.com/tpope/vim-dispatch'
Plugin 'https://github.com/Lokaltog/vim-easymotion'
Plugin 'https://github.com/xsunsmile/showmarks'
Plugin 'https://github.com/rust-lang/rust.vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'https://github.com/briandoll/change-inside-surroundings.vim'
Plugin 'https://github.com/tomtom/tcomment_vim'
Plugin 'goldfeld/ctrlr.vim'
Plugin 'https://github.com/jszakmeister/vim-togglecursor'
Plugin 'https://github.com/szw/vim-tags'
Plugin 'https://github.com/sirver/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'https://github.com/Shougo/neocomplete.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on
