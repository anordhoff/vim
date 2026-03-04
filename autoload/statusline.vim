" set background depending on whether the window is active
function statusline#Background(winid)
  return a:winid == win_getid() ? '%#StatusLineActive#' : '%#StatusLineInactive#'
endfunction

" hide buffer number if buffer sets nobuflisted
function statusline#BufferNr()
  return &buflisted ? ' [' .. bufnr('%') .. '] ' : ''
endfunction

" noplugin flag if running with --noplugin set
function statusline#NopluginFlag()
  return !&loadplugins ? 'NP' : ''
endfunction

" correct padding when there is no filetype
function statusline#Filetype()
  return &filetype != '' ? ' [' .. &filetype .. '] ' : ''
endfunction

" quickfix and location list statusline
function statusline#QuickfixList(winid)
  return ' ' .. statusline#Background(a:winid) .. " [%l/%L lines]  %{exists('w:quickfix_title') ? w:quickfix_title .. '  ' : '  ' }%= %q %* "
endfunction

" dirvish statusline
function statusline#Dirvish(winid)
  let filename = fnamemodify(bufname('%'), ':~')
  if winwidth(a:winid) > 30
    return ' ' .. statusline#Background(a:winid) .. ' ' .. l:filename .. "%= %{statusline#Filetype()}%* "
  else
    return ' ' .. statusline#Background(a:winid) .. ' ' .. l:filename .. "%= %* "
  endif
endfunction

" terminal statusline
function statusline#Term(winid)
  return ' ' .. statusline#Background(a:winid) .. ' %f  %{statusline#NopluginFlag()}%= [term] %* '
endfunction
