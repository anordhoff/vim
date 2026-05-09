function tabline#Line() abort
  let tabline = '%#StatusLine#' .. ' ' .. '%#TabLine#'
  for tab in range(tabpagenr('$'))
    if tab + 1 == tabpagenr()
      let tabline ..= '%#TabLineSel#'
    else
      let tabline ..= '%#TabLine#'
    endif
    let tabline ..= '%' .. (tab + 1) .. 'T'
    let tabline ..= ' %{tabline#Label(' .. (tab + 1) .. ')} '
  endfor
  let tabline ..= '%#TabLineFill#%T' .. '%=%#StatusLine#' .. ' '
  return tabline
endfunction

function tabline#Label(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let bufname = bufname(buflist[winnr - 1])
  let filetype = getbufvar(buflist[winnr - 1], '&filetype')

  " modified label
  let modified = ' '
  for bufnr in buflist
    if getbufvar(bufnr, '&modified')
      let modified = '+'
      break
    endif
  endfor

  " window count
  let wincount = tabpagewinnr(a:n, '$') > 1 ? tabpagewinnr(a:n, '$') .. ':' : ''

  " handle special buffer types
  let name = ''
  if bufname == ''
    let name = '[No Name]'
  elseif filetype == 'help'
    let name = 'help'
  elseif filetype == 'dirvish'
    let name = 'dirvish'
  elseif bufname =~ '^fugitive://'
    let name = 'fugitive://' .. fnamemodify(FugitiveReal(bufname), ':~:.')
  else
    let name = fnamemodify(bufname, ':~:.')
  endif
  return wincount .. name .. modified
endfunction

function tabline#Panel() abort
  let curr = g:actual_curtabpage
  let buflist = tabpagebuflist(curr)
  let winnr = tabpagewinnr(curr)
  let bufname = bufname(buflist[winnr - 1])
  let prefix = printf('%2d ', curr)

  if bufname =~ '^fugitive://'
    let name = fnamemodify(FugitiveReal(bufname), ':~:.')
  else
    let name = fnamemodify(bufname, ':~:.')
  endif

  " get the width of the tab panel (excluding the vertical separator)
  let width = str2nr(matchstr(&tabpanelopt, 'columns:\zs\d\+')) - 1

  " if necessary, shorten directory names in the path
  let len = 10
  while strchars(prefix .. name) > width && len > 0
    let name = pathshorten(name, len)
    let len -= 1
  endwhile

  " if necessary, trim the beginning of the filename
  if strchars(prefix .. name) >= width
    let len = width - strchars(prefix) - 1
    let name = '<' .. strcharpart(name, strchars(name) - len)
  endif
  return '%#LineNr#' .. prefix .. '%*' .. name
endfunction
