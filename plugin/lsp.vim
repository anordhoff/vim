if !empty($SSH_TTY)
  finish
endif

let s:options = #{
  \   popupBorder: v:true,
  \   echoSignature: v:true,
  \   showDiagWithSign: v:false,
  \   highlightDiagInline: v:true,
  \   semanticHighlight: v:true,
  \   autoHighlightDiags: v:true,
  \   showDiagWithVirtualText: v:true,
  \   diagVirtualTextAlign: 'after',
  \   diagVirtualTextWrap: 'truncate',
  \   diagSignErrorText: 'E',
  \   diagSignWarningText: 'W',
  \   diagSignHintText: 'H',
  \   diagSignInfoText: 'I',
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
  autocmd User LspAttached nnoremap <silent> gd <cmd>LspGotoDefinition<cr>
  autocmd User LspAttached nnoremap <silent> gD <cmd>LspGotoTypeDef<cr>
  autocmd User LspAttached nnoremap <silent> grr <cmd>LspShowReferences<cr>
  autocmd User LspAttached nnoremap <silent> grn <cmd>LspRename<cr>
  autocmd User LspAttached nnoremap <silent> gra <cmd>LspCodeAction<cr>
  autocmd User LspAttached nnoremap <silent> gri <cmd>LspGotoImpl<cr>
  autocmd User LspAttached nnoremap <silent> grt <cmd>LspGotoTypeDef<cr>
  autocmd User LspAttached nnoremap <silent> gO <cmd>LspDocumentSymbol<cr>
  autocmd User LspAttached nnoremap <silent> K <cmd>LspHover<cr>
  autocmd User LspAttached inoremap <silent> <c-s> <cmd>LspShowSignature<cr>
  autocmd User LspAttached nnoremap <silent> <leader>F <cmd>LspFormat<cr>

  autocmd User LspAttached nnoremap <silent> [d <cmd>LspDiag prev<cr>
  autocmd User LspAttached nnoremap <silent> ]d <cmd>LspDiag next<cr>
  autocmd User LspAttached nnoremap <silent> <leader>d <cmd>LspDiag current<cr>
  autocmd User LspAttached nnoremap <silent> <leader>D <cmd>LspDiag show<cr>
augroup END 

" highlight groups
" TODO: tmux prevents vim from using kitty's colorscheme
hi LspPopup                      cterm=none        ctermfg=7        ctermbg=none
hi LspPopupBorder                cterm=none        ctermfg=8        ctermbg=none
hi LspDiagInlineError            cterm=undercurl   ctermfg=none     ctermbg=none ctermul=1
hi LspDiagInlineWarning          cterm=undercurl   ctermfg=none     ctermbg=none ctermul=3
hi LspDiagInlineHint             cterm=undercurl   ctermfg=none     ctermbg=none ctermul=6
hi LspDiagInlineInfo             cterm=undercurl   ctermfg=none     ctermbg=none ctermul=6

" load the lsp plugin after setting up autocommands
packadd lsp
