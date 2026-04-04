" ----------------------------------------------------------
" general settings
" ----------------------------------------------------------

" highlight clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'mycolorscheme'

" --------------------------------------
" variable types
" --------------------------------------
hi Normal                        cterm=none        ctermfg=7        ctermbg=none
hi Comment                       cterm=none        ctermfg=8        ctermbg=none

hi Constant                      cterm=none        ctermfg=7        ctermbg=none
hi String                        cterm=none        ctermfg=4        ctermbg=none
hi Character                     cterm=none        ctermfg=7        ctermbg=none
hi Number                        cterm=none        ctermfg=7        ctermbg=none
hi Boolean                       cterm=none        ctermfg=7        ctermbg=none
hi Float                         cterm=none        ctermfg=7        ctermbg=none

hi Identifier                    cterm=none        ctermfg=7        ctermbg=none
hi Function                      cterm=none        ctermfg=7        ctermbg=none

hi Statement                     cterm=none        ctermfg=7        ctermbg=none
hi Conditional                   cterm=none        ctermfg=6        ctermbg=none
hi Repeat                        cterm=none        ctermfg=6        ctermbg=none
hi Label                         cterm=none        ctermfg=6        ctermbg=none
hi Operator                      cterm=none        ctermfg=7        ctermbg=none
hi Keyword                       cterm=none        ctermfg=6        ctermbg=none
hi Exception                     cterm=none        ctermfg=7        ctermbg=none

hi PreProc                       cterm=none        ctermfg=7        ctermbg=none
hi! link Include                 PreProc
hi! link Define                  PreProc
hi! link Macro                   PreProc
hi! link PreCondit               PreProc

hi Type                          cterm=none        ctermfg=7        ctermbg=none
hi! link StorageClass            Type
hi! link Structure               Type
hi! link Typedef                 Type

hi Special                       cterm=none        ctermfg=7        ctermbg=none
hi! link SpecialChar             Special
hi! link Tag                     Special
hi! link Delimiter               Special
hi! link SpecialComment          Special
hi! link Debug                   Special

" --------------------------------------
" editor settings
" --------------------------------------
hi Cursor                        cterm=reverse     ctermfg=8        ctermbg=none
hi! link TermCursor              Cursor
hi CursorLine                    cterm=none        ctermfg=none     ctermbg=16
hi! link CursorLineNr            LineNr
hi! link CursorColumn            CursorLine
hi! link ColorColumn             CursorLine

" --------------------------------------
" number column
" --------------------------------------
hi LineNr                        cterm=none        ctermfg=20       ctermbg=none
hi SignColumn                    cterm=none        ctermfg=7        ctermbg=none
hi FoldColumn                    cterm=none        ctermfg=7        ctermbg=none
hi Folded                        cterm=none        ctermfg=6        ctermbg=none

" --------------------------------------
" window/tab delimiters
" --------------------------------------
hi VertSplit                     cterm=none        ctermfg=20       ctermbg=none
hi TabLine                       cterm=none        ctermfg=7        ctermbg=18
hi TabLineFill                   cterm=none        ctermfg=none     ctermbg=18
hi TabLineSel                    cterm=none        ctermfg=6        ctermbg=18

" --------------------------------------
" prompt
" --------------------------------------
hi WildMenu                      cterm=none        ctermfg=5        ctermbg=22
hi Question                      cterm=none        ctermfg=2        ctermbg=none
hi Title                         cterm=none        ctermfg=3        ctermbg=none
hi ModeMsg                       cterm=none        ctermfg=7        ctermbg=none
hi MoreMsg                       cterm=none        ctermfg=2        ctermbg=none

" --------------------------------------
" statusline
" --------------------------------------
" StatusLine and StatusLineNC are used for the bookends of the statusline
hi StatusLine                    cterm=none        ctermfg=7        ctermbg=none
hi StatusLineNC                  cterm=none        ctermfg=7        ctermbg=none
hi! link StatusLineTerm          Statusline
hi! link StatusLineTermNC        StatusLineNC
hi StatusLineInactive            cterm=none        ctermfg=7        ctermbg=18
if g:is_workstation
  hi StatusLineActive            cterm=none        ctermfg=7        ctermbg=22
else
  hi StatusLineActive            cterm=none        ctermfg=7        ctermbg=21
endif

