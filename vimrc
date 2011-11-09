"
"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

" store swap files in one location
" set directory=~/.vim/swap,.
set noswapfile

" ----------------------------------------------------------------------------
"  Text Formatting
" ----------------------------------------------------------------------------

set autoindent             " automatic indent new lines
set smartindent            " be smart about it
set nowrap                 " do not wrap lines
set formatoptions+=n       " support for numbered/bullet lists
"set textwidth=80           " wrap at 80 chars by default
set virtualedit=block      " allow virtual edit in visual block ..

" ----------------------------------------------------------------------------
"  Remapping
" ----------------------------------------------------------------------------

" lead with ,
" let mapleader = "6"
" inoremap <leader>6 6
" inoremap 5 =
" inoremap = 5

" reflow paragraph with Q in normal and visual mode
nnoremap Q gqap
vnoremap Q gq

" sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

"try to make possible to navigate within lines of wrapped lines
nmap <Down> gj
nmap <Up> gk
set fo=l

" add a minibuffer shortcut which is similar to vimperator
nmap gt :MBEbn<CR>
nmap gT :MBEbp<CR>

" remap window navigation
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>n

" create shortcut for deleting a window
nmap gc :bd<CR>


" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" make j/k jump to next row in editor
" this is helpful when dealing with long lines (more natural)
nnoremap j gj
nnoremap k gk

" clear search buffer (so highlight goes away)
nmap <silent> <leader>e :let @/=""<CR>

