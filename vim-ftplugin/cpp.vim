setlocal signcolumn=yes

" Search for function definition
nnoremap <silent> <buffer> g: /<c-r><c-w><c-b>::<cr>

command! -buffer DoxyBlock normal O/**<cr><tab>@brief<cr>/<esc>k

let b:undo_ftplugin = "setlocal signcolumn<"
