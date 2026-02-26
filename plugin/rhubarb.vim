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
    execute "!gh pr create --fill-first | pbcopy"
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
    execute "!gh pr create --draft --fill-first | pbcopy"
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
  if b:gh_pr_draft
    execute "!gh pr create --draft --title '" .. b:gh_pr_subject .. "' --body-file " .. a:bodyFile .. " | pbcopy"
  else
    execute "!gh pr create --title '" .. b:gh_pr_subject .. "' --body-file " .. a:bodyFile .. " | pbcopy"
  endif
  call delete(expand(a:bodyFile))
endfunction
