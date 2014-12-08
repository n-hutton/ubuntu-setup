"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"      =General
"      =Vim user interface
"      =Regex and search
"      =Save, backup and undo
"      =Indent
"      =Visual mode
"      =Misc. mappings
"      =Tabs, splits and buffers
"      =Status line and line numbering
"      =Folding
"      =Spell check, autocomplete
"      =Misc. settings
"      =Macros
"      =Moving around
"      =TODO
"      =Scratch area
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============General=============

"Vimrc configuration options for system dependent settings
let wantSolarized          = 1
let wantPathogen           = 1 "Req for: solarized
let wantVundle             = 1 
"let haveVundle             = 0 
let wantDoSearch           = 1 "Different search highlighting. Best with solarized
let wantIndentHighlight    = 0 "Different search highlighting. Best with solarized

"Mapleader - need to have this before any leader mappings
let mapleader   = ","
let g:mapleader = ","

set nocompatible               " Be iMproved

if(g:wantPathogen)
    execute pathogen#infect()
endif

if(g:wantVundle)
    "Check if we have vundle first
    if !filereadable(expand("~/.vim/bundle/Vundle.vim/README.md"))
        echom "Vundle does not exist. Installing..."
        execute ":!git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim"
        execute ":PluginInstall"
    endif

    filetype off                  " required

    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'

    "My vundle plugins
    Plugin 'tpope/vim-fugitive'
    Plugin 'Yggdroot/indentLine'

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

endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Vim user interface=============
  
set scrolloff=3                " How many lines between cursor and bottom/top of screen
set showcmd                    " show commands as being typed
set ruler                      " Always show current position - does nothing?
set cmdheight=2                " Height of the command bar
set showmatch                  " Show matching brackets when text indicator is over them
set mat=2                      " How many tenths of a second to blink when matching brackets
set lazyredraw                 " Don't redraw while executing macros (good performance config)
set wrap                       " Wrap lines
set showbreak=↪\ \ 		       " string to put before wrapped screen lines

" Treat long lines as break lines (useful when moving around in them)
noremap j gj
noremap k gk

" Turn on the WiLd menu
set wildmenu
set wildmode=full
"set wildmode=list:longest "make cmdline tab completion similar to bash

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

"Use :Invert to invert the background from dark to light
command! -bar Invert :let &background = (&background=="light"?"dark":"light")

" Choose colorscheme - solarized or desert
if(g:wantSolarized)
    syntax enable
    colorscheme solarized
    set background=dark
    hi Comment ctermfg=darkblue
    "let g:solarized_termcolors=256
    "set t_Co=256       "tell the term it has 256 colours?

    "Set extra options when running in GUI mode
    if has("gui_running")
        set guioptions-=T
        set guioptions+=e
        set t_Co=256
        set guitablabel=%M\ %t
    endif
else
    syntax enable
    colorscheme desert
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Regex and search=============

set magic                      " For regular expressions turn magic on

set ignorecase                 " Ignore case when searching 
set smartcase                  " When searching try to be smart about cases 
set hlsearch                   " Highlight search results
set incsearch                  " Start to go to words as they are typed

"Keeps search results in middle of screen
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz

"Modified search function has slightly more intelligent highlighting
"Note that visual mode is broken from this
if(g:wantDoSearch)
    nnoremap <space> :call DoSearch('search')<Cr>/
else
    nnoremap <space> /
endif

"For visual mode, we don't want any funny buisness - just search normally
vnoremap <space> /

"Same for operator-pending mode
onoremap <space> /

