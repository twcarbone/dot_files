function! SetupGlobal()
	" These properties are set up for all instances of Vim.

    set background=dark " this is so tmux colors look normal
    set number

	" auto-closing
    inoremap " ""<left>
    inoremap ' ''<left>
    inoremap ` ``<left>
    inoremap ( ()<left>
    inoremap [ []<left>
	inoremap { {}<left>
	inoremap <lt> <lt>><left>

	" remap escape
	inoremap jk <Esc>

    " Ctrl + PgUp and Ctrl + PgDn to switch between tabs
    nnoremap <C-PageDown> gt
    nnoremap <C-PageUp> gT

    " tab 'snaps' out of (), [], and {}
    inoremap <expr> <Tab> search('\%#[]>)}]', 'n') ? '<Right>' : '<Tab>'

    " tab also snaps out of single and double quotes
    inoremap <expr> <Tab> search('\%#[]>)}''"`]', 'n') ? '<Right>' : '<Tab>'
    
    set textwidth=79    
    set colorcolumn=80

    set tabstop=4 
    set shiftwidth=4

endfunction

function! SetupPython()
	" These properties are only set up for Python files.
	
    syntax enable

    set tabstop=4       " how many cols of a \t is worth
    set shiftwidth=4    " how many cols of a lvl of indentation is
    set expandtab       " tabs are replaced with spaces
    
    set autoindent
    set smartindent

	highlight Comment ctermfg=Green
endfunction

function! SetupC()
	" These properties are only set up for C files.
	
    colorscheme blue
    syntax enable

    set tabstop=4
    set shiftwidth=4
    set cindent

    " Ctrl + k for entering c-style comment block
    inoremap <C-k> /*<Space><Space>*/<left><left><left>

	" special key-mapping for {}
	inoremap {<CR> {<CR>}<C-o>O
endfunction

function! SetupHTML()
	" These properties are only set up for html files.

	inoremap % %<Space><Space>%<left><left>

	set autoindent
	set smartindent

endfunction

" main entry point
call SetupGlobal()
autocmd BufNewFile,BufRead *.py call SetupPython()
autocmd BufNewFile,BufRead *.c,*.h call SetupC()
autocmd BufNewFile,BufRead *.html call SetupHTML()


