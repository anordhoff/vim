function quickfix#Preview()
  let lnum = line('.')
  let entry = getqflist()[lnum - 1]
  execute 'aboveleft pedit +' .. get(entry, 'lnum', 1) .. ' ' .. bufname(get(entry, 'bufnr', 0))
  execute lnum
endfunction