function! DoSearch(command)
    if a:command == 'search'
        if &wrap
            let g:waswrap = 1
        else
            let g:waswrap = 0
        endif
        "set nowrap
        set hls
        "since we can't see the cursor when in a function, have to identify 
        "place using cursorline and column
        hi CursorLine     cterm=NONE ctermbg=0
        hi CursorColumn   cterm=NONE ctermbg=0
        set cursorline cursorcolumn
        redraw
        setl updatetime=1
        "flicker_command will call the function immediately after the search is complete (1ns of no key press)
        "It then calls Dosearch again to turn off the cursorhold autocommand and proceed with the function
        augroup flicker_command
            au!
            au CursorHold * call DoSearch('iterate')
        augroup end
    elseif a:command == 'iterate'
        setl updatetime=4000
        au! flicker_command
        augroup! flicker_command
        let c = nr2char(getchar())
        while c =~ '\v^(n|N)$'
            execute "normal! ".c
            redraw
            let c = nr2char(getchar())
        endwhile
        "choose this
        set hls!
        "or these two
        "set hls
        "set nohlsearch
        set nocursorline nocursorcolumn
        "if g:waswrap
        "    set wrap
        "endif
        call feedkeys(c)
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Save, backup and undo=============

set nobackup        " Turn backup etc. off, since most stuff is in SVN, git et.c anyway...
set nowb
set noswapfile
set confirm         " Ask if want to save before closing modified file

"Fast save, quit etc.
nnoremap <leader>w :w<cr>
nnoremap <leader>wq :wq<cr>

"If we want to quit, just quit without confirming if the buffer is unnamed 
nnoremap <leader>q :call QuitIfEmpty()<CR>:q<Cr>

"Check current buffer is saved and put vim into background 
nnoremap <leader>v :call CheckSavedBuffer()<cr><C-z>

" Delete trailing white space on save
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Keep undo history
" This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
" This is only present in 7.3+ :help undo-persistence
if exists("+undofile")
    if isdirectory($HOME . '/.vim/undo') == 0
        :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
    endif
    set undodir=./.vim-undo//
    set undodir+=~/.vim/undo//
    set undofile
endif

"Check whether currently viewed buffer has been modified, and offer to save if so
function! CheckSavedBuffer()
    "If modified flag is true
    if &modified
        "Use confirm dialog to check whether saving is wanted (CR will hit yes)
        let choice = confirm("File has been modified. Save changes? (y)", "&Yes\n&No\n", 1)
        if choice == 1
            echom "Saving file"
            execute ":w"
        endif
    endif
endfunction

"If buffer has no name, set it's type as not modified to enable quiet quitting
function! QuitIfEmpty()
    if empty(bufname('%')) 
        setlocal nomodified 
    endif
endfunction

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Indent=============

set ai "Auto indent
set si "Smart indent

"keeps your visual selection when indenting
vnoremap < <<gv
vnoremap > >>gv

"Note: set expandtab<cr>:retab!<cr> will turn tabs to spaces

"We want colored indenting
"nmap <leader>ii :IndentGuidesToggle<Cr>:hi IndentGuidesOdd  ctermbg=0<Cr>:hi IndentGuidesEven ctermbg=8<Cr>
"IndentGuidesEnable
"hi IndentGuidesOdd  ctermbg=0
"hi IndentGuidesEven ctermbg=8

"On file read, turn on indent highlighting if we want it 
"Modified .vim/bundle/vim-indent-guides/autoload/indent_guides.vim to add to line 110:
" exe "hi IndentGuidesOdd  ctermbg=8" and exe "hi IndentGuidesEven ctermbg=0" 
if(g:wantIndentHighlight) 
    autocmd BufReadPost * 
        \ exe "IndentGuidesToggle" |
        \ exe "hi IndentGuidesOdd  ctermbg=0" |
        \ exe "hi IndentGuidesEven ctermbg=8" |
endif

"Default tab expansion for 
autocmd FileType * set tabstop=4|set shiftwidth=4|set expandtab|set smarttab

"for markdown, do not want expandtab
autocmd FileType markdown set tabstop=4|set shiftwidth=4|set noexpandtab

"for makefiles, do not want expandtab
autocmd FileType make set tabstop=4|set shiftwidth=4|set noexpandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Visual mode=============

