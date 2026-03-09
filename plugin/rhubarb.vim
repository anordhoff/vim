let s:clipboard = has('mac') ? 'pbcopy' : 'xclip -selection clipboard'

" commands follow the vim-fugitive naming convention
command -nargs=* GCreate      call rhubarb#GhPrCreate(<q-args>)
command -nargs=* GCreateDraft call rhubarb#GhPrCreateDraft(<q-args>)
command          GCreateWeb   call rhubarb#GhPrCreateWeb()

" automatically create a Github pull request when the prbody buffer is closed
augroup rhubarb_config
  autocmd!
  autocmd WinClosed * if &ft == "prbody" | call rhubarb#GhPrCreateWithBody('%') | endif
augroup END
