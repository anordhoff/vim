" vim: foldmethod=marker foldlevel=0

" TODO: confirm if git mergetool works on fedora with `gvim -v` and fugitive. Do the nnoremaps `gh` and `gl` still work?
" TODO: check if !exists($SSH_TTY) works with dev containers (docker/podman). If not, how can we update the vim config such that opt/ plugins do not load when running vim from within an SSH session or when exec'd into a docker container
" TODO: QuickScopePrimary and QuickScopeSecondary removes the highlight from Search/IncSearch for the specific character. Can the quick-scope char be set to bold/italic, while preserving Search/IncSearch ctermbg highlight?
" TODO: "E947: Job still running in buffer" error when closing vim with a terminal window. Is there a better workflow fow closeng vim when a terminal session was created?
" TODO: in tmux.conf, "bg=color16", "fg=color4", etc are highlighted to their truecolor. However, my terminal emulator does not use the color shown. Disable the inline highlighting of "colorX"
" TODO: shelcmdflag=-c allows the use of aliases when shelling out from vim's command line, but can also cause command line formatting issues. Is there a workaround that allows me to use aliases, eg :!g status?
" TODO: Can I use "set showbreak=' .. '" instead of "let &showbreak=' .. '"
" TODO: `nnoremap <leader>y :let @" = expand("%:p")<cr>` no longer works
" TODO: yanking visually selected line to the system clipboard with "+y and then pasting in insert mode with <ctrl-shift-v> adds "[27;5;106~" to the end of the pasted text
" TODO: TermStatusline() should print the command used to launch the terminal (eg python, /bin/zsh, etc), along with current status (running, finished), similar to the default terminal statusline. Perhaps term_gettitle(bufnr('%')) isn't working as expected
" TODO: vim-dirvish should hide vim swap files (*.swp)
" TODO: :Lint permanently changes the makeprg to "makeprg=golangci-lint run --show-stats=false --output.text.print-issued-lines=false" when it should reset back to the default "makeprg=make"
" TODO: why doesn't nnoremap work within ftplugin/netrw.vim? Why do I have to use nmap"
" TODO: are there are noremaps that would make more sense as maps, and vice versa (any maps that would be safer as noremaps)?

" --- settings --- {{{

set notermguicolors     " disable 24-bit colors
set t_Co=16             " use the 16 color palette
set number              " enable line numbers
set noshowmode          " hide the mode from the bottom row
set noincsearch         " do not immediately jump to first search hit
set ignorecase          " case-insensitive searching...
set smartcase           " ...but not if the search contains a capital letter
set nowrapscan          " do not wrap searches around the end of the file
set splitright          " split vertical windows to the right of current window
set splitbelow          " split horizontal windows below current window
set hidden              " allow switching between buffers without saving
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
set timeoutlen=5000     " make complicated commands more forgiving to type
set ttimeoutlen=1       " minimal delay for escape key presses
" set shellcmdflag=-ic    " interactive command mode shell (for aliases)

" enable filetype detection and loading of plugin and indent files
filetype plugin indent on

" enable syntax highlighting
syntax enable

" set the cursor shape to a bar in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" enable meta keymaps with modifyOtherKeys level 2
let &t_TI = "\<Esc>[>4;2m"
let &t_TE = "\<Esc>[>4;m"

" show search count; don't give ins-complete-menu messages or file info
set shortmess-=S
set shortmess+=cF

" load internal packages
if &loadplugins
  packadd cfilter
  packadd netrw
endif

" use two spaces instead of tabs by default
set tabstop=2
set shiftwidth=2
set expandtab

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
set wildignore+=tags,*.tags,.git/**,**/bin/**,**/vendor/**,**/node_modules/**,**/pack/download/opt/**,**/pack/download/start/**,**/tmux/plugins/**

" ignore files and directories listed in .gitignore
let &wildignore ..= gitignore#WildignoreList('.gitignore')

" make line wrapping look nicer, but don't wrap by default
set nowrap
set linebreak
set breakindent
let &showbreak=' .. '

" add jobfiles and jobfiles/after to vim's runtimepath and packpath
set runtimepath-=~/.config/vim
set runtimepath^=~/.config/vim,~/jobfiles/vim
set runtimepath+=~/jobfiles/vim/after
set packpath-=~/.config/vim
set packpath^=~/.config/vim,~/jobfiles/vim
set packpath+=~/jobfiles/vim/after

" open the quickfix and location list automatically, but don't steal focus
augroup quickfix_config
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow | wincmd p
  autocmd QuickFixCmdPost l*    lwindow | wincmd p
augroup END

" wrap text in the preview window
augroup preview_config
  autocmd!
  autocmd WinEnter * if &previewwindow | setlocal wrap | endif
augroup END

" reset completeopt option after manual completion
augroup completion_config
  autocmd!
  autocmd CompleteDone * pclose
  autocmd CompleteDone * setlocal completeopt=menuone,noselect,preview
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
  autocmd BufRead * autocmd FileType <buffer> ++once if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exec 'normal! g`"zz' | endif
