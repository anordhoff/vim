" commands follow the vim-fugitive naming convention
command -nargs=* GCreate      call pr#Create(<q-args>)
command -nargs=* GCreateDraft call pr#CreateDraft(<q-args>)
command          GCreateWeb   call pr#CreateWeb()
