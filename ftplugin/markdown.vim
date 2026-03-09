if exists("b:did_custom_ftplugin")
  finish
endif
let b:did_custom_ftplugin = 1

" auto-increment numbered list items
inoremap <buffer><expr> <cr> markdown#IncrementList()

" correct numbered list numbers using gq
nnoremap <buffer><silent> gqq :<c-u>call markdown#Renumber(line('.'), line('.') + v:count - 1)<cr>
nnoremap <buffer><silent> gq :set opfunc=markdown#RenumberOp<cr>g@
xnoremap <buffer><silent> gq :<c-u>call markdown#Renumber(line("'<"), line("'>"))<cr>

if !g:loaded_markdown_preview
  finish
endif

" shorter commands
command -buffer Preview :MarkdownPreview
command -buffer PreviewStop :MarkdownPreviewStop
command -buffer PreviewToggle :MarkdownPreviewToggle
