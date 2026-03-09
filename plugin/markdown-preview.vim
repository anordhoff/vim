if !g:is_workstation
  finish
endif

" load plugin
packadd markdown-preview
let g:loaded_markdown_preview = 1

" echo preview page URL in command line when opening preview page
let g:mkdp_echo_preview_url = 1

" preview page title
let g:mkdp_page_title = '${name}'
