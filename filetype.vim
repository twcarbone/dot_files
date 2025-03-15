" @file
"   filetype.vim
"
" @detail
"   This file is sourced *before* $VIMRUNTIME/filetype.vim.
"
"   Conforms to case B of ':h new-filetype'.
"

if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    autocmd! BufRead,BufNewFile *.log* setfiletype log
augroup END
