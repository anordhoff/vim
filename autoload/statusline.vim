function statusline#Line(winid) abort
  let statusline   = ' '                            " left padding
  let statusline ..= statusline#Background(a:winid) " set status line background color
  let statusline ..= '%{%statusline#BufferNr()%} '  " buffer number
  let statusline ..= '%{statusline#Filename()}  '   " filepath
  let statusline ..= '%{statusline#NopluginFlag()}' " noplugin flag
  let statusline ..= '%H%W%R%M'                     " help,preview,read-only, and modified flags
  let statusline ..= '%= '                          " right align
  let statusline ..= '%7(%c%V%)'                    " byte index, virtual column number
  let statusline ..= '  :  '                        " separator and padding
  let statusline ..= '%2l/%L '                      " current line number/total line count
  let statusline ..= '%{%statusline#Filetype()%}'   " filetype
  let statusline ..= '%* '                          " reset background color; right padding
  return statusline
endfunction

" set background depending on whether the window is active
function statusline#Background(winid)
  return a:winid == win_getid() ? '%#StatusLineActive#' : '%#StatusLineInactive#'
endfunction

function statusline#Filename()
  return fnamemodify(bufname('%'), ':~:.')
endfunction

" hide buffer number if buffer sets nobuflisted
function statusline#BufferNr()
  return &buflisted ? ' [%n] ' : ''
endfunction

" noplugin flag if running with --noplugin set
function statusline#NopluginFlag()
  return !&loadplugins ? 'NP' : ''
endfunction

" correct padding when there is no filetype
function statusline#Filetype()
  return &filetype != '' ? ' %y ' : ''
endfunction

" quickfix and location list statusline
function statusline#QuickfixList(winid)
  return ' ' .. statusline#Background(a:winid) .. " [%l/%L lines]  %{exists('w:quickfix_title') ? w:quickfix_title .. '  ' : '  ' }%= %q %* "
endfunction

" dirvish statusline
function statusline#Dirvish(winid)
  let filename = fnamemodify(bufname('%'), ':~')
  if winwidth(a:winid) > 40
    return ' ' .. statusline#Background(a:winid) .. ' ' .. filename .. "%= %{%statusline#Filetype()%}%* "
  else
    return ' ' .. statusline#Background(a:winid) .. ' ' .. filename .. "%= %* "
  endif
endfunction

" terminal statusline
function statusline#Term(winid)
  return ' ' .. statusline#Background(a:winid) .. ' %f  %{statusline#NopluginFlag()}%= [term] %* '
endfunction
