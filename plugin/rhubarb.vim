" commands follow the vim-fugitive naming convention
command -nargs=* GCreate      call pr#Create(<q-args>)
command -nargs=* GCreateDraft call pr#CreateDraft(<q-args>)
command          GCreateWeb   call pr#CreateWeb()

" automatically create a Github pull request when the prbody buffer is closed
augroup rhubarb_config
  autocmd!
  autocmd WinClosed * if &ft == "prbody" | call pr#CreateWithBody('%') | endif
augroup END
