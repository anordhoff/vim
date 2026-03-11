" --------------------------------------
" settings
" --------------------------------------

set notermguicolors     " disable 24-bit colors
set t_Co=16             " use the 16 color palette
set number              " enable line numbers
set noincsearch         " do not immediately jump to first search hit
set ignorecase          " case-insensitive searching...
set smartcase           " ...but not if the search contains a capital letter
set splitright          " split vertical windows to the right of current window
set splitbelow          " split horizontal windows below current window
set hidden              " allow switching between buffers without saving
set autoread            " automatically read file changes
set noshowmode          " hide the mode from the bottom row
set laststatus=2        " always show a statusline
set textwidth=120       " wrap lines at 120 characters
set formatoptions=jwcql " don't auto-wrap text; format comments with gq
set scrolloff=2         " keep a minimum of 2 lines above and below the cursor
set sidescrolloff=8     " keep a minimum of 8 columns before & after the cursor
set smoothscroll        " scrolling works with screen lines
set foldmethod=syntax   " fold based on syntax highlighting items
set foldlevelstart=99   " don't automatically close folds
set mouse=a             " enable the use of the mouse (for scrolling)
set mmp=10000           " prevent memory errors when loading large buffers
set ttimeoutlen=10      " minimal delay for escape key presses

" the presence of $TMUX implies we are running on a workstation
let g:is_workstation = exists('$TMUX')

" check if we are running within a dev container
let g:is_container = exists('$container')

" add jobfiles and jobfiles/after to vim's runtimepath and packpath
set runtimepath-=~/.config/vim
set runtimepath^=~/.config/vim,~/jobfiles/vim
set runtimepath+=~/jobfiles/vim/after
set packpath-=~/.config/vim
set packpath^=~/.config/vim,~/jobfiles/vim
set packpath+=~/jobfiles/vim/after

" load internal plugins
if &loadplugins
  packadd cfilter
endif

" disable netrw in favor of vim-dirvish
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" enable filetype detection and loading of plugin and indent files
filetype plugin indent on

" enable syntax highlighting
syntax enable

" load custom colorscheme
colorscheme mycolorscheme

" set the cursor shape to a bar in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" enable meta keymaps with modifyOtherKeys level 2
let &t_TI = "\e[>4;2m"
let &t_TE = "\e[>4;m"

" enable focus-event tracking
let &t_fe = "\e[?1004h"
let &t_fd = "\e[?1004l"

" enable undercurl support with cterm
let &t_Ce = "\e[4:0m"
let &t_Cs = "\e[4:3m"

" enable undercurl highlighting with ctermul
let &t_AU = "\e[58;5;%dm"

" show search count; don't print ins-complete-menu messages or file info
set shortmess-=S
set shortmess+=cF

" use two spaces instead of tabs by default
set tabstop=2
set shiftwidth=2
set expandtab

" make line wrapping look nicer, but don't wrap by default
set nowrap
set linebreak
set breakindent
let &showbreak=' .. '

" improve readability of diffs
set diffopt+=vertical,hiddenoff,algorithm:histogram,indent-heuristic

" show possible completions in a pmenu
set completeopt=menuone,noselect,preview
set pumheight=10

" use a wildmenu for command line completion
set wildoptions=pum,tagfile
set wildmode=longest:full,full
set wildignorecase

