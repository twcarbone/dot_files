" Do not load global ftplugin
let b:did_ftplugin = 1

setlocal autoindent
setlocal comments=fb:-,fb:*,fb:>
setlocal formatoptions=tcrnq
setlocal colorcolumn=90,100

nnoremap <buffer> <leader>r gwip

let b:undo_ftplugin = "setlocal autoindent< comments< formatoptions< | unmap <buffer> <leader>r"
