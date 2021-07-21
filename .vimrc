function! SetupGlobal()

    set background=dark " this is so tmux colors look normal
    set number

    inoremap " ""<left>
    inoremap ' ''<left>
    inoremap ( ()<left>
    inoremap [ []<left>
    inoremap {<CR> {<CR>}<C-o>O

    " Ctrl + PgUp and Ctrl + PgDn to switch between tabs
    nnoremap <C-PageDown> gt
    nnoremap <C-PageUp> gT

    " tab 'snaps' out of (), [], and {}
    inoremap <expr> <Tab> search('\%#[]>)}]', 'n') ? '<Right>' : '<Tab>'

    " tab also snaps out of single and double quotes
    inoremap <expr> <Tab> search('\%#[]>)}''"`]', 'n') ? '<Right>' : '<Tab>'
    
    set textwidth=79    
    set colorcolumn=80

endfunction

function! SetupPython()
    syntax enable

    set tabstop=4       " how many cols of a \t is worth
    set shiftwidth=4    " how many cols of a lvl of indentation is
    set expandtab       " tabs are replaced with spaces
    
    set autoindent
    set smartindent

endfunction

function! SetupC()
    colorscheme blue
    syntax enable

    set tabstop=4
    set shiftwidth=4
    set cindent

    " Ctrl + K for entering c-style comment block
    inoremap <C-k> /*<Space><Space>*/<left><left><left>

endfunction


call SetupGlobal()
autocmd BufNewFile,BufRead *.py call SetupPython()
autocmd BufNewFile,BufRead *.c,*.h call SetupC()


