"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"      =Paths, runtime, startup
"      =General, plugins
"      =Colours
"      =Regex and search
"      =Open,save, backup and undo
"      =Indent
"      =Visual mode
"      =Tabs, splits and buffers
"      =Status line and line numbering
"      =Folding
"      =Spell check, autocomplete
"      =Misc. settings
"      =Macros
"      =Moving around
"      =Terminal
"      =Tags
"      =TODO
"      =Misc. mappings
"      =Scratch area
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Paths, runtime, startup=============

"Vimrc configuration options for system dependent settings
let wantSolarized          = 1
let wantPathogen           = 1 " Req for: solarized
let wantDoSearch           = 1 " Different search highlighting. Best with solarized
let wantCOC                = 0

" Note *** MAY HAVE TO MOD THESE FOR NEW INSTALL *** TODO: (`HUT`) : make generic
"set runtimepath=~/.vim,/etc/vim,/usr/share/vim/vimfiles/,usr/share/vim/addons/,/usr/share/vim/vim74,/usr/share/vim/vimfiles,/usr/share/vim/addons/after/,~/.vim/after,/usr/local/share/vim/vim81,~/.vim/syntax

set runtimepath+=/usr/local/share/vim/vim80,/usr/share/vim/vim81

" point vimruntime somewhere interesting (syntax/help stuff) *** MAY HAVE TO MOD THESE FOR NEW INSTALL *** TODO: (`HUT`) : make generic
" TODO: (`HUT`) : change all xxxs
"let $VIMRUNTIME = "/ XXX /runtime"

" Specify the location of our helpfile
" NOTE: (`HUT`) : to add helpfiles do :helptags ~/.vim/bundle/path/doc then check with :help local-additions (need to reload vim) (try also :Helptags for pathogen adder)
"set helpfile=/ XXX runtime/doc/help.txt

" Common values we want to set
set nocompatible               " Be iMproved
set scrolloff=3                " How many lines between cursor and bottom/top of screen
set showcmd                    " show commands as being typed
set ruler                      " Always show current position - does nothing?
set cmdheight=2                " Height of the command bar
set showmatch                  " Show matching brackets when text indicator is over them
set mat=2                      " How many tenths of a second to blink when matching brackets
set lazyredraw                 " Don't redraw while executing macros (good performance config)
set wrap                       " Wrap lines
set showbreak=↪\ \ 		       " string to put before wrapped screen lines
set wildmenu                   " Turn on the WiLd menu
set wildmode=full
set hid                        " A buffer becomes hidden when it is abandoned

" syntax is broken somehow so that it throws an error Error detected while processing function <SNR>62_Highlight_Matching_Pair:
" TODO(HUT): fix this
"NoMatchParen
let loaded_matchparen = 1

" Mapleader - need to have this before any leader mappings
let mapleader   = ","
let g:mapleader = ","

" Show spaces/tabs - set how to show spaces, tabs, trailing space etc.
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<

" Ignore compiled files etc. May be added to later depending on filetype
set wildignore+=*.o,*~,*.pyc,*.gise,*.cmd,*.xmsgs,*isim,*.xise,*.prj,*.wdb,*.ini,*.exe,*.html,*.d
set wildignore+=*.lsrc,*.crp,*.ngc,run-d.sh,docker_ccache,node_modules

