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

" enable fuzzy wildmode when using :find, :sfind, and :vert sfind
function fuzzy#CmdlineChanged()
  let cmd = getcmdline()
  if cmd =~# '^\s*\%(vert \)\?s\?fin\%[d]\s'
    if &wildmode != 'noselect:lastused,full'
      set wildmode=noselect:lastused,full
    endif
    call wildtrigger()
  endif
endfunction

" handle <enter> keypress when using :find, :sfind, or :vert sfind
function fuzzy#CmdlineLeavePre()
  if get(cmdcomplete_info(), 'matches', []) != []
    let info = cmdcomplete_info()
    if getcmdline() =~# '^\s*fin\%[d]\s' && info.selected == -1
      call setcmdline('find ' .. info.matches[0])
    elseif getcmdline() =~# '^\s*sfin\%[d]\s' && info.selected == -1
      call setcmdline('sfind ' .. info.matches[0])
    elseif getcmdline() =~# '^\s*vert sfin\%[d]\s' && info.selected == -1
      call setcmdline('vert sfind ' .. info.matches[0])
    endif
  endif
endfunction
