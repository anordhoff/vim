" change the completeopt option when manually triggering completion
function! completion#TabComplete(shift)
  setlocal completeopt=menu,noselect,longest,preview
  if pumvisible()
    return a:shift ? "\<c-p>" : "\<c-n>"
  elseif getline('.')[col('.') - 2] !~ '^\s\?$'
    return &omnifunc == "" ? "\<c-x>\<c-]>" : "\<c-x>\<c-o>"
  else
    return a:shift ? "\<s-tab>" : "\<tab>"
  endif
endfunction
