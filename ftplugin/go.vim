if exists("b:did_custom_ftplugin")
  finish
endif
let b:did_custom_ftplugin = 1

" lint the project and open the results in the quickfix list
command Lint :Dispatch golangci-lint run --show-stats=false --output.text.print-issued-lines=false
