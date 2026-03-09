" TODO: set formatexpr= when on a file that supports formating
if g:is_remote
  finish
endif

let s:options = #{
  \   autoComplete: v:false,
  \   omniComplete: v:true,
  \   autoHighlightDiags: v:true,
  \   diagSignErrorText: 'E',
  \   diagSignHintText: 'H',
  \   diagSignInfoText: 'I',
  \   diagSignWarningText: 'W',
  \   diagVirtualTextAlign: 'after',
  \   diagVirtualTextWrap: 'truncate',
  \   echoSignature: v:true,
  \   highlightDiagInline: v:true,
  \   popupBorder: v:true,
  \   semanticHighlight: v:true,
  \   showDiagWithSign: v:false,
  \   showDiagWithVirtualText: v:true,
  \ }
autocmd User LspSetup call LspOptionsSet(s:options)

let s:servers = [#{
  \   name: 'golang',
  \   filetype: ['go', 'gomod'],
  \   path: 'gopls',
  \   args: ['serve'],
  \   syncInit: v:true
  \ }]
autocmd User LspSetup call LspAddServer(s:servers)

augroup lsp_attach
  autocmd!

  " keymaps
  autocmd User LspAttached nnoremap <silent><buffer> gd <cmd>LspGotoDefinition<cr>
  autocmd User LspAttached nnoremap <silent><buffer> gD <cmd>LspGotoDeclaration<cr>
  autocmd User LspAttached nnoremap <silent><buffer> grr <cmd>LspShowReferences<cr>
  autocmd User LspAttached nnoremap <silent><buffer> grn <cmd>LspRename<cr>
  autocmd User LspAttached nnoremap <silent><buffer> gra <cmd>LspCodeAction<cr>
  autocmd User LspAttached nnoremap <silent><buffer> gri <cmd>LspGotoImpl<cr>
  autocmd User LspAttached nnoremap <silent><buffer> grt <cmd>LspGotoTypeDef<cr>
  autocmd User LspAttached nnoremap <silent><buffer> gO <cmd>LspDocumentSymbol<cr>
  autocmd User LspAttached nnoremap <silent><buffer> K <cmd>LspHover<cr>
  autocmd User LspAttached inoremap <silent><buffer> <c-s> <cmd>LspShowSignature<cr>
  autocmd User LspAttached nnoremap <silent><buffer> <leader>F <cmd>LspFormat<cr>
  autocmd User LspAttached nnoremap <silent><buffer> [d <cmd>LspDiag prev<cr>
  autocmd User LspAttached nnoremap <silent><buffer> ]d <cmd>LspDiag next<cr>
  autocmd User LspAttached nnoremap <silent><buffer> <leader>d <cmd>LspDiag current<cr>
  autocmd User LspAttached nnoremap <silent><buffer> <leader>D <cmd>LspDiag show<cr>

  " configure gq to use the language server when formatting
  autocmd User LspAttached setlocal formatexpr=lsp#lsp#FormatExpr()

  " trigger completion when typing a '.' char
  autocmd User LspAttached inoremap <buffer> . .<c-x><c-o>

augroup END 
