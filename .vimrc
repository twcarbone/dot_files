" tab stops
set tabstop=4
set shiftwidth=4
set expandtab

" this is so tmux colors look normal
set background=dark

" other configs
set number

" auto-completion
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap {<CR> {<CR>}<C-o>O

" switching between tabs
nnoremap <C-PageDown> gt
nnoremap <C-PageUp> gT

set colorcolumn=80

" hitting tab 'snaps' outside (), [], and {}
inoremap <expr> <Tab> search('\%#[]>)}]', 'n') ? '<Right>' : '<Tab>'

" also tab snaps out of quotes
inoremap <expr> <Tab> search('\%#[]>)}''"`]', 'n') ? '<Right>' : '<Tab>'

" based on filetype
filetype detect
if (&ft=='c')
    " color scheme
    colorscheme blue
    
    " smart indentation
    set cindent

    " ruler
    set colorcolumn=80

    " syntax highlighting (spellcheck comments)
    syntax enable

    " key binding for entering c-style comment block
    inoremap <C-k> /*<Space><Space>*/<left><left><left>
    
endif