set wildignore+=*/build/*,*/cmake-build-debug/*,*/asio/*,*/vendorr/*,*/xcodebuild/*,*/*build_*/*,*/*build-*/*,*/linalg/*,*/*_build*/*

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Treat long lines as break lines (useful when moving around in them)
noremap j gj
noremap k gk

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============General, plugins=============
"
"TODO: create more robust method for pathogen install (am I using pathogen?)
if(g:wantPathogen)
    execute pathogen#infect()
endif

"""""""""""""""""""""""""""""""""""""""""
" CTRLP plugin

set maxmempattern=5000

"Let's use ctrl-f to find files - note it triggers from current working dir
let g:ctrlp_map = '<c-f>'

"Set the default opening command to use when pressing the above mapping: >
"let g:ctrlp_cmd = 'CtrlPMixed'

set runtimepath^=~/.vim/bundle/ctrlp.vim

" Set this to 0 to enable cross-session caching by not deleting the cache files upon exiting Vim:
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

"Set this to 1 to set searching by filename (as opposed to full path) as the default: >
let g:ctrlp_by_filename = 1

"When starting up, CtrlP sets its local working directory according to this variable: > 0 is pwd
let g:ctrlp_working_path_mode = '0'

" follow sym links
let g:ctrlp_follow_symlinks = 1

let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40

" amount of most recently used files to keep track of (will prioritise when searching)
let g:ctrlp_mruf_max = 250

" Make it search faster
" TODO: (`HUT`) : : might want to switch between ag and grep here
"if executable('ag')
"    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"endif

let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

"""""""""""""""""""""""""""""""""""""""""
" EasyAlign plugin

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Default comment behaviour:
"   If a delimiter is in a highlight group whose name matches
"   any of the followings, it will be ignored. a '!' means the opposite effect.
"   By default, we want to be able to format comments, so DON'T ignore
let g:easy_align_ignore_groups = ['String']

" Custom easy align rules
let g:easy_align_delimiters = {
            \ ':' : { 'pattern': ':',
            \         'ignore_groups': ['Comment'],
            \         'align': 'l' },
            \ '/' : { 'pattern': '/',
            \         'ignore_groups': ['!Comment'],
            \         'right_margin': 0},
            \ ';' : { 'pattern': ';',
            \         'ignore_groups': ['Comment'],
            \         'stick_to_left': 1,
            \         'left_margin': 0
            \                          }
            \}

"""""""""""""""""""""""""""""""""""""""""
" Syntastic plugin
nnoremap <leader>e :Errors<Cr><C-W>j

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 2 " When set to 2 the error window will be automatically closed when there are no errors
let g:syntastic_check_on_open            = 1
let g:syntastic_check_on_wq              = 0
let g:syntastic_debug                    = 0 " debug syntastic during use - useful are 1, 3, 33
let g:syntastic_loc_list_height          = 5 " height of errors window

" VHDL specific settings
"let g:syntastic_vhdl_checkers  = ["vcom_filter"] " This won't let you call some other wrapper program, I think
"let g:syntastic_vhdl_checkers  = ["nothing"] " This won't let you call some other wrapper program, I think
let g:syntastic_vhdl_checkers  = ["vcom_filter"] " This won't let you call some other wrapper program, I think

let g:syntastic_vhdl_vcom_args  = "-check_synthesis"  " warnings as errors
let g:syntastic_vhdl_vcom_args += "+cover=sbceft"     " something about code coverage
let g:syntastic_vhdl_vcom_args += "-coverenhanced"    " warnings as errors
let g:syntastic_vhdl_vcom_args += "-fsmimplicittrans" " Enable recognition of implicit transitions in FSM
let g:syntastic_vhdl_vcom_args += "-fsmsingle"        " Enable recognition FSMs having single bit current state variable
let g:syntastic_vhdl_vcom_args += "-quiet"            " disable loading messages
let g:syntastic_vhdl_vcom_args += "-pedanticerrors"
let g:syntastic_vhdl_vcom_args += "-lint"

""let g:syntastic_vhdl_vcom_args += "-skip e"

"let g:syntastic_vhdl_vcom_tail = "2>&1 | grep -v \"vcom-1239\""                   " Pipe the output of vcom into a program that will try and handle/solve the errors
"let g:syntastic_vhdl_vcom_tail = "2>&1 | test_out"

let g:syntastic_disabled_filetypes=['python']
let g:syntastic_disabled_filetypes=['bash']

let g:syntastic_python_checkers=['']

"""""""""""""""""""""""""""""""""""""""""
" CurtineIncSw plugin
" plugin to switch between header and source file

nnoremap <leader>h :call CurtineIncSw()<CR>

" Toggling between headers for filetypes - old way only worked for header in the same directory
" autocmd FileType * :nnoremap <leader>h :e <c-r>=expand('%:p')<Cr>

"""""""""""""""""""""""""""""""""""""""""
" COC plugin
"

if(g:wantCOC)
    call plug#begin('~/.vim/plugged')

    Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

    call plug#end()

    " if hidden not set, TextEdit might fail.
    set hidden

    " Better display for messages
    set cmdheight=2

    " Smaller updatetime for CursorHold & CursorHoldI
    set updatetime=300

    " don't give |ins-completion-menu| messages.
    set shortmess+=c

    " always show signcolumns
    set signcolumn=yes

    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> for trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[c` and `]c` for navigate diagnostics
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K for show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if &filetype == 'vim'
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    " Remap for format selected region
    vmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup END

    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    vmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap for do codeAction of current line
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Use `:Format` for format current buffer
    command! -nargs=0 Format :call CocAction('format')

    " Use `:Fold` for fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)


    " Add diagnostic info for https://github.com/itchyny/lightline.vim
    let g:lightline = {
          \ 'colorscheme': 'wombat',
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ],
          \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
          \ },
          \ 'component_function': {
          \   'cocstatus': 'coc#status'
          \ },
          \ }



    " Using CocList
    " Show all diagnostics
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

endif

"""""""""""""""""""""""""""""""""""""""""
" LanguageClient-neovim
"

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ 'go': ['go-langserver'],
    \ }

nnoremap <F6> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> Z :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Do not use tags to jump to definitions, instead use LanguageClient
nnoremap ] :call LanguageClient#textDocument_definition()<CR>

set runtimepath+=~/.vim/manually_installed/LanguageClient-neovim

"https://www.reddit.com/r/vim/comments/b33lc1/a_guide_to_lsp_auto_completion_in_vim/
let g:LanguageClient_autoStart = 1

" We don't want our quickfix list always spammed with diagnostics
let g:LanguageClient_diagnosticsList = 'Disabled'

"let g:LanguageClient_serverCommands = {
"  \ 'cpp': ['clangd'],
"  \ }

let g:mucomplete#completion_delay = 1
"let g:mucomplete#completion_delay = 500
"let g:mucomplete#reopen_immediately = 0

"if executable('cquery')
"     " Let the client know that for c and cpp files, use cquery.
"     let g:LanguageClient_serverCommands = {
"        \ 'c':   ['cquery', '--log-file=/tmp/vim-cquery.log',
"        \         '--init={"cacheDirectory":"$HOME/.cquery-cache"}'],
"        \ 'cpp': ['cquery', '--log-file=/tmp/vim-cquery.log',
"        \         '--init={"cacheDirectory":"$HOME/.cquery-cache"}'],
"        \ }
"endif

"nnoremap z :call LanguageClient_contextMenu()<CR>

inoremap <silent><expr> <c-space> LanguageClient#textDocument_completion()
"inoremap <silent><expr> <leader>q <C-R>=LanguageClient#textDocument_completion()<Cr>

"""""""""""""""""""""""""""""""""""""""""
" mu-complete
" From https://www.reddit.com/r/vim/comments/b33lc1/a_guide_to_lsp_auto_completion_in_vim/
" Mandatory options for plugin to work
set completeopt+=menuone
set completeopt+=noselect

" Note: this is vim-specific (doesn't matter if mu-complete is enabled), and it stops a preview window
" popping up when you tab complete.
" https://github.com/Shougo/neocomplete.vim/issues/472
set completeopt-=preview

" Shut off completion messages
set shortmess+=c
" prevent a condition where vim lags due to searching include files.
set complete-=i
let g:mucomplete#enable_auto_at_startup = 1
" :help mucomplete#chains for more details
let g:mucomplete#chains = {}
let g:mucomplete#chains.default  = ['path', 'omni', 'keyn', 'dict', 'uspl', 'ulti']
let g:mucomplete#chains.markdown = ['path', 'keyn', 'dict', 'uspl']
let g:mucomplete#chains.vim      = ['path', 'keyn', 'dict', 'uspl']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Colours=============

" Syntax highlighting
"au BufRead,BufNewFile *.fetch set filetype=etch
"au BufRead,BufNewFile *.fetch setfiletype cel
"au BufRead,BufNewFile *.fetch set filetype=etch

" Choose colorscheme - solarized or desert
if(!exists("g:haveSetColourScheme"))
    let haveSetColourScheme          = 1

    if(g:wantSolarized)
        let setColourScheme          = 0
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
        " Desert as good a scheme as any I suppose
        colorscheme desert
        "colorscheme murphy
        "colorscheme default
    endif
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

" quickly search/replace word under cursor
nnoremap <leader>s "9yiw:let@"="<c-r><c-0>"<Cr>:%s/<C-r><C-9>/<C-r><C-9>
vnoremap <leader>s "9y:let@"="<c-r><c-0>"<Cr>:%s/<C-r><C-9>/<C-r><C-9>

"Modified search function has slightly more intelligent highlighting
if(g:wantDoSearch)
    nnoremap <space> :call DoSearch('search')<Cr>/
else
   nnoremap <space> /
endif

"For visual and operator-pending mode, we don't want any funny buisness - just search normally
vnoremap <space> /
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
        augroup END
    elseif a:command == 'iterate'
        setl updatetime=4000
        au! flicker_command
        "augroup! flicker_command augroup END
        let c = nr2char(getchar())
        while c =~ '\v^(n|N)$'
            " Note we don't put these jumps into our jumplist, that way we can ctrl-o back to before the search quicker
            execute "keepjumps normal! ".c
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
" =============Open,save, backup and undo=============

set nobackup        " Turn backup etc. off, since most stuff is in SVN, git etc anyway...
set nowb
set noswapfile
set confirm         " Ask if want to save before closing modified file

"Fast save, quit etc.
nnoremap <leader>w :w<cr>
nnoremap <leader>wq :wq<cr>

" Quit all on ctrl d
nnoremap <C-d> :qall

"If we want to quit, just quit without confirming if the buffer is unnamed
nnoremap <leader>q :call QuitIfEmpty()<CR>:q<Cr>

" Get rid of annoying quit accidents
command! -bar Q :q
cnoremap q1 q!

" Open the file under the cursor (relative to file's working directory!)
nnoremap <leader>o yiW:tabe %:h/<C-r><C-"><Cr>

"Check current buffer is saved and put vim into background 
nnoremap <leader>v :call CheckSavedBuffer()<cr><C-z>
"au FocusLost <c-z>

" Delete trailing white space on save/clean files - disabled for now since it touches too many files
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

"autocmd BufWrite *.cpp :call CleanFile()
"autocmd BufWrite *.c :call CleanFile()
"autocmd BufWrite *.h :call CleanFile()
"autocmd BufWrite *.vhd :call CleanFile()

autocmd FileType cpp      set list
autocmd FileType c        set list

autocmd BufRead,BufNewFile *.mrp set nowrap

"autocmd BufRead,BufNewFile *.mrp set foldmethod=indent
"autocmd BufRead,BufNewFile *.mrp set tabstop=2

" echo len((split(getline(v:lnum),'[^+]')+["-"])[0])
" set foldexpr=len((split(getline(v:lnum),'[^+]')+["-"])[0])
"
" set foldexpr=len((split(getline(v:lnum),'[^+]')+[7])[0])
" set foldmethod=expr


autocmd BufRead,BufNewFile *.srp set nowrap
autocmd BufRead,BufNewFile *.twr set nowrap

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

" Clean up files when saving
func! CleanFile()
  exe "normal mz"
  %s/\s\+$//ge
  %s/\t/  /ge
  %s///ge
  "%s/^//ge
  "  /^\t*\zs \+/
  exe "normal `z"
endfunc

" Remove whitespace only on lines
func! CleanWhiteSpace()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Indent=============

set ai "Auto indent
"set si "Smart indent
"set indentexpr

" Indent the whole file
nnoremap == gg=G<c-o><c-o>gg=G<c-o><c-o>zz

" Special indenting for certain filetypes
autocmd FileType vhdl :nnoremap == :call CleanVhdl()<Cr>
"autocmd FileType vhdl :so ~/ XXX /vim74/runtime/indent/vhdl.vim

" TODO: (`HUT`) :: this should only do things to signals...
function! CleanVhdl()
  execute "mark e"
  execute "call CleanFile()"
  execute "normal gg=G"

  execute ":/^entity/,/^architecture/EasyAlign:"
  execute ":/^architecture/,/^begin/EasyAlign:"
  "execute ":/port map/,/);/EasyAlign="

  execute "'e"
  execute "normal zz"
endfunction

"keeps your visual selection when indenting
vnoremap < <<gv
vnoremap > >>gv

"Note: set expandtab<cr>:retab!<cr> will turn tabs to spaces

" Note: find out what the filetype is with :set filetype?
"Default tab expansion for 
autocmd FileType *                    set tabstop=4| set shiftwidth=4| set expandtab    | set smarttab
autocmd FileType snippets             set tabstop=2| set shiftwidth=2| set noexpandtab
autocmd FileType tcl                  set tabstop=2| set shiftwidth=2| set smarttab     | set expandtab
autocmd FileType cpp                  set tabstop=2| set shiftwidth=2| set smarttab
autocmd FileType c                    set tabstop=2| set shiftwidth=2| set noexpandtab
autocmd FileType vhdl                 set tabstop=2| set shiftwidth=2| set smarttab
autocmd FileType markdown             set tabstop=4| set shiftwidth=4| set noexpandtab
autocmd FileType make                 set tabstop=4| set shiftwidth=4| set noexpandtab
autocmd FileType go                   set tabstop=2| set shiftwidth=2| set noexpandtab
autocmd FileType vim                  set tabstop=2| set shiftwidth=2| set smarttab
autocmd FileType typescriptreact      set tabstop=2| set shiftwidth=2| set smarttab
autocmd FileType typescript           set tabstop=2| set shiftwidth=2| set smarttab

" Make vhdl auto-indent the same as other languages
let g:vhdl_indent_genportmap = 0

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Tabs, splits and buffers=============

set diffopt+=vertical       " start diff mode with vertical splits by default
set splitright splitbelow   "makes the vsplit open on the RHS and split on the bottom

" Easier way to move between splits
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

"Use ctrl-u and p to switch between tabs
nnoremap <C-u> gT
nnoremap <C-p> gt

"Use ctrl-t and y to change split window size
nnoremap <C-t> <C-w>-
nnoremap <C-y> <C-w>+

"Trawl through errors
nnoremap <leader>n :cn<cr>

au BufReadPost quickfix  setlocal modifiable
        \ | silent exe 'g/^||/s//>'
        \ | setlocal nomodifiable

" Set quickfix/copen to not wrap
augroup quickfix
    autocmd!
    autocmd FileType qf setlocal nowrap
augroup END

"nnoremap <leader>d :echom hello

" Possibly useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

"change buffers quickly
"nmap <leader>b :ls<CR>:buffer<Space>

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

"Indent highlighting with vim-indent-guides
"## Usage
"The default mapping to toggle the plugin is `<Leader>ig`

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=66
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=0

" Don't consider tabs as indentation
let g:indent_guides_tab_guides = 0
"let g:indent_guides_space_guides = 0

"Turn on highlighting
let g:indent_guides_enable_on_vim_startup = 0

" Hopefully this will make the tab you go to after closing a tab the one on the left instead of the right
let s:prevtabnum=tabpagenr('$')
let s:prevtabindex=tabpagenr()

augroup TabLeaving
        autocmd! TabLeave * :let s:prevtabindex=tabpagenr()
augroup END

augroup TabClosed
        autocmd! TabEnter * :if tabpagenr('$')<s:prevtabnum && tabpagenr()>1 && s:prevtabindex==tabpagenr()
                    \ | tabprevious
                    \ | endif
                    \ | let s:prevtabnum=tabpagenr('$')
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Status line and line numbering=============

"set rnu "set relative line numbering
set number

" Always show the status line
set laststatus=2

" Set the status line
set statusline=%{getcwd()}\ \ \  "Display current working directory
set statusline+=%F                "Display file path in full
set statusline+=[%1*%M%*%n]       "Display file save status in red, buffer number
set statusline+=%y                "type of file as square
set statusline+=%1*%r%*           "Readonly flag as square - set to red
set statusline+=%h                "Help flag as sqare
set statusline+=%=                "orients the rest to the RHS
set statusline+=%l                "Show line/lines
set statusline+=/%L
" syntactic status line addition
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

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
"
" Cheat sheet:
" zg - add word to dictionary
" <leader>z - autocorrect to best match

" Default to having spelling enabled
set spell spelllang=en_gb

"Ignore all the cruft when searching with certain filetypes
autocmd FileType vhdl set wildignore+=iseconfig\/,_xmsgs\/,ipcore_dir\/

nnoremap <leader>z z=1<Cr><Cr>

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
"set complete-=i     " Searching includes can be slow

"spell check when writing commit logs
autocmd filetype svn,*commit*,text setlocal spell

"Use TAB to complete when typing words, else inserts TABs as usual.
"Uses dictionary and source files to find matching words to complete.
"Note: usual completion is on <C-n> but more trouble to press all the time. (:help ins-completion)
"inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
"

"Lets get some supertab stuff on the go - want to just use nice old user complete rather than fancy omni etc.
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
"let g:SuperTabDefaultCompletionType = "<c-n>"

"let g:SuperTabDefaultCompletionType = 'context'
"autocmd FileType *
"\ if &omnifunc != '' |
"\   call SuperTabChain(&omnifunc, "<c-n>") |
"\ endif

function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    echom "return tab"
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Misc. settings=============

filetype plugin indent on      " Required!
set omnifunc=syntaxcomplete#Complete
set history=700                " Sets how many lines of history VIM has to remember
set autoread                   " Set to auto read when a file is changed from the outside
set encoding=utf8              " Set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac           " Use Unix as the standard file type
set lbr                        " Linebreak on 500 characters
set tw=500
set clipboard=unnamedplus      " Yank to the system clipboard by default
"set clipboard+=ideaput " do 'put' via IDE in jetbrains tools

"disable paste mode when leaving normal mode
au InsertLeave * set nopaste

" No annoying sound on errors
" https://superuser.com/questions/622898/how-to-turn-off-the-bell-sound-in-intellij
set visualbell
set noerrorbells
set t_vb=
set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Macros=============

"map Q to do last executed macro, or in visual mode execute 'q' macro over range TODO: (`HUT`) : make this safe
nnoremap Q @q
vnoremap Q :normal @q<Cr>

" TODO: (`HUT`) : gc-like macro line by line
"Execute macro over visual TODO:why xmap
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "Execute which macro?"
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Moving around=============

" Enable clicking. Note: turn off with set mouse=c
set mouse=a

"beginning of line and end of line quickly (operator-pending as well)
noremap H ^
onoremap H ^

" TODO: (`HUT`) : improve this a lot
"nnoremap J :echo "CAPS LOCK?"<cr>}jzz
"nnoremap K :echo "CAPS LOCK?"<cr>{kzz
nnoremap J }jzz
nnoremap K {kzz
vnoremap J /^$<Cr>
vnoremap K ?^$<Cr>

"Don't want to select the end of line in visual mode
nnoremap L $
onoremap L $

" Marks
nnoremap '' 'm

function! PrintMssg(messg)
    echohl WarningMsg | echo a:messg | echohl None
endfunction

" Want different behaviours for block and normal visual mode
" Note: this wrecks when used in a macro for some reason
vnoremap L :<C-u>call MoveToEndOfLine()<CR>

function! MoveToEndOfLine()
    let m = visualmode()
    if m == "\<C-V>"
        call feedkeys("gv$")
    else
        call feedkeys("gv$h")
    endif
endfunction

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
" =============Terminal=============

" Mappings/settings for vim8+ terminal :term

" Moving between splits
tnoremap <C-j> <C-W>j
tnoremap <C-k> <C-W>k
tnoremap <C-h> <C-W>h
tnoremap <C-l> <C-W>l

"quitting
tnoremap <leader>q <C-D>

"Toggle terminal
"nnoremap <leader>f :terminal<Cr>
tnoremap <leader>f <C-C><C-D>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Tags=============

" Override ctrl-} behaviour to open a new window with the tag
nnoremap } <C-w><C-]><C-w>T
"nnoremap ] *<C-]>0hn

nnoremap { g<C-]>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============TODO=============
" A command to scrape all the TODOs to the top of the file
"
"
"make non-me mode, overload / as well
"vippppp objects
"gather(regex)

"cabbrev ccc s/\v\t+:/\s:/

function! TODO() 
    normal! o//todolist
    "make a mark t for todo
    normal! mt
    execute ":g/TODO/normal yygg'tp==jk"
endfunction

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
"cmap w!! %!sudo tee > /dev/null 
cmap w!! w !sudo tee > /dev/null %

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
"function! TODOThing()
"au CursorMoved * nohls
"au InsertEnter * nohls
"au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
"endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Misc. mappings=============

"Use :Invert to invert the background from dark to light
command! -bar Invert :let &background = (&background=="light"?"dark":"light")

"Since our mapleader is ',' we repurpose '/' which is mapped to <space>
nnoremap / ,

"Remap jk and kj and kj to esc in insert mode, and select mode (!)
"inoremap jk <Esc>
inoremap kj <Esc>
snoremap kj <Esc>B

"Auto-caps to-do
iabbrev todo TODO(HUT):
iabbrev Todo TODO(HUT):

noremap <leader>y :!rm -f ~/.clipboard<Cr><Cr>:redir! > ~/.clipboard<Cr>:echon @"<Cr>:redir END<Cr>
nnoremap <leader>p :-1r ~/.clipboard<Cr>

"noremap Y :call system('tee ~/clip', @0)<Cr>

" TODO: (`HUT`) : place this
iabbrev zn \n

"Faster command-mode manipulation, quick reg access, fast history search
cnoremap <leader>r <C-r><C-">
"vnoremap <leader>r <C-r><C-">
cnoremap <C-J> <Down>
cnoremap <C-K> <Up>
cnoremap <C-L> <Right>
cnoremap <C-H> <Left>

"Expands %% to the path of the file currently being edited rather than where vim was opened
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

"Want the filename too
cnoremap <expr> ^^ getcmdtype() == ':' ? expand('%:t') : '^^'

"Convert all of the under_score in the file to camelCase
"http://vim.wikia.com/wiki/Changing_case_with_regular_expressions (also \C and \l)
function! CamelCase()
    "sub char_char, with second char not allowing to be _t (uint8_t)
    execute '%s/\C\v([a-z0-9])_(t[^a-zA-Z0-9])@!([a-z0-9])/\1\u\3/gc'
endfunction

" Remove the Windows ^M - when the encodings gets messed up
"noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Automatically format selection - <C-U> removes the '<,'> automatically inserted so fn is called only once
"vnoremap <leader>f :<C-U>call FormatVisualSelection('spaces')<Cr><Cr>:messages<cr>

function! FormatVisualSelection(tabsOrSpaces)
    "This will act as a counter for how long the longest word is in our selection
    let g:maxCharLen = 0

    echom "working"

    "let @9 = "^:let wordStart = col('.')e:let wordLength = col('.') - wordStart + 1:if(wordLength > maxCharLen) | echo 'art' | endif"

    if a:tabsOrSpaces == 'spaces'
        "For each line, find the maximum number of characters
        "execute ":'<,'> ^col('.')>1"
        for i in range((line("'>") - line("'<") + 1))
            "Find the longest word per line
            "let g:exeString = "".(i+line("'<"))."print"

            let g:exeString = "normal "
            let g:exeString = g:exeString.(i+line("'<"))."gg"
            let g:exeString = g:exeString."^lh"
            execute g:exeString

            let g:exeString = "normal "
            let g:exeString = g:exeString.":let g:wordStart = col('.')"
            "this getline and col thing are off by 1 for some awful reason
            if(getline('.')[col('.')] != ' ')
                let g:exeString = g:exeString."E"
            endif
            "echom "nextchar is ".getline('.')[col('.') + 1]
            let g:exeString = g:exeString.":let g:wordLength = col('.') - g:wordStart + 1"
            let g:exeString = g:exeString.":if(g:wordLength > g:maxCharLen)"
            let g:exeString = g:exeString."| let g:maxCharLen = g:wordLength"
            let g:exeString = g:exeString."| endif"

            execute g:exeString
            "echom "Line is ".i." wordlength is ".g:wordLength."\n"
            "echom "Exe is "
            "echom "".g:exeString
        endfor

        "Now we should know how many tabs/spaces to input
        for i in range((line("'>") - line("'<") + 1))

            let tabsToInsert = (g:maxCharLen/4) + 1


            for j in range(tabsToInsert)
                "echom "inserting tab "
                "Insert as many tabs as we need
                let g:exeString = "normal! "
                let g:exeString = g:exeString.(i+line("'<"))."gg^"
                execute g:exeString

                let g:exeString = "normal! "

                if(getline('.')[col('.')] != ' ')
                    let g:exeString = g:exeString."E"
                endif
                let g:exeString = g:exeString."a\t"
                execute "normal! A tab "
                execute g:exeString
                "echom "Line is ".j." exeString is ".g:exeString
            endfor

        endfor
    endif
endfunction 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =============Scratch area=============
"
"NOTE: for XXX system, needed to do the following to make;make install vim:
"
" sudo yum install ncurses-devel
" sudo yum install libselinux-devel
"
" Sort lines by length - stack overflow 11531073
" usage-  :'<,'>call SortLines()
function! SortLines() range
    execute a:firstline . "," . a:lastline . 's/^\(.*\)$/\=strdisplaywidth( submatch(0) ) . " " . submatch(0)/'
    execute a:firstline . "," . a:lastline . 'sort n'
    execute a:firstline . "," . a:lastline . 's/^\d\+\s//'
endfunction

"Create check it command for now, calls the actual function
command! CheckIt :call CheckItFunction()

"Function will look in the current file for the regex, populate the quickfix list
"Caveats: searches the SAVED VERSION of the file
"
" will only open quickfix window if there are matches in the file
" Close the quickfix window with :cclose or :q while focused
function! CheckItFunction()
    "The regex we are going to match to. Try to read from file ~/regex.txt if possible
    if filereadable(expand("~/regex.txt"))
        tabe 
        execute ":r ~/regex.txt"
        execute "normal! d$"
        execute ":q!"
        let g:regexString = @"
    else
        let g:regexString = '\v(wq|^i|i$)'
    endif

    try
        execute ":silent vimgrep ".'"'.g:regexString.'" '.expand('%')
        execute ":echom ".'"'.g:regexString.'!!"'
    catch
    endtry
    cwindow
endfunction
"who

"syntax match possibleError "\w\+"
"highlight link possibleError Todo

"caps-ify last inserted selection
nnoremap <leader>u `[v`]~

"Let's do this line number thing! (??)
vnoremap <C-a> :call Incr()<CR>

function! Incr()
  let a = line('.') - line("'<")
  let c = virtcol("'<")
  if a > 0
    execute 'normal! '.c.'|'.a."\<C-a>"
  endif
  normal `<
endfunction

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

"Function that prints number of spaces
nmap <silent> <F4> :set opfunc=CountSpaces<CR>g@
vmap <silent> <F4> :<C-U>call CountSpaces(visualmode(), 1)<CR>

function! CountSpaces(type, ...)
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@

    if a:0  " Invoked from Visual mode, use '< and '> marks.
        silent exe "normal! `<" . a:type . "`>y"
    elseif a:type == 'line'
        silent exe "normal! '[V']y"
    elseif a:type == 'block'
        silent exe "normal! `[\<C-V>`]y"
    else
        silent exe "normal! `[v`]y"
    endif

    echomsg strlen(substitute(@@, '[^ ]', '', 'g'))

    let &selection = sel_save
    let @@ = reg_save
endfunction

"nerdtree thingies
"close if the only window left open is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"The command to toggle NERDTree
"noremap <C-n> :NERDTreeToggle<Cr>

"Quick hack for vhdl stuff
iabbrev slv std_logic_vector
iabbrev SLV std_logic_vector
iabbrev sll std_logic
iabbrev SLL std_logic

"Function to turn port to port map in vhdl ???
"'<,'>s/\v^\s+(\w+).*/\1 => \1/gc

