" sort directories first; ignore tags file and .git directory
let g:dirvish_mode = ':sort ,^.*[\/], | :silent keeppatterns g/^tags$\|^.git\/$/d _'

" open the current working directory
nnoremap <silent> _ <cmd>Dirvish .<cr>

augroup dirvish_config
  autocmd!

  " use dirvish instead of netrw when opening a directory with vim
  autocmd VimEnter * if exists('#FileExplorer') | exe 'au! FileExplorer *' | endif
augroup END
