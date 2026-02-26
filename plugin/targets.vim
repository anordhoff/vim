" both growing and seeking will work on the largest available count if a too large count it given
let g:targets_gracious = 1

augroup targets_config
  autocmd!

  autocmd User targets#mappings#user call targets#mappings#extend({
    \ 'b': {'pair': [{'o': '(', 'c': ')'}]},
    \ 'B': {'pair': [{'o': '{', 'c': '}'}]},
    \ 'r': {'pair': [{'o': '[', 'c': ']'}]},
    \ 'R': {'pair': [{'o': '<', 'c': '>'}]},
    \ 'q': {'quote': [{'d': '"'}]},
    \ 'Q': {'quote': [{'d': '`'}]},
    \ })
augroup END
