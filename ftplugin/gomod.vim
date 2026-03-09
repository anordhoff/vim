if exists("b:did_custom_ftplugin")
  finish
endif
let b:did_custom_ftplugin = 1

" enable lsp
if g:load_lsp
  packadd lsp
endif
