" sort directories first; ignore tags file and .git directory
let g:dirvish_mode = ':sort ,^.*[\/], | :silent keeppatterns g/^tags$\|^.git\/$/d _'
let g:dirvish_mode = ':sort ,^.*[\/], | :silent keeppatterns g/^tags$\|\.swp$\|^.git\//d _'

" open the current working directory
nnoremap <silent> _ <cmd>Dirvish .<cr>

" override netrw commands
command -nargs=? -complete=dir Explore Dirvish <args>
command -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
command -nargs=? -complete=dir Lexplore leftabove 30vsplit | silent Dirvish <args>
