function quickfix#ToggleQuickfixlist()
  if getqflist({'winid': 0}).winid
    let g:quickfix_height = winheight(getqflist({'winid' : 1}).winid)
    cclose
  else
    if exists('g:quickfix_height')
      execute 'botright copen ' .. g:quickfix_height
    else
      botright copen
    endif
    wincmd p
  endif
endfunction

function quickfix#ToggleLocationlist()
  try
    if getloclist(0, {'winid': 0}).winid
      let height = winheight(getloclist(0, {'winid' : 1}).winid)
      lclose
      let b:locationlist_height = height
    else
      if exists('b:locationlist_height')
        execute 'lopen ' .. b:locationlist_height
      else
        lopen
      endif
      wincmd p
    endif
  catch 'E776'
    echohl ErrorMsg | echo 'E776: No location list' | echohl None
  endtry
endfunction
