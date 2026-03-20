" fuzzy-file-picker
function fuzzy#Find(arg, _)
  if empty(g:filescache)
    if isdirectory('.git')
      let g:filescache = systemlist('git ls-files')
      for pat in split(&wildignore, ',')
        call filter(g:filescache, {_, f -> ('/' .. f) !~# glob2regpat(pat)})
      endfor
    else
      let g:filescache = globpath('.', '**', 0, 1)
      call filter(g:filescache, '!isdirectory(v:val)')
      call map(g:filescache, "fnamemodify(v:val, ':.')")
    endif
  endif
  return a:arg == '' ? g:filescache : matchfuzzy(g:filescache, a:arg)
endfunction


" fuzzy buffer picker
function fuzzy#Buffers(arglead, cmdline, cursorpos)
  let bufs = getbufinfo(#{buflisted: 1})
  let names = map(bufs, {_, b -> empty(b.name) ? $'[{b.bufnr}]' : fnamemodify(b.name, ':~:.')})
  return a:arglead == '' ? names : matchfuzzy(names, a:arglead)
endfunction

" switch to a buffer by its display name
function fuzzy#SwitchBuffer(name)
  for buf in getbufinfo(#{buflisted: 1})
    let display = empty(buf.name) ? $'[{buf.bufnr}]' : fnamemodify(buf.name, ':~:.')
    if display ==# a:name
      execute $'buffer {buf.bufnr}'
      return
    endif
  endfor
  execute $'buffer {a:name}'
endfunction


" live-grep
function fuzzy#LiveGrep(arglead, cmdline, cursorpos)
  if match(&grepprg, '\$\*') == -1 | let &grepprg ..= ' $*' | endif
  let cmd = substitute(&grepprg, '\$\*', shellescape(escape(a:arglead, '\')), '')
  return len(a:arglead) > 1 ? systemlist(cmd) : []
endfunction

function fuzzy#VisitFile()
  let item = getqflist(#{lines: [g:fuzzy_selected]}).items[0]
  let pos  = '[0,\ item.lnum,\ item.col,\ 0]'
  exe $':b +call\ setpos(".",\ {pos}) {item.bufnr}'
  call setbufvar(item.bufnr, '&buflisted', 1)
endfunction


" enable fuzzy wildmode when using :find, :sfind, :vert sfind, :Buffer, or :LiveGrep
function fuzzy#CmdlineChanged()
  let cmd = getcmdline()
  if cmd =~# '^\s*\%(vert \)\?s\?fin\%[d]\s' || cmd =~# '^\s*Buffer\s' || cmd =~# '^\s*LiveGrep\s'
    set wildmode=noselect:lastused,full
    call wildtrigger()
  endif
endfunction

" handle <enter> keypress when using :find, :sfind, :vert sfind, :Buffer, or :LiveGrep
function fuzzy#CmdlineLeavePre()
  if get(cmdcomplete_info(), 'matches', []) != []
    let info = cmdcomplete_info()
    if getcmdline() =~# '^\s*fin\%[d]\s' && info.selected == -1
      call setcmdline($'find {info.matches[0]}')
    endif
    if getcmdline() =~# '^\s*sfin\%[d]\s' && info.selected == -1
      call setcmdline($'sfind {info.matches[0]}')
    endif
    if getcmdline() =~# '^\s*vert sfin\%[d]\s' && info.selected == -1
      call setcmdline($'vert sfind {info.matches[0]}')
    endif
    if getcmdline() =~# '^\s*Buffer\s' && info.selected == -1
      call setcmdline($'Buffer {info.matches[0]}')
    endif
    if getcmdline() =~# '^\s*LiveGrep\s'
      let g:fuzzy_selected = info.selected != -1
          \ ? info.matches[info.selected] : info.matches[0]
      call setcmdline(info.cmdline_orig)
    endif
  endif
endfunction
