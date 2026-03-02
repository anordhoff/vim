if exists("b:did_custom_ftplugin")
  finish
endif
let b:did_custom_ftplugin = 1

" auto-increment numbered list items
inoremap <buffer><expr> <cr> markdown#IncrementList()

" TODO: can opfunc=<SID>RenumberOp<cr>g@ be refactored such that a separate function s:RenumberOp(type) is not required?
" correct numbered list numbers using gq
nnoremap <buffer><silent> gq :set opfunc=<SID>RenumberOp<cr>g@
xnoremap <buffer><silent> gq :<c-u>call markdown#Renumber(line("'<"), line("'>"))<cr>
function s:RenumberOp(type)
  call markdown#Renumber(line("'["), line("']"))
endfunction


" lazy load markdown-preview
if !empty($SSH_TTY)
  finish
endif
if !exists("g:loaded_markdown_preview")
  packadd markdown-preview
  let g:loaded_markdown_preview = 1
endif

" shorter commands
command Preview :MarkdownPreview
command PreviewStop :MarkdownPreviewStop
command PreviewToggle :MarkdownPreviewToggle