" --------------------------------------
" file navigation / searching
" --------------------------------------
hi Directory                     cterm=none        ctermfg=7        ctermbg=none
hi Search                        cterm=reverse     ctermfg=12       ctermbg=none
hi IncSearch                     cterm=reverse     ctermfg=13       ctermbg=none
hi CurSearch                     cterm=reverse     ctermfg=13       ctermbg=none

" --------------------------------------
" completion menu
" --------------------------------------
hi Pmenu                         cterm=none        ctermfg=none     ctermbg=19
hi PmenuSel                      cterm=none        ctermfg=none     ctermbg=23
hi PmenuSbar                     cterm=none        ctermfg=none     ctermbg=20
hi PmenuThumb                    cterm=none        ctermfg=none     ctermbg=8
hi PmenuMatch                    cterm=none        ctermfg=6        ctermbg=19
hi PmenuMatchSel                 cterm=none        ctermfg=6        ctermbg=23

" --------------------------------------
" quickfix
" --------------------------------------
hi QuickFixLine                  cterm=none        ctermfg=none     ctermbg=23
hi qfFileName                    cterm=none        ctermfg=7        ctermbg=none
hi qfLineNr                      cterm=none        ctermfg=8        ctermbg=none

" --------------------------------------
" visual aid
" --------------------------------------
hi MatchParen                    cterm=none        ctermfg=5        ctermbg=none
hi Visual                        cterm=none        ctermfg=none     ctermbg=22
hi VisualNOS                     cterm=none        ctermfg=none     ctermbg=22
hi NonText                       cterm=none        ctermfg=3        ctermbg=none
hi EndOfBuffer                   cterm=none        ctermfg=20       ctermbg=none
hi Conceal                       cterm=none        ctermfg=2        ctermbg=none
hi SpecialKey                    cterm=none        ctermfg=2        ctermbg=none

hi Underlined                    cterm=underline   ctermfg=none     ctermbg=none
hi Ignore                        cterm=none        ctermfg=3        ctermbg=none
hi Error                         cterm=none        ctermfg=1        ctermbg=none
hi! link ErrorMsg                Error
hi WarningMsg                    cterm=none        ctermfg=3        ctermbg=none
hi Todo                          cterm=none        ctermfg=8        ctermbg=none

" --------------------------------------
" diff
" --------------------------------------
hi DiffAdd                       cterm=reverse     ctermfg=10       ctermbg=none
hi DiffChange                    cterm=none        ctermfg=none     ctermbg=17
hi DiffDelete                    cterm=none        ctermfg=1        ctermbg=none
hi DiffText                      cterm=reverse     ctermfg=11       ctermbg=none

" --------------------------------------
" spelling
" --------------------------------------

hi SpellBad                      cterm=none        ctermfg=1        ctermbg=none
hi SpellCap                      cterm=none        ctermfg=3        ctermbg=none
hi SpellLocal                    cterm=none        ctermfg=6        ctermbg=none
hi SpellRare                     cterm=none        ctermfg=6        ctermbg=none


" ----------------------------------------------------------
" languages
" ----------------------------------------------------------

" --------------------------------------
" git
" --------------------------------------
hi gitcommitOverflow             cterm=none        ctermfg=1        ctermbg=none

" --------------------------------------
" go
" --------------------------------------
hi goFormatSpecifier             cterm=none        ctermfg=2        ctermbg=none
hi goEscapeC                     cterm=none        ctermfg=2        ctermbg=none
hi goEscapeError                 cterm=none        ctermfg=2        ctermbg=none

" --------------------------------------
" json
" --------------------------------------
hi jsonKeyword                   cterm=none        ctermfg=6        ctermbg=none
hi jsonString                    cterm=none        ctermfg=7        ctermbg=none
hi! link jsonNoQuotesError       Normal

" --------------------------------------
" make
" --------------------------------------
hi makeTarget                    cterm=none        ctermfg=6        ctermbg=none
hi makeSpecTarget                cterm=none        ctermfg=5        ctermbg=none

