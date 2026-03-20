let s:options = #{
  \   autoComplete: v:false,
  \   autoHighlightDiags: v:true,
  \   diagSignErrorText: 'E:',
  \   diagSignHintText: 'H:',
  \   diagSignInfoText: 'I:',
  \   diagSignWarningText: 'W:',
  \   diagVirtualTextAlign: 'after',
  \   diagVirtualTextWrap: 'truncate',
  \   echoSignature: v:true,
  \   highlightDiagInline: v:true,
  \   hoverInPreview: v:true,
  \   omniComplete: v:true,
  \   popupBorder: v:false,
  \   popupBorderChars: ['-', '|', '-', '|', '.', '.', "'", "'"],
  \   semanticHighlight: v:true,
  \   showDiagWithSign: v:false,
  \   showDiagWithVirtualText: v:true,
  \ }

let s:servers = [#{
  \   name: 'golang',
  \   filetype: ['go', 'gomod', 'gowork', 'gotmpl'],
  \   path: 'gopls',
  \   args: ['serve'],
  \   syncInit: v:true,
  \ },
  \ #{
  \   name: 'vim',
  \   filetype: ['vim'],
  \   path: 'vim-language-server',
  \   args: ['--stdio'],
  \ }]

augroup lsp_setup
  autocmd!
  autocmd FileType go,gomod,gowork,gotmpl,vim ++once packadd lsp
  autocmd User LspSetup call LspOptionsSet(s:options)
  autocmd User LspSetup call LspAddServer(s:servers)
augroup END

augroup lsp_attach
  autocmd!

  " normal mode keymaps
  autocmd User LspAttached nnoremap <silent><buffer> gd <cmd>LspGotoDefinition<cr>
  autocmd User LspAttached nnoremap <silent><buffer> gD <cmd>LspGotoDeclaration<cr>
  autocmd User LspAttached nnoremap <silent><buffer> grr <cmd>LspShowReferences<cr>
  autocmd User LspAttached nnoremap <silent><buffer> grn <cmd>LspRename<cr>
  autocmd User LspAttached nnoremap <silent><buffer> gra <cmd>LspCodeAction<cr>
  autocmd User LspAttached nnoremap <silent><buffer> gri <cmd>LspGotoImpl<cr>
  autocmd User LspAttached nnoremap <silent><buffer> grt <cmd>LspGotoTypeDef<cr>
  autocmd User LspAttached nnoremap <silent><buffer> gO <cmd>LspDocumentSymbol<cr>
  autocmd User LspAttached nnoremap <silent><buffer> K <cmd>LspHover<cr>
  autocmd User LspAttached nnoremap <silent><buffer> <leader>F <cmd>LspFormat<cr>
  autocmd User LspAttached nnoremap <silent><buffer> [d <cmd>LspDiag prev<cr><cmd>LspDiag current<cr>
  autocmd User LspAttached nnoremap <silent><buffer> ]d <cmd>LspDiag next<cr><cmd>LspDiag current<cr>
  autocmd User LspAttached nnoremap <silent><buffer> <leader>d <cmd>LspDiag current<cr>
  autocmd User LspAttached nnoremap <silent><buffer> <leader>D <cmd>LspDiag show<cr>

  " insert mode keymaps
  autocmd User LspAttached inoremap <silent><buffer> <c-s> <cmd>LspShowSignature<cr>

  " trigger completion when typing a '.' char
  " TODO: built-in trigger char autocompletion (https://github.com/yegappan/lsp/issues/781)
  autocmd User LspAttached inoremap <buffer> . .<c-x><c-o>
augroup END