augroup END

" load custom colorscheme
colorscheme colorscheme

" }}}
" --- mappings --- {{{

" leader key
let mapleader = "\<space>"

" prevent clipboard hijacking
inoremap <c-r>+ <c-r><c-r>+
inoremap <c-r>* <c-r><c-r>*

" ctrl-p and ctrl-n match the current command-line
cnoremap <c-p> <up>
cnoremap <c-n> <down>

" file and buffer navigation
nnoremap <leader>e :e **/*
nnoremap <leader>s :sp **/*
nnoremap <leader>v :vs **/*
nnoremap <leader>b :b **/*

" clear search highlighting
nnoremap <silent> <c-l> :nohlsearch<cr>

" jump to the definition in the tag file
nnoremap gd <c-]>

" maximize the current window
nnoremap <silent> <leader>z :tabnew %<cr><c-o>

" grep current buffer or all files in current directory
nnoremap gb :lvimgrep //j %<left><left><left><left>
nnoremap gp :vimgrep //j **/*<left><left><left><left><left><left><left>

" toggle the quickfix list window and maximize window to the width of vim
nnoremap <silent> <m-q> :call quickfix#ToggleQuickfixlist()<cr>

" toggle the location list window
nnoremap <silent> <m-l> :call quickfix#ToggleLocationlist()<cr>

" get change from local or remote buffer when using mergetool
nnoremap gh <cmd>set diffopt-=linematch:40<bar>diffget //2<bar>set diffopt+=linematch:40<bar>diffupdate<cr>
nnoremap gl <cmd>set diffopt-=linematch:40<bar>diffget //3<bar>set diffopt+=linematch:40<bar>diffupdate<cr>

" copy the absolute path of the current file to the unnamed register
nnoremap <leader>y :let @" = expand("%:p")<cr>

" trigger tag/omni completion using <tab>
inoremap <expr> <tab> completion#TabComplete(0)
inoremap <expr> <s-tab> completion#TabComplete(1)

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

" }}}
" --- commands --- {{{

" clear the specified register
command! -nargs=1 Clear call registers#Clear(<q-args>)

" }}}
" --- TODO: fuzzy file search and fuzzy grep --- {{{

" autocmd CmdlineChanged [:\/\?] call wildtrigger()
" set wildmode=noselect:lastused,full
" set wildoptions=pum

" :h fuzzy-file-picker
set findfunc=Find
func Find(arg, _)
  if empty(s:filescache)
    let s:filescache = globpath('.', '**', 1, 1)
    call filter(s:filescache, '!isdirectory(v:val)')
    call map(s:filescache, "fnamemodify(v:val, ':.')")
  endif
  return a:arg == '' ? s:filescache : matchfuzzy(s:filescache, a:arg)
endfunc
let s:filescache = []
autocmd CmdlineEnter : let s:filescache = []
nnoremap <leader>f :find 

command! -nargs=+ -complete=customlist,<SID>Grep
  \ Grep call <SID>VisitFile()

