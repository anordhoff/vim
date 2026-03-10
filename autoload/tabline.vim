function tabline#Line()
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
    let name = 'fugitive://' .. fnamemodify(FugitiveReal(bufname), ':.')
  else
    let name = l:bufname
  endif
  return wincount .. name .. modified
endfunction
