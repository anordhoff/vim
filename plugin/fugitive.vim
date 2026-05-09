" fugitive keymaps
nnoremap g<space> :Git<space>
nnoremap g<cr> <cmd>Git<cr>

" use git-jump from within vim
command -bar -nargs=* GJump cexpr system('git jump --stdout ' .. expand(<q-args>))