"quick create processes
"iabbrev procc 
"            \<Cr>process(clk) is 
"            \<cr>begin
"            \<cr>  if rising_edge(clk) then
"            \<cr>      a <= b;
"            \<cr>  end if;
"            \<cr>end process; kj==kkkH
"
" 'others' typing
"iabbrev othh 
"            \(others => '0')

"nnoremap o :call NumberToggle()<Cr>
"
"function NumberToggle()
"    if(&relativenumber == 0 && &number == 1)
"        echom "toggle off"
"        set nonumber
"        set norelativenumber
"    elseif(&relativenumber == 0 && &number == 0)
"        echom "Set relnumber"
"        set relativenumber
"        set nonumber
"    else
"        echom "Set number"
"        set number
"        set norelativenumber
"    endif
"endfunc
"
"
" Quickly toggle comments in block
vnoremap <leader>c :s/\v^\-\-/££/<Cr>:'<,'>g!/^££/normal I--<Cr>:'<,'>s/^££/  /<Cr>

vnoremap - 0
nnoremap - 0

" quick reg copy
nnoremap <leader>1 yypwea_r<Esc>ldldl

" Quick vhdl port map to entity swap
" '<,'>s/\v(\w+)\s+:.*/\1 => \1,/gc
command! -bar -range Ent :'<,'>s/\v(\w+)\s+:.*/\1 => \1,/gc


