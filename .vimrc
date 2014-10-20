execute pathogen#infect()

set nowrap

nnoremap <C-u> gT
nnoremap <C-p> gt

nnoremap <C-t> <C-w>-
nnoremap <C-y> <C-w>+

"I want to be able to create a small :sp where I can run command line options... Has that been done?

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Amir Salihefendic
"       http://amix.dk - amix@amix.dk
"
" Version: 
"       5.0 - 29/05/12 15:43:36
"
" Blog_post: 
"       http://amix.dk/blog/post/19691#The-ultimate-Vim-configuration-on-Github
"
" Awesome_version:
"       Get this config, nice color schemes and lots of plugins!
"
"       Install the awesome version from:
"
"           https://github.com/amix/vimrc
"
" Syntax_highlighted:
"       http://amix.dk/vim/vimrc.html
"
" Raw_version: 
"       http://amix.dk/vim/vimrc.txt
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
"Bundle 'tpope/vim-fugitive'
"Bundle 'Lokaltog/vim-easymotion'
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"Bundle 'tpope/vim-rails.git'
"" vim-scripts repos
"Bundle 'L9'
"Bundle 'FuzzyFinder'
"" non github repos
"Bundle 'git://git.wincent.com/command-t.git'
"" git repos on your local machine (ie. when working on your own plugin)
"Bundle 'file:///Users/gmarik/path/to/plugin'
" ...
"Bundle 'Valloric/YouCompleteMe'

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"mine own settings 
"this will force the cursor to stay in the center of the screen
"set scrolloff=9999 
set scrolloff=1


set nocompatible               " be iMproved
set showcmd                    " show commands as being typed
filetype off                   " required!

"this will stop autoindenting when pasting from keyboard
set pastetoggle=<F10>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving - no !
nmap <leader>w :w<cr>

" Fast quitting 
"nmap <leader>q :q<cr>

nnoremap <leader>q :call QuitIfEmpty()<CR>:q<Cr>

function! QuitIfEmpty()
    if empty(bufname('%')) 
        setlocal nomodified 
    endif
endfunction

" Fast quitting and saving
nmap <leader>wq :wq<cr>

nmap <leader>v :w<Cr>:source $MYVIMRC<Cr>:noh<Cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu
set wildmode=full
"set wildmode=list:longest "make cmdline tab completion similar to bash

cnoremap <leader>r <C-r><C-">
cnoremap <leader>e <C-f>
cnoremap <C-J> <Down>
cnoremap <C-K> <Up>


" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching - give this a trial...
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
"colorscheme solarized
"set background=dark
"hi Comment ctermfg=darkblue

"let g:solarized_termcolors=256
"syntax enable
"set background=dark
"colorscheme solarized


" Set extra options when running in GUI mode
"if has("gui_running")
"    set guioptions-=T
"    set guioptions+=e
"    set t_Co=256
"    set guitablabel=%M\ %t
"endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs - this should be overridden in makefiles...
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
"set wrap "Wrap lines

"Use tabs for these filetypes (only KNOWN filetypes?)
autocmd FileType * set tabstop=4|set shiftwidth=4|set expandtab

"for markdown, do not want expandtab
autocmd FileType markdown set tabstop=4|set shiftwidth=4|set noexpandtab

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
"vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
vnoremap * y/<C-r>"<Cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
noremap j gj
noremap k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
"map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :nohls<cr>
"map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows - (what about tabs?)
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

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

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line - old line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

"set statusline=\ %{HasPaste()}   "call haspaste fn... says at bottom of screen anyway
set statusline+=%F                "Display file path in full
"set statusline+=[%1*%M%*%n%R%H]  "Display file save status in red, buffer number, also readonly flag, help flag
set statusline+=[%1*%M%*%n]       "Display file save status in red, buffer number
set statusline+=%y                "type of file as square
set statusline+=%1*%r%*           "Readonly flag as square - set to red
set statusline+=%h                "Help flag as sqare
"set statusline+=\ %w             "preview window flag
"set statusline+=\ \ CWD:
"set statusline+=\ %r
"set statusline+=%{getcwd()}
"set statusline+=%h
set statusline+=%=                "orients the rest to the RHS
"set statusline+=\ \ \ Line:
set statusline+=%l
set statusline+=/%L

"set statusline=%<%f%=\ [%1*%M%*%n%R%H]\