" Pressing * or # searches for the current selection (yanks into reg 9)
if(g:wantDoSearch)
    vnoremap * "9y:call DoSearch('search')<Cr>/<C-r>9<Cr>
    vnoremap # "9y:call DoSearch('search')<Cr>?<C-r>9<Cr>
else
    vnoremap * "9y/<C-r>9<Cr>
    vnoremap # "9y?<C-r>9<Cr>
endif

" Echo what visual mode we are in
function! WhatVisualMode()
    let m = visualmode()
    if m ==# 'v'
        echo 'character-wise visual'
    elseif m == 'V'
        echo 'line-wise visual'
    elseif m == "\<C-V>"
        echo 'block-wise visual'
    else
        echo 'argh'
    endif
endfunction 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Misc. mappings=============

"Since our mapleader is ',' we repurpose '/' which is mapped to <space>
nnoremap / ,

"Remap jk and kj and kj to esc in insert mode
inoremap jk <Esc>
inoremap kj <Esc>

"make yank behave like other capitals
map Y y$

"Source my vimrc. 
"nmap <leader>v :w<Cr>:source $MYVIMRC<Cr>:noh<Cr>

"Faster command-mode manipulation, quick reg access, fast history search
cnoremap <leader>r <C-r><C-">
cnoremap <C-J> <Down>
cnoremap <C-K> <Up>

"Expands %% to the path of the file currently being edited rather than where vim was opened
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Tabs, splits and buffers=============

set diffopt+=vertical       " start diff mode with vertical splits by default
set splitright splitbelow   "makes the vsplit open on the RHS and split on the bottom

" Easier way to move between splits
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Use ctrl-u and p to switch between tabs
nnoremap <C-u> gT
nnoremap <C-p> gt

"Use ctrl-t and y to change split window size
nnoremap <C-t> <C-w>-
nnoremap <C-y> <C-w>+

" Possibly useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

"change buffers quickly
nmap <leader>b :ls<CR>:buffer<Space>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Status line and line numbering=============

set rnu "set relative line numbering

" Always show the status line
set laststatus=2

" Format the status line - old line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
set statusline+=%F                "Display file path in full
set statusline+=[%1*%M%*%n]       "Display file save status in red, buffer number
set statusline+=%y                "type of file as square
set statusline+=%1*%r%*           "Readonly flag as square - set to red
set statusline+=%h                "Help flag as sqare
set statusline+=%=                "orients the rest to the RHS
set statusline+=%l                "Show line/lines
set statusline+=/%L

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Folding=============

"to fold (possibly a selection too): zf
"open and close with zo and zc
"reduce and more folding with zr and zm
"Open/close all fold levels with zR zM
"turn off folding with zn. Return to prev. state with zN. Toggle with ==> zi

"set foldcolumn=4 would give VS-like column icons?

"To open all folds at the cursor line use |zO|.
"To close all folds at the cursor line use |zC|.
"To delete a fold at the cursor line use |zd|.
"To delete all folds at the cursor line use |zD|.

"This uses indent to automatically create folds
"set foldmethod=indent
"
"All indents after level 3 will be automatically folded
"set foldlevel=3

"Fold using markers
"set foldmethod=marker
"
"/* global variables {{{7 */
"int varA, varB;
"
"/* functions {{{1 */
"/* funcA() {{{2 */
"void funcA() {}
"
"/* funcB() {{{4 */
"void funcB() {}
"/* }}}1 */

"if has('folding')
"  set nofoldenable 		    " When opening files, all folds open by default
"endif

"folding settings
"set foldmethod=indent "fold based on indent
"set foldmethod=syntax "fold based on indent
"set foldnestmax=3 "deepest fold is 3 levels
""set nofoldenable "don't fold by default

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Spell check, autocomplete=============

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
"set complete-=i     " Searching includes can be slow

"spell check when writing commit logs
autocmd filetype svn,*commit*,text setlocal spell

