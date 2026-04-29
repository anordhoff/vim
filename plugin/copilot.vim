if !executable('copilot-language-server')
  finish
endif

" accept the current suggestion with ctrl-y
let g:copilot_no_tab_map = v:true
inoremap <silent><expr> <c-y> pumvisible() ? "\<c-y>" : copilot#Accept()

" manually trigger copilot suggestions
imap <c-x><c-a> <plug>(copilot-suggest)
inoremap <silent><expr> <c-e> pumvisible() ? "\<c-e>" : copilot#Dismiss()
inoremap <silent><expr> <c-n> pumvisible() ? "\<c-n>" : copilot#Next()
inoremap <silent><expr> <c-p> pumvisible() ? "\<c-p>" : copilot#Previous()

" load the plugin after configuring copilot options
packadd copilot