" list of file patterns to ignore
set wildignore+=tags,*.tags,.git/**,**/bin/**,**/vendor/**,**/node_modules/**,**/pack/*/opt/**,**/pack/*/start/**,**/tmux/plugins/**

" ignore files and directories listed in .gitignore
let &wildignore ..= gitignore#WildignoreList('.gitignore')

" use the fuzzy-file-picker function
if v:version >= 902
  set findfunc=fuzzy#Find
endif

" use ripgrep as the external grep program
let &grepprg = 'rg --vimgrep'
    \ .. " -g='!tags' -g='!*.tags'"
    \ .. " -g='!.git/**'"
    \ .. " -g='!**/bin/**'"
    \ .. " -g='!**/vendor/**'"
    \ .. " -g='!**/node_modules/**'"
    \ .. " -g='!**/pack/*/opt/**'"
    \ .. " -g='!**/pack/*/start/**'"
    \ .. " -g='!**/tmux/plugins/**'"
set grepformat=%f:%l:%c:%m


" --------------------------------------
" augroups
" --------------------------------------

" wrap text in the preview window
augroup preview_config
  autocmd!
  autocmd WinEnter * if &previewwindow | setlocal wrap | endif
augroup END

" reset completeopt option after manual completion
augroup completion_config
  autocmd!
  autocmd CompleteDone * pclose | setlocal completeopt=menuone,noselect,preview
augroup END

" enable the cursorline on the active window
augroup cursorline_config
  autocmd!
  autocmd BufEnter,WinEnter * setlocal cursorline
  autocmd BufLeave,WinLeave * setlocal nocursorline
augroup END

" restore cursor to previous location when opening a file
augroup cursor_config
  autocmd!
  autocmd BufRead * autocmd FileType <buffer> ++once call misc#RestoreCursor()
augroup END

" enable fuzzy autocompletion when using :find or :Grep
if v:version >= 902
  augroup fuzzy_config
    autocmd!
    autocmd CmdlineEnter [\:] let g:filescache = []
    autocmd CmdlineLeave [\:] set wildmode=longest:full,full
    autocmd CmdlineLeavePre [\:] call fuzzy#CmdlineLeavePre()
    autocmd CmdlineChanged [\:] let s:cmd = getcmdline() | if s:cmd =~# '^\s*fin\%[d]\s' || s:cmd =~# '^\s*Grep\s' | set wildmode=noselect:lastused,full | call wildtrigger() | endif
  augroup END
endif


" --------------------------------------
" mappings
" --------------------------------------

" leader key
let mapleader = "\<space>"

" prevent clipboard hijacking
inoremap <c-r>+ <c-r><c-r>+
inoremap <c-r>* <c-r><c-r>*

" ctrl-p and ctrl-n match the current command-line
cnoremap <c-p> <up>
cnoremap <c-n> <down>

" preserve history navigation when cmdline-autocompletion menu is open
cnoremap <expr> <up>   wildmenumode() ? "\<c-e>\<up>"   : "\<up>"
cnoremap <expr> <down> wildmenumode() ? "\<c-e>\<down>" : "\<down>"
cnoremap <expr> <c-p>  wildmenumode() ? "\<c-e>\<up>"   : "\<up>"
cnoremap <expr> <c-n>  wildmenumode() ? "\<c-e>\<down>" : "\<down>"

" file and buffer navigation
nnoremap <leader>e :e **/*
nnoremap <leader>s :sp **/*
nnoremap <leader>v :vs **/*
nnoremap <leader>b :b **/*
nnoremap <leader>f :find<space>

" grep the current buffer or all files in the current directory
nnoremap <leader>l :lvimgrep //j % \| lopen \| wincmd p<c-\>e[setcmdpos(11), getcmdline()][1]<cr>
nnoremap <leader>g :vimgrep //j **/* \| copen \| wincmd p<c-\>e[setcmdpos(10), getcmdline()][1]<cr>

" live-grep (ripgrep)
nnoremap <leader>r :Grep<space>

" clear search highlighting
nnoremap <silent> <c-l> :nohlsearch<cr>

" jump to the definition in the tag file
nnoremap gd <c-]>

" trigger tag/omni completion using <tab>
inoremap <expr> <tab> completion#TabComplete(0)
inoremap <expr> <s-tab> completion#TabComplete(1)

" maximize the current window
nnoremap <silent> <leader>z :tabnew %<cr><c-o>