vnoremap <leader>x :call DoThing()<CR>

function! DoThing() 
    let line=getline('.')
    try
        if line !~ "^ *--"
            let list = split(line)
            let firstword = list[1]

            redir => subscount
                execute "silent %s/\\<".firstword."\\>//gne"
            redir END
            let matches=matchstr(subscount, '\d\+')
            if str2nr(matches) <= 1
                 execute "normal! A --Unused signal! TODO: (`HUT`) : delete"
             "else
             "    execute "normal! A --Not unique"
            endif
        endif
    catch
    endtry
endfunction

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
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

"nnoremap <leader>z :%g/0000000/d<cr>:%s/.*: 0000//<cr>
"nnoremap <leader>a :%s/.*: 0000//<cr>:nunmap J<cr>:%g/./normal J<Cr>:%g!/ 0001/d<Cr>:%s/ 0001//<cr>

" TODO: (`HUT`) : change J and K to actually move by block
" Behaviour wanted: move to last non-whitespace or empty line, unless on 
" Bonus: consider being comment-aware?
" think about visual mode
"
"TODO: (`HUT`) : don't add gg to jumpspace
"
"TODO: (`HUT`) : make cleanfile better (don't remove tabs indent on files that is required on)
"

" TODO: (`HUT`) : change J and K to actually move by block
"

