if !exists('g:workstation')
  finish
endif

let s:options = #{
  \   popupBorder: v:true,
  \   showDiagWithSign: v:false,
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
  autocmd User LspAttached nnoremap <silent> gd :LspGotoDefinition<cr>
  autocmd User LspAttached nnoremap <silent> gD :LspGotoTypeDef<cr>
  autocmd User LspAttached nnoremap <silent> grr :LspShowReferences<cr>
  autocmd User LspAttached nnoremap <silent> grn :LspRename<cr>
  autocmd User LspAttached nnoremap <silent> gra :LspCodeAction<cr>
  autocmd User LspAttached nnoremap <silent> gri :LspGotoImpl<cr>
  autocmd User LspAttached nnoremap <silent> grt :LspGotoTypeDef<cr>
  autocmd User LspAttached nnoremap <silent> gO :LspDocumentSymbol<cr>
  autocmd User LspAttached nnoremap <silent> gO :LspDocumentSymbol<cr>
  autocmd User LspAttached nnoremap <silent> K :LspShowSignature<cr>
  autocmd User LspAttached nnoremap <silent> <leader>F :LspFormat<cr>

  autocmd User LspAttached nnoremap <silent> [d :LspDiag prev<cr>
  autocmd User LspAttached nnoremap <silent> ]d :LspDiag next<cr>
  autocmd User LspAttached nnoremap <silent> <leader>d :LspDiag current<cr>
  autocmd User LspAttached nnoremap <silent> <leader>D :LspDiag show<cr>

  autocmd User LspAttached inoremap <silent> <c-s> :LspShowSignature<cr>
augroup END 

" load the lsp plugin after setting up autocommands
packadd lsp
