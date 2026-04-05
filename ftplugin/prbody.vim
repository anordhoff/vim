if exists('b:did_custom_ftplugin')
  finish
endif
let b:did_custom_ftplugin = 1

" automatically create a Github pull request when the prbody buffer is closed
autocmd WinClosed <buffer> call pr#CreateWithBody('%')
