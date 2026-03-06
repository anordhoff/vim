if exists("b:did_custom_ftplugin")
  finish
endif
let b:did_custom_ftplugin = 1

" lint the project and open the results in the quickfix list
command Lint :Dispatch golangci-lint run --show-stats=false --output.text.print-issued-lines=false

" show test coverage
autocmd Filetype go command Cover :silent !go tool cover -html=coverage.out
autocmd Filetype go command Coverfunc :tabedit /tmp/coverage.func | setlocal noreadonly | :%d | execute 'read !go tool cover -func=coverage.out' | :1d | :silent write | setlocal readonly
