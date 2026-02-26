" conceal links
syntax match markdownExt /{[.:#][^}]*}/ conceal contains=ALL
syntax region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" keepend contained conceal contains=markdownUrl
syntax region markdownLinkText matchgroup=markdownLinkTextDelimiter start="\[\%(\_[^]]*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends

" match quotes beyond the greater than sign
syntax region markdownBlockquote start=">\%(\s\|$\)" end="\s*$" keepend contained