func s:Grep(arglead, cmdline, cursorpos)
  if match(&grepprg, '\$\*') == -1 | let &grepprg ..= ' $*' | endif
  let cmd = substitute(&grepprg, '\$\*', shellescape(escape(a:arglead, '\')), '')
  return len(a:arglead) > 1 ? systemlist(cmd) : []
endfunc

func s:VisitFile()
  let item = getqflist(#{lines: [s:selected]}).items[0]
  let pos  = '[0,\ item.lnum,\ item.col,\ 0]'
  exe $':b +call\ setpos(".",\ {pos}) {item.bufnr}'
  call setbufvar(item.bufnr, '&buflisted', 1)
endfunc

autocmd CmdlineLeavePre :
      \ if get(cmdcomplete_info(), 'matches', []) != [] |
      \   let s:info = cmdcomplete_info() |
      \   if getcmdline() =~ '^\s*fin\%[d]\s' && s:info.selected == -1 |
      \     call setcmdline($'find {s:info.matches[0]}') |
      \   endif |
      \   if getcmdline() =~ '^\s*Grep\s' |
      \     let s:selected = s:info.selected != -1
      \         ? s:info.matches[s:info.selected] : s:info.matches[0] |
      \     call setcmdline(s:info.cmdline_orig) |
      \   endif |
      \ endif

" }}}
" --- statusline --- {{{

" custom statusline (requires additional StatusLineActive and StatusLineInactive highlight groups)
set statusline=%!Statusline(g:statusline_winid)

" assemble the custom statusline for most filetypes
function Statusline(winid)
  let statusline  = ' ' .. Background(a:winid) " left padding; set status line background color
  let statusline ..= ' [%n]  '                 " buffer number
  let statusline ..= '%f  '                    " filepath
  let statusline ..= '%{NopluginFlag()}'       " noplugin flag
  let statusline ..= '%H%W%R%M'                " help/preview/read-only/modified flags
  let statusline ..= '%=   %c%V  :  %2l/%L'    " byte index, virtual column number; line number
  let statusline ..= '%{Filetype()}'           " filetype
  let statusline ..= '%* '                     " reset background color; right padding
  return statusline
endfunction

" set background depending on whether the window is active
function Background(winid)
  return a:winid == win_getid() ? '%#StatusLineActive#' : '%#StatusLineInactive#'
endfunction

" correct padding when there is no filetype
function Filetype()
  return &filetype == '' ? ' ' : '  [' .. &filetype .. '] '
endfunction

" noplugin flag if running with --noplugin set
function NopluginFlag()
  return !&loadplugins ? 'NP' : ''
endfunction

" quickfix and location list / netrw / terminal buffer status lines
augroup statusline_config
  autocmd!
  autocmd Filetype qf setlocal statusline=%!QuickfixListStatusline(g:statusline_winid)
  autocmd Filetype netrw setlocal statusline=%!NetrwStatusline(g:statusline_winid)
  autocmd TerminalOpen * setlocal statusline=%!TermStatusline(g:statusline_winid)
augroup END

function QuickfixListStatusline(winid)
  return ' ' .. Background(a:winid) .. " [%l/%L lines]  %{QuickfixTitle()}%=%q %* "
endfunction
function NetrwStatusline(winid)
  return ' ' .. Background(a:winid) .. ' [%n]  %l/%L lines%=[netrw] %* '
endfunction
function TermStatusline(winid)
  return ' ' .. Background(a:winid) .. ' [%n]  %{TermShell()}  %{NopluginFlag()}%R%=[term] %* '
endfunction

" return the title of the quickfix window
function QuickfixTitle()
  return exists('w:quickfix_title') ? w:quickfix_title .. '  ' : ''
endfunction

" return shell used by terminal
function TermShell()
  return term_gettitle(bufnr('%'))
endfunction

" }}}
" --- tabline --- {{{

set tabline=%!TabLine()

function TabLine()
  let line = '%#StatusLine#' .. ' ' .. '%#TabLine#'
  for tab in range(tabpagenr('$'))
    if tab + 1 == tabpagenr()
      let line ..= '%#TabLineSel#'
    else
      let line ..= '%#TabLine#'
    endif
    let line ..= ' %{TabLabel(' .. (tab + 1) .. ')} '
  endfor
  let line ..= '%#TabLineFill#%T' .. '%=%#StatusLine#' .. ' '
  return line
endfunction

function TabLabel(n)
  let winnr = tabpagewinnr(a:n)
  let buflist = tabpagebuflist(a:n)
  let bufname = bufname(buflist[winnr - 1])
  let filetype = getbufvar(buflist[winnr - 1], '&filetype')
  if bufname == ''
    return '[No Name]'
  elseif filetype == 'help'
    return 'help'
  elseif filetype == 'netrw'
    return 'netrw'
  elseif filetype == 'dirvish'
    return 'dirvish'
  elseif bufname =~ '^fugitive://'
    let filename = bufname
    for dir in split(getcwd(), '/')
      let filename = substitute(filename, dir .. '/', '', '')
    endfor
    let filename = substitute(filename, '/.git//', '', '')
    let filename = substitute(filename, '\d\{1}/', '', '')
    return trim(filename, '://', 2)
  else
    return bufname
  endif
endfunction

" }}}
" --- netrw --- {{{

if &loadplugins
  let g:netrw_winsize = -30  " set the absolute size of netrw windows
  let g:netrw_banner = 0     " hide the informational banner
  let g:netrw_liststyle = 3  " tree style listing
  let g:netrw_dirhistmax = 0 " suppress netrw history files

  " toggle netrw as a project drawer
  nnoremap <silent> <m--> <cmd>Lexplore<cr>
endif

" }}}
" --- notes --- {{{

" notebook directory
let g:projectsdir = '~/notebook/projects/'
let g:todofile = '~/notebook/todo.md'

" toggle the notebook
nnoremap <silent> <m-n> <cmd>call notebook#Project(g:projectsdir)<cr>
nnoremap <silent> <m-t> <cmd>call notebook#Todo(g:todofile)<cr>

" prevent notebook pages from being added to the buffer list
augroup notebook_config
  autocmd!
  autocmd BufNewFile,BufRead ~/notebook/*.txt,~/notebook/*.md setlocal nobuflisted
augroup END

" }}}
" --- terminal --- {{{

" start a server so terminal commands can open files in this vim instance
" if empty(v:servername) && has('clientserver')
"   call remote_startserver('VIM')
" endif
" if !empty(v:servername)
"   let $EDITOR = 'vimx --servername ' .. v:servername .. ' --remote-wait'
"   let $VISUAL = 'vimx --servername ' .. v:servername .. ' --remote-wait'
" endif

" open terminal in a horizontal or vertical split
nnoremap <silent> <m-s> <cmd>call term#Toggle(0)<cr>
nnoremap <silent> <m-v> <cmd>call term#Toggle(1)<cr>
nnoremap <silent> <m-w> <cmd>call term#Focus()<cr>

" toggle terminal without leaving terminal insert mode
tnoremap <silent> <m-s> <c-\><c-n><cmd>call term#Toggle(0)<cr>
tnoremap <silent> <m-v> <c-\><c-n><cmd>call term#Toggle(1)<cr>
tnoremap <silent> <m-w> <c-\><c-n><cmd>call term#Focus()<cr>

" use ctrl-r to access registers in terminal insert mode
tnoremap <expr> <c-r> '<c-\><c-n>"' .. nr2char(getchar()) .. 'pi'

" use ctrl-r ctrl-r to reverse-history search
tnoremap <c-r><c-r> <c-r>

augroup terminal_config
  autocmd!

  " prevent the terminal from being added to the buffer list
  autocmd TerminalOpen * setlocal nobuflisted fillchars=eob:\  nonumber

  " enable terminal toggling
  autocmd TerminalOpen * let g:termbuf = bufnr('%')
  autocmd TerminalOpen * let g:termwin = win_getid()
  autocmd TabNew * if getbufvar(bufnr('%'), '&buftype') == 'terminal' | let g:termwin = win_getid() | endif
augroup END

" }}}