"set statusline=[%n]\ %<%.99f\ %h%w%m%r%{SL('CapsLockStatusline')}%y%{SL('fugitive#statusline')}%#ErrorMsg#%{SL('SyntasticStatuslineFlag')}%*%=%-14.(%l,%c%V%)\ %P
"
"function! SL(function)
"  if exists('*'.a:function)
"    return call(a:function,[])
"  else
"    return ''
"  endif
"endfunction

hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red

"displays tabs and trailing whitespace accordingly
"set list
"set listchars=tab:▷\ ,trail:⋅,nbsp:⋅
"set listchars=tab:>\ ,trail:⋅,nbsp:⋅
"set listchars=tab:▸\ ,trail:⋅,nbsp:⋅
"set listchars=tab:▸\ ,eol:¬

set clipboard=unnamed	" Yank to the system clipboard by default



" ----------------------------------------------------------------------------
"  folding
" ----------------------------------------------------------------------------
"if has('folding')
"  set nofoldenable 		    " When opening files, all folds open by default
"endif

" ----------------------------------------------------------------------------
"  diff mode
" ----------------------------------------------------------------------------
set diffopt+=vertical       " start diff mode with vertical splits by default
set diffopt+=vertical       " diff mode with vertical splits please


"set showbreak=↪\ \ 		" string to put before wrapped screen lines

set confirm
"folding settings
"set foldmethod=indent "fold based on indent
"set foldmethod=syntax "fold based on indent
"set foldnestmax=3 "deepest fold is 3 levels
""set nofoldenable "don't fold by default

inoremap <leader><leader> <Esc>:call MyFunc6()<Cr>

"insert the number 23 who are you:12
"above, below, everything, range who
"compare what's been changed when attempting to quit file

"vnoremap i :<c-u>call RemapI()<Cr> 
"vnoremap i I

function! RemapI()
    let m = visualmode()
    if m == "\<C-V>"
        execute "normal! vgvI"
        echom "done"
    endif
endfunction

"vnoremap <silent> J :<c-u>call VisualMove('J')<Cr>
"vnoremap <silent> K :<c-u>call VisualMove('K')<Cr>
vnoremap S :<c-u>execute "normal! /^\\s*$\rkmzVN\e:noh\rgv"<cr>

  
function! VisualMove(direction) 

    let i = line('.')+1
    let currentChar = strpart(getline(i), col('.')-1, 1)
    let charBelow = strpart(getline('.'), col('.')-1, 1)
"    echom currentChar

    while currentChar == charBelow
        let i = line('.')+1
        let currentChar = strpart(getline(i), col('.')-1, 1)
        let charBelow = strpart(getline('.'), col('.')-1, 1)
"        echom currentChar
        normal! gvj
    endwhile
endfunction

function! SelectParagraph()
    endfunction