"noremap J :call TestMe()<Cr>
"nnoremap K :echom "CAPS LOCK?"<cr>{kzz " just did this -delete

" TODO: (`HUT`) : rename this
"vnoremap J :<C-u>call MoveMeBlock('visual', 'forward')<CR>
"nnoremap J :call MoveMeBlock('normal', 'forward')<CR>
"vnoremap K :<C-u>call MoveMeBlock('visual', 'backward')<CR>
"nnoremap K :call MoveMeBlock('normal', 'backward')<CR>

function! MoveMeBlock(mode, direction)

    " Determine the line we want to move to
    let line_to_move = line('.')
    let lines_in_file = line('$')

    " Let's not wrap our searches
    if (line_to_move == lines_in_file) && a:direction == 'forward'
        echom "Can't progress forward"
        return
    endif

    if (line_to_move == 0) && a:direction == 'backward'
        echom "Can't progress backward"
        return
    endif

    let line_to_move = GetLineToMoveTo(a:direction)

    let b:last_x_jump=0
    let b:last_y_jump=0

    " We want to try to keep our cursor in the same column when we do a series of jumps
    let b:current_x_coord=line('.')
    let b:current_y_coord=col('.')

    " Check to see if we just jumped to this location
    if exists("b:last_x_coord")
        "echom "exists"
        "echom "Current x and y is ".b:current_x_coord." and ".b:current_y_coord
        "echom "prev x and y is ".b:last_x_coord." and ".b:last_y_coord

        if b:current_x_coord == b:last_x_coord && b:current_y_coord == b:last_y_coord
            echom "Jumping from same point"
        endif
    endif

    " In visual mode we want to re-select our selection (lost when doing function call)
    let b:prepend_command = ''
    if a:mode == 'visual'
        call feedkeys("gv".line_to_move."G"."6|")
        "call cursor(line_to_move, 0)

        "echom "in visual mode"
        ""let b:prepend_command = 'gv'
        "execute "normal gv".line_to_move."G"
    else
        "execute "normal ".line_to_move."G"
        call cursor(line_to_move, 0)
    endif

    "call cursor(line_to_move, 0)

    return
    "let @
    "call feedkeys("18gg")
    call MoveToLine(b:prepend_command)
    "call feedkeys("gv18gg")
    "execute "normal! 19gg"
