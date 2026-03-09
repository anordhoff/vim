if exists("b:did_custom_ftplugin")
  finish
endif
let b:did_custom_ftplugin = 1

" lint the project and open the results in the quickfix list
command -buffer Lint :Dispatch golangci-lint run --show-stats=false --output.text.print-issued-lines=false

" show test coverage
command -buffer Cover :silent !go tool cover -html=coverage.out
command -buffer Coverfunc :tabedit /tmp/coverage.func | setlocal noreadonly | :%d | execute 'read !go tool cover -func=coverage.out' | :1d | :silent write | setlocal readonly

" enable lsp
if exists("g:load_lsp")
  packadd lsp
endif