"align plugin mappings
vmap <silent> <Leader>i= <ESC>:'<,'>Align =<CR>
vmap <silent> <Leader>i\| <ESC>:'<,'>Align \|<CR>
vmap <silent> <Leader>i, <ESC>:'<,'>Align ,<CR>
vmap <silent> <Leader>i( <ESC>:'<,'>Align (<CR>

" swap ' and "
inoremap ' "
inoremap " '

nmap <silent> <Leader>p :NERDTreeToggle<CR>

"make <leader>l clear the highlight as well as redraw
noremap <leader>l :set hlsearch! hlsearch?<CR>
inoremap <leader>l <C-O>:set hlsearch! hlsearch?<CR>

"map to CommandT 
nnoremap go :CommandT<CR>
nnoremap gu :CommandTBuffer<CR>
nnoremap gl :CommandTFlush<CR>

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

"bindings for ragtag
inoremap <M-o>       <Esc>o
inoremap <C-j>       <Down>
let g:ragtag_global_maps = 1

"key mapping for vimgrep result navigation
map <A-o> :copen<CR>
map <A-q> :cclose<CR>
map <A-j> :cnext<CR>
map <A-k> :cprevious<CR>

" remap ga to vim-rails alternate file command
nmap ga :A<CR>
nmap gr :R<CR>

" ----------------------------------------------------------------------------
"  UI
" ----------------------------------------------------------------------------

set ruler                  " show the cursor position all the time
set nolazyredraw           " turn off lazy redraw
set number                 " line numbers
set wildmenu               " turn on wild menu
set wildmode=list:longest,full
set ch=2                   " command line height
set backspace=2            " allow backspacing over everything in insert mode
set whichwrap+=<,>,h,l,[,] " backspace and cursor keys wrap to
set shortmess=filtIoOA     " shorten messages
set report=0               " tell us about changes
set showcmd                " show incomplete cmds down the bottom
set showmode               " show current mode down the bottom
set linespace=4            " add some line space for easy reading
set guioptions-=T          " turn off needless toolbar on gvim/mvim
let g:syntastic_enable_signs=1 "mark syntax errors with :signs
set showtabline=0          " never show the tab bar, using minibuff

" ----------------------------------------------------------------------------
" Visual Cues
" ----------------------------------------------------------------------------

set showmatch              " brackets/braces that is
set mat=5                  " duration to show matching brace (1/10 sec)
set laststatus=2           " always show the status line
set ignorecase             " ignore case when searching
set nohlsearch             " don't highlight searches
set visualbell t_vb=       " disable visual bell

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000


set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

set number      "add line numbers

" ---------------------------------------------------------------------------
" White space management
" ---------------------------------------------------------------------------

"indent settings
set softtabstop=2          " yep, two
set shiftwidth=2           " ..
set tabstop=2
set expandtab              " expand tabs to spaces
set autoindent
set nosmarttab             " fuck tabs

function! StripWhitespace ()
    exec ':%s/ \+$//gc'
endfunction
map <leader>s :call StripWhitespace ()<CR>

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
    return b:statusline_tab_warning
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")
        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)

    let long_line_lens = []

    let i = 1
    while i <= line("$")
        let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
        if len > threshold
            call add(long_line_lens, len)
        endif
        let i += 1
    endwhile

    return long_line_lens
endfunction

" ---------------------------------------------------------------------------
"  Setup Status Line
" ---------------------------------------------------------------------------

set statusline=%f       "tail of the filename

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%{StatuslineLongLineWarning()}

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

" ---------------------------------------------------------------------------
" Command-T
" ---------------------------------------------------------------------------

let g:CommandTMaxHeight=10
let g:CommandTMatchWindowAtTop=1

if has("gui_running")
    "tell the term has 256 colors
    set t_Co=256

    colorscheme railscasts

    if has("gui_gnome")
        set term=gnome-256color
        colorscheme ir_dark
        set guifont=Droid\ Sans\ Mono\ 12
    else
        colorscheme railscasts
        set guitablabel=%M%t
        set lines=40
    endif
    if has("gui_mac") || has("gui_macvim")
        set guifont=Menlo:h14
        " key binding for Command-T to behave properly
        " uncomment to replace the Mac Command-T key to Command-T plugin
        "macmenu &File.New\ Tab key=<nop>
        "map <D-t> :CommandT<CR>
        " make Mac's Option key behave as the Meta key
        set invmmta
    endif
    if has("gui_win32") || has("gui_win32s")
        set guifont=Consolas:h12
        set enc=utf-8
    endif
else
    "dont load csapprox if there is no gui support - silences an annoying warning
    let g:CSApprox_loaded = 1
endif

" ---------------------------------------------------------------------------
" Functions
" ---------------------------------------------------------------------------

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction


"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

"display tabs and trailing spaces
"set list
"set listchars=tab:\ \ ,extends:>,precedes:<
" disabling list because it interferes with soft wrap

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1


" ---------------------------------------------------------------------------
" Pathogen
" ---------------------------------------------------------------------------

"necessary on some Linux distros for pathogen to properly load bundles
filetype off

"load pathogen managed plugins
call pathogen#runtime_append_all_bundles()

"explicitly turn off filetypes before turning them on 
"to work around a bug in ubuntu
filetype plugin off 

"load ftplugins and indent files
filetype plugin on
filetype indent on



"snipmate setup
try
  source ~/.vim/snippets/support_functions.vim
catch
  source ~/vimfiles/snippets/support_functions.vim
endtry
autocmd vimenter * call s:SetupSnippets()
function! s:SetupSnippets()

    "if we're in a rails env then read in the rails snippets
    if filereadable("./config/environment.rb")
        call ExtractSnips("~/.vim/snippets/ruby-rails", "ruby")
        call ExtractSnips("~/.vim/snippets/eruby-rails", "eruby")
    endif

    call ExtractSnips("~/.vim/snippets/html", "eruby")
    call ExtractSnips("~/.vim/snippets/html", "xhtml")
    call ExtractSnips("~/.vim/snippets/html", "php")
endfunction

"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>


"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"define :HighlightLongLines command to highlight the offending parts of
"lines that are longer than the specified length (defaulting to 80)
command! -nargs=? HighlightLongLines call s:HighlightLongLines('<args>')
function! s:HighlightLongLines(width)
    let targetWidth = a:width != '' ? a:width : 79
    if targetWidth > 0
        exec 'match Todo /\%>' . (targetWidth) . 'v/'
    else
        echomsg "Usage: HighlightLongLines [natural number]"
    endif
endfunction

"smart indent when entering insert mode with i on empty lines
function! IndentWithI()
    if len(getline('.')) == 0
        return "\"_ddO"
    else
        return "i"
    endif
endfunction
nnoremap <expr> i IndentWithI()

" ----------------------------------------------------------------------------
" NERDTree
" ----------------------------------------------------------------------------

let NERDTreeQuitOnOpen = 1

" ---------------------------------------------------------------------------
" MiniBuff Config
" ---------------------------------------------------------------------------

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplorerMoreThanOne = 1

" ---------------------------------------------------------------------------
" NerdCommenter
" ---------------------------------------------------------------------------

let NERDSpaceDelims = 1

" ---------------------------------------------------------------------------
" Coffee Script
" ---------------------------------------------------------------------------
" autocmd BufWritePost *.coffee silent CoffeMake! -b | cwindow
