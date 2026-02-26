if exists("b:did_custom_ftplugin")
  finish
endif

let b:did_custom_ftplugin = 1
nmap <buffer> a <cr>
nmap <buffer> <c-s> o
nmap <buffer> <c-v> v
nmap <buffer> <c-t> t
