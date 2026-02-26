if !exists("g:loaded_markdown_preview")
  packadd markdown-preview
  let g:loaded_markdown_preview = 1
endif

" shorter commands
command Preview :MarkdownPreview
command PreviewStop :MarkdownPreviewStop
command PreviewToggle :MarkdownPreviewToggle
