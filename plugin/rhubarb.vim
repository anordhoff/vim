let s:clipboard = has('mac') ? 'pbcopy' : 'xclip -selection clipboard'

" commands follow the vim-fugitive naming convention
command -nargs=* GCreate      call GhPrCreate(<q-args>)
command -nargs=* GCreateDraft call GhPrCreateDraft(<q-args>)
command          GCreateWeb   call GhPrCreateWeb()

" launch the Github web client to create a pull request
function GhPrCreateWeb()
  execute "!gh pr create --web --fill-first"
endfunction

" create a Github pull request
function GhPrCreate(subject)
  if a:subject == ''
    let l:output = system('gh pr create --fill-first')
    if v:shell_error == 0
      call system(s:clipboard, l:output)
      echo trim(l:output)
    else
      echohl ErrorMsg | echo trim(l:output) | echohl None
    endif
  else
    let tmpfile = tempname()
    execute "split " .. tmpfile
    setlocal filetype=prbody
    let b:gh_pr_subject = a:subject
    let b:gh_pr_draft = 0
  endif
endfunction

" create a Github draft pull request
function GhPrCreateDraft(subject)
  if a:subject == ''
    let l:output = system('gh pr create --draft --fill-first')
    if v:shell_error == 0
      call system(s:clipboard, l:output)
      echo trim(l:output)
    else
      echohl ErrorMsg | echo trim(l:output) | echohl None
    endif
  else
    let tmpfile = tempname()
    execute "split " .. tmpfile
    setlocal filetype=prbody
    let b:gh_pr_subject = a:subject
    let b:gh_pr_draft = 1
  endif
endfunction

" automatically create a Github pull request when the prbody buffer is closed
augroup github_config
  autocmd!
  autocmd WinClosed * if &ft == "prbody" | call GhPrCreateWithBody('%') | endif
augroup END

" create a Github pull request using the contents of the prbody buffer as the body
function GhPrCreateWithBody(bodyFile)
  let s:subject = shellescape(b:gh_pr_subject)
  if b:gh_pr_draft
    let l:cmd = "gh pr create --draft --title '" .. s:subject .. "' --body-file " .. a:bodyFile
  else
    let l:cmd = "gh pr create --title '" .. s:subject .. "' --body-file " .. a:bodyFile
  endif
  let l:output = system(l:cmd)
  if v:shell_error == 0
    call system(s:clipboard, l:output)
    echo trim(l:output)
  else
    echohl ErrorMsg | echo trim(l:output) | echohl None
   endif
  call delete(expand(a:bodyFile))
endfunction