endfunction

" Note: I think we want to find the end of the next block if we are at the end of a block

function! GetLineToMoveTo(direction)

    " TODO: (`HUT`) : fix this, probably
    let line_to_move = line('.')
    let lines_in_file = line('$')

    if a:direction == 'backward'
        let increment = -1
    endif

    if a:direction == 'forward'
        let increment = 1
    endif

    " If our current line is empty, or our adjacent line is empty? If so find NEXT non-empty line to jump to
    if getline('.') =~ '^$' || getline('.') =~ '^\(\s\)\+$' || getline(line_to_move+increment) =~ '^$' || getline(line_to_move+increment) =~ '^\(\s\)\+$'
        let line_to_move += increment
        while 1 == 1
            if getline(line_to_move) !~ '^$' && getline(line_to_move) !~ '^\(\s\)\+$'
                break
            endif

            if line_to_move == 0 || line_to_move == lines_in_file
                break
            endif
            let line_to_move+= increment
        endwhile
    else " else find LAST non_empty line (in block)
        let line_to_move+=increment
        while 1 == 1
            if line_to_move == 0 || line_to_move == lines_in_file
                break
            endif

            if (getline(line_to_move+increment) =~ '^$' || getline(line_to_move+increment) =~ '^\(\s\)\+$')
                break
            endif

            let line_to_move+= increment
        endwhile
    endif

    return line_to_move