" --------------------------------------
" markdown
" --------------------------------------
hi markdownBold                  cterm=none        ctermfg=5        ctermbg=none
hi markdownCode                  cterm=none        ctermfg=2        ctermbg=none
hi markdownCodeBlock             cterm=none        ctermfg=2        ctermbg=none
hi markdownCodeDelimiter         cterm=none        ctermfg=2        ctermbg=none
hi markdownBlockquote            cterm=italic      ctermfg=8        ctermbg=none
hi markdownURL                   cterm=none        ctermfg=8        ctermbg=none
hi markdownLinkText              cterm=underline   ctermfg=4        ctermbg=none
hi markdownLinkDelimiter         cterm=none        ctermfg=8        ctermbg=none
hi markdownLinkTextDelimiter     cterm=none        ctermfg=8        ctermbg=none
hi markdownListMarker            cterm=none        ctermfg=8        ctermbg=none
hi markdownOrderedListMarker     cterm=none        ctermfg=8        ctermbg=none

hi markdownH1                    cterm=bold,underline  ctermfg=3    ctermbg=none
hi markdownH2                    cterm=bold,underline  ctermfg=4    ctermbg=none
hi markdownH3                    cterm=bold        ctermfg=4        ctermbg=none
hi markdownH4                    cterm=none        ctermfg=4        ctermbg=none
hi markdownH5                    cterm=none        ctermfg=4        ctermbg=none
hi markdownH6                    cterm=none        ctermfg=4        ctermbg=none
hi! link markdownH1Delimiter     markdownH1
hi! link markdownH2Delimiter     markdownH2
hi! link markdownH3Delimiter     markdownH3
hi! link markdownH4Delimiter     markdownH4
hi! link markdownH5Delimiter     markdownH5
hi! link markdownH6Delimiter     markdownH6

" --------------------------------------
" shell
" --------------------------------------
hi shQuote                       cterm=none        ctermfg=4        ctermbg=none
hi shDerefSimple                 cterm=none        ctermfg=2        ctermbg=none

" --------------------------------------
" terraform
" --------------------------------------
hi hclStringInterp               cterm=none        ctermfg=2        ctermbg=none

" --------------------------------------
" vimscript
" --------------------------------------
hi! link vimCommentTitle         Todo

" --------------------------------------
" yaml
" --------------------------------------
hi yamlBlockMappingKey           cterm=none        ctermfg=6        ctermbg=none


" ----------------------------------------------------------
" plugins
" ----------------------------------------------------------

" --------------------------------------
" copilot
" --------------------------------------
hi CopilotSuggestion             cterm=none        ctermfg=20       ctermbg=none
hi CopilotChatSelection          cterm=none        ctermfg=none     ctermbg=23
hi CopilotChatHeader             cterm=none        ctermfg=5        ctermbg=none
hi CopilotChatSeparator          cterm=none        ctermfg=5        ctermbg=none
hi CopilotChatHelp               cterm=none        ctermfg=8        ctermbg=none

" --------------------------------------
" dirvish
" --------------------------------------
hi DirvishPathTail               cterm=none        ctermfg=4        ctermbg=none
hi DirvishArg                    cterm=none        ctermfg=5        ctermbg=none

" --------------------------------------
" fugitive
" --------------------------------------
hi DiffAdded                     cterm=none        ctermfg=2        ctermbg=none
hi DiffRemoved                   cterm=none        ctermfg=1        ctermbg=none

" --------------------------------------
" lsp
" --------------------------------------
" hi LspPopup                      cterm=none        ctermfg=7        ctermbg=none
" hi LspPopupBorder                cterm=none        ctermfg=7        ctermbg=none
hi LspDiagInlineError            cterm=undercurl   ctermfg=none     ctermbg=none     ctermul=1
hi LspDiagInlineWarning          cterm=undercurl   ctermfg=none     ctermbg=none     ctermul=3
hi LspDiagInlineHint             cterm=undercurl   ctermfg=none     ctermbg=none     ctermul=6
hi LspDiagInlineInfo             cterm=undercurl   ctermfg=none     ctermbg=none     ctermul=6

" --------------------------------------
" quick-scope
" --------------------------------------
hi QuickScopePrimary             cterm=bold        ctermfg=none     ctermbg=none
hi QuickScopeSecondary           cterm=bold,italic ctermfg=none     ctermbg=none

" --------------------------------------
" sneak
" --------------------------------------
hi Sneak                         cterm=reverse     ctermfg=12       ctermbg=none
hi SneakCurrent                  cterm=reverse     ctermfg=13       ctermbg=none
hi SneakScope                    cterm=reverse     ctermfg=8        ctermbg=none
hi SneakLabel                    cterm=reverse     ctermfg=12       ctermbg=none
hi SneakLabelMask                cterm=reverse     ctermfg=12       ctermbg=12
