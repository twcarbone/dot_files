setlocal autoindent
setlocal comments=fb:-,fb:*,fb:>
setlocal formatoptions=tcrnq

nnoremap <buffer> <leader>r gwip

let b:undo_ftplugin = "setlocal autoindent< comments< formatoptions< | unmap <buffer> <leader>r"