" toggle the quickfix list window and maximize window to the width of vim
nnoremap <silent> <m-q> :call quickfix#ToggleQuickfixlist()<cr>

" toggle the location list window
nnoremap <silent> <m-l> :call quickfix#ToggleLocationlist()<cr>

" get change from local or remote buffer when using mergetool
nnoremap gh <cmd>set diffopt-=linematch:40<bar>diffget //2<bar>set diffopt+=linematch:40<bar>diffupdate<cr>
nnoremap gl <cmd>set diffopt-=linematch:40<bar>diffget //3<bar>set diffopt+=linematch:40<bar>diffupdate<cr>

" copy the absolute path of the current file to the unnamed register
nnoremap <leader>y :let @" = expand("%:p")<cr>

" scrolling with the mouse or trackpad moves the screen instead of the cursor
noremap <scrollwheelup> <c-y>
noremap <scrollwheeldown> <c-e>
noremap <scrollwheelleft> <nop>
noremap <scrollwheelright> <nop>

" disable other mouse actions
noremap <leftmouse> <nop>
noremap <rightmouse> <nop>
noremap <middlemouse> <nop>
noremap <2-leftmouse> <nop>
noremap <3-leftmouse> <nop>
noremap <4-leftmouse> <nop>
inoremap <leftmouse> <nop>
inoremap <rightmouse> <nop>
inoremap <middlemouse> <nop>


" --------------------------------------
" commands
" --------------------------------------

" live-grep
if v:version >= 902
  command -nargs=+ -complete=customlist,fuzzy#Grep Grep call fuzzy#VisitFile()
endif

" clear the specified register
command -nargs=1 Clear call misc#Clear(<q-args>)

" get the name of the highlight group under the cursor
command Inspect echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')


" --------------------------------------
" statusline / tabline
" --------------------------------------

set statusline=%!statusline#Line(g:statusline_winid)

" quickfix, location list, dirvish, and terminal buffer status lines
augroup statusline_config
  autocmd!
  autocmd Filetype qf setlocal statusline=%!statusline#QuickfixList(g:statusline_winid)
  autocmd Filetype dirvish setlocal statusline=%!statusline#Dirvish(g:statusline_winid)
  autocmd TerminalOpen * setlocal statusline=%!statusline#Term(g:statusline_winid)
augroup END

set tabline=%!tabline#Line()


" --------------------------------------
" notes
" --------------------------------------

" notebook directory
let g:projectsdir = '~/notebook/projects/'
let g:todofile = '~/notebook/todo.md'

" toggle the notebook
nnoremap <silent> <m-n> <cmd>call notebook#Project(g:projectsdir)<cr>
nnoremap <silent> <m-t> <cmd>call notebook#Todo(g:todofile)<cr>

" prevent notebook pages from being added to the buffer list
augroup notebook_config
  autocmd!
  autocmd BufNewFile,BufRead ~/notebook/**/*.txt,~/notebook/**/*.md setlocal nobuflisted
augroup END


" --------------------------------------
" terminal
" --------------------------------------

" use ctrl-o as the special key in terminal windows
set termwinkey=<c-o>

" toggle the terminal window
nnoremap <silent> <m-s> <cmd>call term#Toggle(0)<cr>
nnoremap <silent> <m-v> <cmd>call term#Toggle(1)<cr>
tnoremap <silent> <m-s> <cmd>call term#Toggle(0)<cr>
tnoremap <silent> <m-v> <cmd>call term#Toggle(1)<cr>

augroup terminal_config
  autocmd!

  " prevent the terminal from being added to the buffer list
  autocmd TerminalOpen * setlocal nobuflisted fillchars=eob:\  nonumber

  " enable terminal toggling
  autocmd TerminalOpen * let g:termbuf = bufnr('%') | let g:termwin = win_getid()
  autocmd TabNew * if getbufvar(bufnr('%'), '&buftype') == 'terminal' | let g:termwin = win_getid() | endif
augroup END

" }}}