endfunction

      "if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    "if LineIsEmpty()

function! MoveToLine(prepend_command)
    call feedkeys(a:prepend_command."20gg")
endfunction

" This callback will be executed when the entire command is completed
function! BackgroundCommandClose(channel)
  " Read the output from the command into the quickfix window
  execute "cfile! " . g:backgroundCommandOutput
  " Only if there is anything in the output
  if len(getqflist()) > 0
    " Open the quickfix window
    copen
    " Jump back to the main window
    wincmd p
  endif
  unlet g:backgroundCommandOutput
endfunction

function! RunBackgroundCommand(command)
  " Make sure we're running VIM version 8 or higher.
  if v:version < 800
    echoerr 'RunBackgroundCommand requires VIM version 8 or higher'
    return
  endif

  if exists('g:backgroundCommandOutput')
    echom 'Already running task in background'
    sleep 2
  else
    echo 'Running task in background'
    " Launch the job.
    " Notice that we're only capturing out, and not err here. This is because, for some reason, the callback
    " will not actually get hit if we write err out to the same file. Not sure if I'm doing this wrong or?
    let g:backgroundCommandOutput = tempname()

    echom(a:command)

    call job_start(a:command, {'close_cb': 'BackgroundCommandClose', 'out_io': 'file', 'out_name': g:backgroundCommandOutput})
  endif
