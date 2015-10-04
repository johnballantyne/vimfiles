set encoding=utf-8
scriptencoding utf-8
"
" Vundle Stuff
" =============================================================================
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'

Plugin 'tpope/vim-fugitive'

Plugin 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jshint', 'jscs']

Plugin 'scrooloose/nerdtree'
map <leader>t :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 1

Plugin 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

Plugin 'scrooloose/nerdcommenter'

Plugin 'terryma/vim-smooth-scroll'
noremap <silent> <c-k> :call smooth_scroll#up(&scroll, 10, 1)<CR>
noremap <silent> <c-j> :call smooth_scroll#down(&scroll, 10, 1)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 20, 2)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 20, 2)<CR>

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Appearance
" =============================================================================

syntax enable

" ## No line wrap ##
set nowrap

" ## Colors ##
set background=dark
colorscheme solarized

" ## Show cursor position ##
set ruler

" ## 8 line vertical cursor padding ##
set scrolloff=8

" ## gVim Specific Settings ##
if has("gui_running")
  if has("gui_win32")

" ## Set font ##
    set guifont=Lucida_Console:h12:cANSI

" ## Make backspace work like most other apps ##
" http://vim.wikia.com/wiki/Backspace_and_delete_problems
    set backspace=indent,eol,start

    set backupdir=~\.vim\tmp,.
    set directory=~\.vim\tmp,.

    set ff=unix
  endif
endif

" ## Line Numbers ##
set relativenumber
set number

" Whitespace Preferences
" =============================================================================

set list
function! ToggleListChars()
    let g:enabled = exists('g:enabled') ? !g:enabled : 1

    if g:enabled
        set listchars=tab:\ \ ,trail:\ ,precedes:…,extends:…
    else
        set listchars=tab:►\ ,trail:\ ,eol:¬,precedes:…,extends:…
    endif
endfunction

call ToggleListChars()


" ## Shortcupt to rapidly toggle `set list` ** ##
" Vimcasts #1 http://vimcasts.org/episodes/show-invisibles/
nmap <leader>l :call ToggleListChars()<CR>

" ## Tabs expanded to 4 spaces by default ##
" Vimcasts #2 http://vimcasts.org/episodes/tabs-and-spaces/
set ts=4 sts=4 sw=4 expandtab


" ## Filetype specific preferences ##
" Vimcasts #3 http://vimcasts.org/episodes/whitespace-preferences-and-filetypes/
" Only do this part when compiled with support for autocommands
if has("autocmd")
    " Enable file type detection
    filetype on

    " Syntax of these languages is fussy over tabs Vs spaces
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
endif