"Use TAB to complete when typing words, else inserts TABs as usual.
"Uses dictionary and source files to find matching words to complete.
"Note: usual completion is on <C-n> but more trouble to press all the time. (:help ins-completion)
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Misc. settings=============

filetype plugin indent on      " Required!
set history=700                " Sets how many lines of history VIM has to remember
set autoread                   " Set to auto read when a file is changed from the outside
set encoding=utf8              " Set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac           " Use Unix as the standard file type
set lbr                        " Linebreak on 500 characters
set tw=500
set clipboard=unnamed	       " Yank to the system clipboard by default

"disable paste mode when leaving normal mode
au InsertLeave * set nopaste

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Macros=============

"map Q to do last executed macro
nnoremap Q @@

"Execute macro over visual range
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "Execute which macro?"
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Moving around=============

"beginning of line and end of line quickly (operator-pending as well)
noremap H ^
onoremap H ^

"Don't want to select the end of line in visual mode
nnoremap L $
onoremap L $
vnoremap L $h 

"Let's remap K and J since they can be of use

"If we want to compare a vertical split column by column, we can enable this
let wantCompareSplit   = 0

if(g:wantCompareSplit)
    nnoremap J :call CompareVsplit('J')<cr>
    nnoremap K :call CompareVsplit('K')<cr>
endif

function! CompareVsplit(direction)
    if a:direction == 'J'
        execute "normal! \<c-w>t"
        execute ":set cursorline"
        execute "normal! jzz"
        execute "normal! \<c-w>b"
        execute ":set cursorline"
        execute "normal! jzz"
    endif

    if a:direction == 'K'
        execute "normal! \<c-w>t"
        execute ":set cursorline"
        execute "normal! kzz"
        execute "normal! \<c-w>b"
        execute ":set cursorline"
        execute "normal! kzz"
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============TODO=============

"TODO: get paste-over working again
"keeps the text in the default reg when pasting in visual mode - WHY IS THIS NOT WORKING
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction

function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction

" NB: this supports "rp that replaces the selection by the contents of @r
vnoremap <silent> <expr> p <sid>Repl()

"force sudo writing TODO: explain how this works
cmap w!! %!sudo tee > /dev/null 

"surround visual selection with parens TODO: rewrite as function (also strip whitespace)
vnoremap s" <Esc>`>a"<Esc>`<i"<Esc>
vnoremap s) <Esc>`>a)<Esc>`<i(<Esc>
vnoremap s( <Esc>`>a)<Esc>`<i(<Esc>
vnoremap s} <Esc>`>a}<Esc>`<i{<Esc>
vnoremap s{ <Esc>`>a}<Esc>`<i{<Esc>
vnoremap s[ <Esc>`>a]<Esc>`<i[<Esc>
vnoremap s] <Esc>`>a]<Esc>`<i[<Esc>
vnoremap s' <Esc>`>a'<Esc>`<i'<Esc>
vnoremap s< <Esc>`>a><Esc>`<i<<Esc>
vnoremap s> <Esc>`>a><Esc>`<i<<Esc>

"TODO: comment auto
autocmd FileType perl vnoremap <buffer> ss <Esc>`>o=comment<Esc>`<O=cut<Esc>
autocmd FileType c vnoremap <buffer> ss <Esc>`>a/*<Esc>`<i*/<Esc>

"TODO what does this do
command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>

"TODO: integrate into newSearch
function! TODOThing()
au CursorMoved * nohls
au InsertEnter * nohls
au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Scratch area=============

"Notes:
"I want to be able to create a small :sp where I can run command line options... Has that been done?

"Thinking about changing whitespace highlighting...
"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
""highlight ExtraWhitespace ctermbg=red guibg=red
"highlight ExtraWhitespace ctermbg=23 
""possibly 23-27 
"
"" Show spaces used for identing (so you use only tabs for indenting).
"function! AAA4()
"    match ExtraWhitespace /^\t*\zs \+/
"endfunction

