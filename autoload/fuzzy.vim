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


" live-grep
function fuzzy#Grep(arglead, cmdline, cursorpos)
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


" handle <enter> keypress when using :find or :Grep
function fuzzy#CmdlineLeavePre()
  if get(cmdcomplete_info(), 'matches', []) != []
    let info = cmdcomplete_info()
    if getcmdline() =~# '^\s*fin\%[d]\s' && info.selected == -1
      call setcmdline($'find {info.matches[0]}')
    endif
    if getcmdline() =~# '^\s*Grep\s'
      let g:fuzzy_selected = info.selected != -1
          \ ? info.matches[info.selected] : info.matches[0]
      call setcmdline(info.cmdline_orig)
    endif
  endif
endfunction
