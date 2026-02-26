let g:projectionist_heuristics = {
  \ '*': {
  \   'dockerfile': {
  \     'type': 'dockerfile'
  \   },
  \   'makefile': {
  \     'type': 'makefile'
  \   },
  \   'readme.md': {
  \     'type': 'readme'
  \   },
  \ },
  \ 'go.mod': {
  \   '*.go': {
  \     'alternate': '{}_test.go',
  \     'dispatch': 'go build ./{dirname}',
  \     'type': 'source'
  \   },
  \   '*_test.go': {
  \     'alternate': '{}.go',
  \     'dispatch': 'go test -fullpath -coverprofile=coverage.out ./{dirname}/...',
  \     'type': 'test'
  \   }
  \ }}

if filereadable(expand("~/jobfiles/nvim/plugin/projectionist.vim"))
  source ~/jobfiles/nvim/plugin/projectionist.vim
  let g:projectionist_heuristics['*'][g:projectionist_cicd_key] = g:projectionist_cicd_value
endif