"abcdef"abcdef nathan "abcdef"abcdef"abcdefggggg"abcdefg
"abcdef"abcdef nathan (((("abcdef"abcdef"abcdefggggg"abcdefg
"abcdef"abcdef nathan "abcdef"abcdef"abcdefggggg"abcdefg
"abcdef"abcdef nathan "abcdef"abcdef"abcdef"abcdefgggggg
"abcdef"abcdef nathan "ab((cdef"abcdef"abcdef"abcdefgggggg
"abcdef"abcdef nathan "abcdef"abcdef"abcdef"abcdefgggggg
"abcdef"abcdef nathan "abcdef"abcdef"abcdef"abcdefgggggg
"
"
"abcdef"abcdef "abcdef"abcdef"abcdef"abcdefgggggg
"abcdef"abcdef "abcdef"abcdef"abcdef"abcdefgggggg
"abcdef"abcdef "abcdef"abcdef"abcdef"abcdefgggggg
"abcdef"abcdef "abcdef"abcdef"abcdef"abcdefgggggg
"
"
"abcdef"abcdef "abcdef"abcdef"abcdef"abcdefgggggg
"abcdef"abcdef "abcdef"abcdef"abcdef"abcdefgggggg
"abcdef"abcdef "abcdef"abcdef"abcdef"abcdefgggggg
"abcdef"abcdef "abcdef"abcdef"abcdef"abcdefgggggg
"
"
"Take user input as ch1234◀◀
function! s:getchar()
"try
"    let c = getchar()
"  catch /^Vim:Interrupt$/
"    let c = "\<Esc>"
"  endtry

  let c = getchar()
  if c =~ '^\d\+$'
    let c = nr2char(c)
  endif
  return c
endfunction

"lkljlklsdsdfasd<  
"
"
" Interactively change th12
function! MyFunc6()

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


  let char = "s"
  let string = ""
  let first = "0"
  echom string
echo "Entering number mode: "
"execute "normal! i◀" 
  while char =~ '^\w$'
"  while char != "q"
    let char = s:getchar()

"    if char == "u" | execute "normal! u" | endif
"    if char == "\<Bs>" | execute "normal! u" | endif
    if char == "\<Bs>" | break | endif

    if char == "a" | let string = string."1" | endif
    if char == "s" | let string = string."2" | endif
    if char == "d" | let string = string."3" | endif
    if char == "f" | let string = string."4" | endif
    if char == "g" | let string = string."5" | endif
    if char == "h" | let string = string."6" | endif
    if char == "j" | let string = string."7" | endif
    if char == "k" | let string = string."8" | endif
    if char == "l" | let string = string."9" | endif
    if char == ";" | let string = string."0" | endif
    if char == "'" | let string = string."-" | endif
    if char == "#" | let string = string."=" | endif

    if m == "\<C-V>"
        if first == "1" | execute "normal! ugvI".string | endif
        if first == "0" | let first = "1" | execute "normal! gvI".string | endif
    else
        if first == "1" | execute "normal! ua".string."◀" | endif
        if first == "0" | let first = "1" | execute "normal! a".string."◀" | endif
    endif
"one two three for 1t who are  you who a a        a12a   5777734◀
"ok, so maybe the thing should do the change, you can still use j and k to inc, h to edit, l to go
"also, detect changes and N to them (indiacate somehow...)
"and nathan
"who
"
"
"see
"
"    if char == "u" | execute "normal! u" | endif
"    if char == "\<Bs>" | execute "normal! u" | endif
"    if char == "q" | let char = "" | endif
"
"    if char == "a" | execute "normal! xi1◀\el" | endif
"    if char == "s" | execute "normal! xi2◀\el" | endif
"    if char == "d" | execute "normal! xi3◀\el" | endif
"    if char == "f" | execute "normal! xi4◀\el" | endif
"    if char == "g" | execute "normal! xi5◀\el" | endif
"    if char == "h" | execute "normal! xi6◀\el" | endif
"    if char == "j" | execute "normal! xi7◀\el" | endif
"    if char == "k" | execute "normal! xi8◀\el" | endif
"    if char == "l" | execute "normal! xi9◀\el" | endif
"    if char == ";" | execute "normal! xi0◀\el" | endif
"    if char == "'" | execute "normal! xi-◀\el" | endif
"    if char == "#" | execute "normal! xi=◀\el" | endif
    redraw
    echom string
  endwhile
    if m == "\<C-V>"
        execute "normal! ugvI".string
    else
        execute "normal! ua".string
    endif
endfunction 

"I am going to type a number here:12

"if char == "80" | echom "one" | endif
"if char == '<esc>' | echom "two" | endif
"if char == "\<Esc>" | echom "tw1" | endif
"if char == "\<Bs>" | echom "tw1" | endif
"if char == '\<Esc>' | echom "tw2" | endif
"if char == "" | echom "three" | endif
"if char == "" | echom "thre4" | endif

" Interactively change the window size
"function! MyFunc5()
"  let char = "s"
"  while char =~ '^\w$'
"    echo "(InteractiveWindow) TYPE: h,j,k,l to resize or a for auto resize"
"    let char = s:getchar()
"    if char == "h" | echom "you pressed h" | endif
"    if char == "j" | echom "you pressed j" | endif
"    if char == "k" | echom "you pressed k" | endif
"    if char == "l" | echom "you pressed l" | endif
"    if char == "a" | echom "you pressed a" | endif
"    "redraw
"  endwhile
"endfunction

"set t_Co=256       "tell the term it has 256 colours?
"
"spell check when writing commit logs
autocmd filetype svn,*commit* setlocal spell

"set statusline=%.20F         " Path to the file
"set statusline+=\ -\      " Separator
"set statusline+=FileType: " Label
"set statusline+=%y        " Filetype of the file
"set statusline+=%=
"set statusline+=%l    " Current line
"set statusline+=/    " Separator
"set statusline+=%L   " Total lines


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
"map 0 ^

"Remap jk and kj and kj to esc - remember to try to fix problem?
inoremap jk <Esc>
inoremap kj <Esc>

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
"vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
"map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

"Use TAB to complete when typing words, else inserts TABs as usual.
"Uses dictionary and source files to find matching words to complete.

"See help completion for source,
"Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
"Use the Linux dictionary when spelling is in doubt.
"Window users can copy the file to their machine.
"
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

"should I remove this?
":set dictionary="/usr/dict/words"

"makes the vsplit open on the RHS
set splitright splitbelow

"keeps your visual selection when indenting
"vnoremap < <<gv
"vnoremap > >>gv

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

"make yank behave like other capitals
map Y y$


"map <Leader>fm :g/^\s*$/,/\S/-j<Cr>:%s/\s\+$//<CR>
map <Leader>v  :so ~/.vimrc<CR>

"force sudo writing
cmap w!! %!sudo tee > /dev/null 


"use sane regexes - all characters that can be special are
"nnoremap / /\v
"vnoremap / /\v

"Do I want this? Keeps search results in middle of screen
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

"apparently better command-line editing
"cnoremap <C-j> <t_kd>
"cnoremap <C-k> <t_ku>
"cnoremap <C-a> <Home>
"cnoremap <C-e> <End>

"disable paste mode when leaving normal mode
au InsertLeave * set nopaste

"map Q to do last recorded macro (instead of some mode)
map Q @@

"drag lines up/down
"noremap <A-j> :m+<CR>
"noremap <A-k> :m-2<CR>
"inoremap <A-j> <Esc>:m+<CR>
"inoremap <A-k> <Esc>:m-2<CR>
"vnoremap <A-j> :m'>+<CR>gv
"vnoremap <A-k> :m-2<CR>gv

if exists("+undofile")
" undofile - This allows you to use undos after exiting and restarting
" This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
" :help undo-persistence
" This is only present in 7.3+
if isdirectory($HOME . '/.vim/undo') == 0
:silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
endif
set undodir=./.vim-undo//
set undodir+=~/.vim/undo//
set undofile
endif

"beginning of line and end of line quickly
noremap H ^
onoremap H ^

nnoremap L $
onoremap L $
vnoremap L $h 

map gc <leader>c<space>

"spellcheck git commit messages
autocmd BufRead COMMIT_EDITMSG setlocal spell!

"change buffers quickly
nmap <leader>b :ls<CR>:buffer<Space>

"tabs to spaces
"nnoremap <leader>T :set expandtab<cr>:retab!<cr>

"quick splitting
nnoremap <silent> ss :split<Space>
nnoremap <silent> vv :vsplit<Space>

"remap the enter to :
noremap <CR> :


"set relative line numbering
set rnu




function! MyFunc()
    let m = visualmode()
    if m ==# 'v'
        echo 'character-wise visual'
    elseif m == 'V'
        echo 'line-wise visual'
    elseif m == "\<C-V>"
        echo 'block-wise visual'
        let c = strpart(getline("."), col("."), 1)
        echo 'your col, line is'
        echo c
    endif
endfunction

function! s:NathanFunc()
  let c = strpart(getline("."), col(".") - 1, 1)
  if g:move_unify_whitespace && (c==" " || c=="\t")
    let c = ""
  endif
  return c
endfunction

"surround visual selection with parens
vnoremap sq <Esc>`>a"<Esc>`<i"<Esc>
vnoremap sp <Esc>`>a)<Esc>`<i(<Esc>
vnoremap sc <Esc>`>a}<Esc>`<i{<Esc>
vnoremap sb <Esc>`>a]<Esc>`<i[<Esc>
vnoremap s' <Esc>`>a'<Esc>`<i'<Esc>
vnoremap sa <Esc>`>a><Esc>`<i<<Esc>

autocmd FileType perl vnoremap <buffer> ss <Esc>`>o=comment<Esc>`<O=cut<Esc>
autocmd FileType c vnoremap <buffer> ss <Esc>`>a/*<Esc>`<i*/<Esc>


function! MyFunc3()
    let m = visualmode()
    if m ==# 'v'
        let c = col(".")
"        while c > 0
"            echom 'block-wise visual test'
"        endwhile
        echom c
    endif
endfunction


"doesn't work with visual mode?
"doesn't work with visual mode?
"onoremap p :<c-u>normal! f(vi(<c
"onoremap p :<c-u>normal! /(<cr>:normal! vi(<cr>

"onoremap p :<c-u>execute "normal! /(\rlvi("<cr>
onoremap p :<c-u>execute "normal! /(\r:noh\rlvi("<cr>
onoremap P :<c-u>execute "normal! ?)\r:noh\rhvi)"<cr>

onoremap q :<c-u>execute "normal! /\"\r:noh\rlvi\""<cr>
onoremap Q :<c-u>execute "normal! ?\"\r:noh\rhvi\""<cr>

onoremap c :<c-u>execute "normal! /{\r:noh\rvi{"<cr>
onoremap C :<c-u>execute "normal! ?}\r:noh\rvi}"<cr>

"nnoremap J :call CompareVsplit('J')<cr>
"nnoremap K :call CompareVsplit('K')<cr>

"function! CompareVsplit(direction)
"
"    if a:direction == 'J'
"        execute "normal! \<c-w>t"
"        execute ":set cursorline"
"        execute "normal! jzz"
"        execute "normal! \<c-w>b"
"        execute ":set cursorline"
"        execute "normal! jzz"
"    endif
"
"    if a:direction == 'K'
"        execute "normal! \<c-w>t"
"        execute ":set cursorline"
"        execute "normal! kzz"
"        execute "normal! \<c-w>b"
"        execute ":set cursorline"
"        execute "normal! kzz"
"    endif
"
"endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"scratch area


"onoremap P :<c-u>normal! F)vi)<cr>
"
"onoremap q :<c-u>normal! f"vi"<cr>
"onoremap Q :<c-u>normal! F"vi"<cr>
"
"onoremap c :<c-u>normal! f{vi{<cr>
"onoremap C :<c-u>normal! F}vi}<cr>
"d
"foo (foo bar{whoa!})
"foo bar {"whoooah"}
"foo barfoo bar(whoa!)
"foo bar(whoa!)
"foo bar{whoa!}
"foo bar{"whoa!"}
"foo bar(whoa!)
"
"
"foo bar(whoa!)
"foo bar(whoa!)
"foo bar(whoaaa)

"pattern			cursor position	~
"/test/+1		one line below "test", in column 1
"/test/e			on the last t of "test"
"/test/s+2		on the 's' of "test"
"/test/b-3		three characters before "test"

"set shiftround?
"
"
"setlocal
"
"au QuitPre * if empty(bufname('%')) | setlocal nomodified | endif
"au VimLeavePre * if 1 | echom "things" | endif
"
command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>

"set path+=app/**   


cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

"if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && version >= 700
"  let &listchars = "tab:\u21e5\u00b7,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
"  let &fillchars = "vert:\u259a,fold:\u00b7"
"else
"  set listchars=tab:>\ ,trail:-,extends:>,precedes:<
"endif



"
"
"
"
"set complete-=i     " Searching includes can be slow
"
"function! s:try(cmd, default)
"  if exists(':' . a:cmd) && !v:count
"    let tick = b:changedtick
"    exe a:cmd
"    if tick == b:changedtick
"      execute 'normal! '.a:default
"    endif
"  else
"    execute 'normal! '.v:count.a:default
"  endif
"endfunction
"
"nnoremap <silent> gJ :<C-U>call <SID>try('SplitjoinJoin', 'gJ')<CR>
"nnoremap <silent>  J :<C-U>call <SID>try('SplitjoinJoin', 'J')<CR>
"nnoremap <silent> gS :SplitjoinSplit<CR>
"nnoremap <silent>  S :<C-U>call <SID>try('SplitjoinSplit', 'S')<CR>
"nnoremap <silent> r<CR> :<C-U>call <SID>try('SplitjoinSplit', "r\015")<CR>
"
"
"
"command! -bar -nargs=1 -complete=file E :exe "edit ".substitute(<q-args>,'\(.*\):\(\d\+\):\=$','+\2 \1','')
"command! -bar -nargs=? -bang Scratch :silent enew<bang>|set buftype=nofile bufhidden=hide noswapfile buflisted filetype=<args> modifiable
"command! -bar -count=0 RFC     :e http://www.ietf.org/rfc/rfc<count>.txt|setl ro noma
"function! s:scratch_maps() abort
"  nnoremap <silent> <buffer> == :Scratch<CR>
"  nnoremap <silent> <buffer> =" :Scratch<Bar>put<Bar>1delete _<Bar>filetype detect<CR>
"  nnoremap <silent> <buffer> =* :Scratch<Bar>put *<Bar>1delete _<Bar>filetype detect<CR>
"  nnoremap          <buffer> =f :Scratch<Bar>setfiletype<Space>
"endfunction
"
"
"function! Fancy()
"  if &number
"    if has("gui_running")
"      let &columns=&columns-12
"    endif
"    windo set nonumber foldcolumn=0
"    if exists("+cursorcolumn")
"      set nocursorcolumn nocursorline
"    endif
"  else
"    if has("gui_running")
"      let &columns=&columns+12
"    endif
"    windo set number foldcolumn=4
"    if exists("+cursorcolumn")
"      set cursorline
"    endif
"  endif
"endfunction
"command! -bar Fancy :call Fancy()
command! -bar Invert :let &background = (&background=="light"?"dark":"light")


"set foldlevelstart=99
set foldlevelstart=0


" Strip trailing whitespace {{{2
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

"nmap gh :call Preserve("%s/\\s\\+$//e")<CR>

"xnoremap . :normal .<CR>
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction



command! Path :call EchoPath()
function! EchoPath()
  echo join(split(&path, ","), "\n")
endfunction

command! TagFiles :call EchoTags()
function! EchoTags()
  echo join(split(&tags, ","), "\n")
endfunction



" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
"nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
"noremap <space> :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>

"noremap <space> :set hls<Cr>:call AutoUndoHighlight('on')<Cr>/
"noremap n :set hls<Cr>:call AutoUndoHighlight('on')<Cr>n
"noremap N :set hls<Cr>:call AutoUndoHighlight('on')<Cr>N
"
"function! AutoUndoHighlight(command)
"    if a:command == 'on'
"        augroup auto_highlight_toggle
"          au!
"          au CursorHold * set nohls | call AutoUndoHighlight('off')
"        augroup end
"        setl updatetime=700
"        echo 'Limited time highlighting'
"    elseif a:command == 'off'
"        echo "going off"
"        au! auto_highlight_toggle
"        augroup! auto_highlight_toggle
"        setl updatetime=4000
"    endif
"endfunction
"endfunction
"endfunction
"endfunction
"endfunction

"noremap <space>n :call TurnOnLines()<Cr>
"noremap <space> :call Thing()<Cr>/

function! Thing()
    echom "aaa"
au CursorMoved * nohls
au InsertEnter * nohls
au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
endfunction

highlight MyGroup ctermbg=0 guibg=green
":match MyGroup /TODO/ 

function! TurnOnLines()
    hi CursorLine cterm=NONE ctermbg=0
    hi CursorColumn cterm=NONE ctermbg=0
    set cursorline! cursorcolumn!
    "let c = nr2char(getchar())
    "while c =~ '\v^(n|N)$'
    "    execute "normal! ".c
    "endwhile
    "set cursorline! cursorcolumn!
    "execute "normal! ".c
endfunction

function! PrintIt(command)
    echom "printit has been called"
    let @" = a:command
endfunction

function! DoThing(command)
    echom "doing ".a:command
    execute "normal! ".a:command
endfunction

noremap <space> :call DoSearch('search')<Cr>/

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
        hi CursorLine   cterm=NONE ctermbg=0
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
            echom "doing nothing"
            execute "normal! ".c
            redraw
            let c = nr2char(getchar())
        endwhile
        set hls!
        set nocursorline nocursorcolumn
        "if g:waswrap
        "    set wrap
        "endif
        call feedkeys(c)
    endif
endfunction

nmap yyy :call FFF()<Cr>

"  let c = getchar()
"  if c =~ '^\d\+$'
"execute "normal! /command\<Cr>"

function! AutoHighlightToggle()
    "let the search reg be empty
  let @/ = ''
  "if the aucommand exists
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    "set local (to window) update time for writing swap files
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

"cterm = 
"ctermbg = changes colour of line background
"ctermfg = changes colour of line text - foreground
"guibg = (bacground colour (does nothing))
"guifg = (foreground colour (does nothing))

"nnoremap <Leader>v :hi CursorLine   cterm=NONE ctermbg=grey ctermfg=white guibg=darkred guifg=white
nnoremap <Leader>v :hi CursorLine   cterm=NONE ctermbg=0
nnoremap <Leader>b :hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
nnoremap <Leader>n :set cursorline! cursorcolumn!<CR>
      "au CursorHold * set nohls | let c = nr2char(getchar()) | if c =~ '\v^(n|N)$' |call DoThing(c) | endif | call HighlightWaitForIt('off')
      "
      "
      "
"while c =~ '\v^(n|N)$'
"    execute "normal! ".c
"endwhile
"execute "normal! ".c
"
set wrap