endfunction

" So we can use :BackgroundCommand to call our function.
command! -nargs=+ -complete=shellcmd RunBackgroundCommand call RunBackgroundCommand(<q-args>)

" Function to search for phrase in project 
"nnoremap <leader>f :w<Cr>:call CloseCopen()<Cr>:RunBackgroundCommand ./vim_helper.sh 
nnoremap <leader>f :w<Cr>:call CloseCopen()<Cr>:RunBackgroundCommand ./run_build.sh<Cr>

nnoremap <leader>a :call FormatFile()<Cr>
"colorscheme desert
"

"autocmd FileType vhdl :call ConfigForVHDL()<Cr>
"
function! FormatFile()
    if &filetype ==# 'rust'
      execute ':w'
      execute "silent :!cargo fmt"
      execute ':redraw!'
      execute ':e'
    else
      echom "No file formatter defined for lang: "
    endif
endfunction

function! CloseCopen()
    let save_tab = tabpagenr()
    let save_win = winnr()
    tabdo cclose
    exe "tabnext" save_tab
    exe save_win "wincmd w" 
endfunction

nnoremap <leader>b :!git co fork/master -- <c-r>=expand("%:p")<cr><cr><cr>
cnoremap <leader>b !git co fork/master -- <c-r>=expand("%:p")<cr><cr><cr>
