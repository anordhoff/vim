" fugitive keymaps
nnoremap g<space> :Git<space>
nnoremap g<cr> <cmd>Git<cr>

" use :Glog to view the revision history of the current file
command Glog :0Gllog

" use git-jump from within vim
command -bar -nargs=* GJump cexpr system('git jump --stdout ' . expand(<q-args>))
