" conceal links
" syntax match markdownExt /{[.:#][^}]*}/ conceal contains=ALL
" syntax region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" keepend contained conceal contains=markdownUrl
" syntax region markdownLinkText matchgroup=markdownLinkTextDelimiter start="\[\%(\_[^]]*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends

" match quotes beyond the greater than sign
syntax region markdownBlockquote start=">\%(\s\|$\)" end="\s*$" keepend contained

" heading highlight should take priority over inline code
for s:n in range(1, 6)
  execute printf('syntax match markdownH%dCode /`[^`]*`/ contained containedin=markdownH%d', s:n, s:n)
  execute printf('hi! link markdownH%dCode markdownH%d', s:n, s:n)
endfor
