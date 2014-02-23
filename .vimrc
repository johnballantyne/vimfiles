set nocompatible
 

" =========================================================
" vundle settings
filetype off                   " required!


set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'flazz/vim-colorschemes'
Bundle 'tpope/vim-fugitive'
Bundle 'majutsushi/tagbar'
Bundle 'msanders/snipmate.vim'
Bundle 'terryma/vim-smooth-scroll'
Bundle 'mattn/gist-vim'
" vim-scripts repos
Bundle 'AutoComplPop'

" non github repos

" git repos on your local machine (ie. when working on your own plugin)

filetype plugin indent on     " required!

" end vundle settings
" =========================================================

" =========================================================
" custom JohnB settings
syntax enable

" Color scheme
set background="dark"
colorscheme solarized

" Tab Settings
set ts=4 sts=4 sw=4 expandtab

" Unicode
set encoding=utf-8

" Use custom symbols for tabstops and EOLs
set listchars=tab:▸\ ,eol:▾

" Show cursor position
set ruler

"Show Line Numbers
set number

" Keep cursor in center
set scrolloff=8

" Map NERDTree to Leader-t
map <Leader>t :NERDTreeToggle<CR>

" Map TagBar to Leader-b
map <Leader>b :TagbarToggle<CR>

" Put swap files in a different directory
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.

" Mouse Mode
set mouse=a

" Single character autocompletion for acp
let g:acp_behaviorKeywordLength=2

" Smooth scroll hotkeys
noremap <silent> <c-k> :call smooth_scroll#up(&scroll, 10, 1)<CR>
noremap <silent> <c-j> :call smooth_scroll#down(&scroll, 10, 1)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(10, 20, 1)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(10, 20, 1)<CR>

" No line wrap
set nowrap

" end JohnB settings
" =========================================================

" =========================================================
" vimcasts settings

" Whitespace preferences and filetypes
" Only do this part when compiled with support for autocommands
if has("autocmd")
  " Enable file type detection
  filetype on
   
  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
   
  " Customisations based on house-style (arbitrary)
  autocmd FileType html setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType css setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab
   
  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml
endif

" Auto-update the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" end vimcasts settings
