function! SetupAll()

    if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif

    colorscheme gruber

    " This needs to be sourced if vim was built from source
    source $VIMRUNTIME/defaults.vim

    filetype indent on      " Load indentation file based on file type
    syntax on               " Enable syntax highlighting

    set cursorline          " Enable syntax highlighting on the current line
    set hidden              " Do not prompt to save buffers when switching
    set hlsearch            " Highlight search matches
    set ignorecase          " Case-insensitive searching
    set incsearch           " Highlight matches while typing a search regex
    set nocompatible
    set nojoinspaces        " Inset only one space after join commands (eg, 'J', 'gwip')
    set number              " Show line numbers
    set relativenumber      " Show relative line numbers
    set smartcase           " Override 'ignorecase' if the search contains a capital
                            " \c forces case-insensitive
                            " \C forces case-sensitive
    set list                " Show invisible characters from 'listchars'
    set spell               " Highlight bad spelling
    set splitright          " Put new split to the right, not left
    set termguicolors       " Use 24-bit 'true color' attributes (eg, 'guifg')
    set wildignorecase      " Ignore case when matching
    set wildmenu            " Enable wildmenu

    set directory=$HOME/.vim/swapfiles//    " Location of swap files
    set listchars=trail:∙,tab:→\∙           " trailing:U2219, tab:U2192

    set cinoptions+==0          " Anything after 'case:' labels is not indented
    set cinoptions+=f0          " First opening brace is in column 0
    set cinoptions+=g0          " Access modifiers at column 0
    set cmdwinheight=12         " Height of command-line window
    set colorcolumn=90          " Show vertical bar at this column
    set expandtab               " Insert 'tabstop' space bytes instead of a tab byte
    set formatoptions=cro/qj    " See :h fo-table
    set laststatus=2            " Show status line on 2nd to last line
    set pastetoggle=<F2>        " Toggle paste mode
    set scrolloff=5             " Keep 1 line above/below cursor
    set shiftwidth=4            " How many character blocks are inserted using >>
    set softtabstop=4           " How much whitespace is inserted/removed on tab/backspace
    set tabstop=4               " How many character blocks a tab byte appears as on the screen
    set textwidth=89            " Wrap text at this column
    set updatetime=100          " 100 ms update time
    set wildmode=longest:full   " Tab semantics when completing in command line

    set statusline=\ %y%r\ %f\%m\ %4p%%\ (%l,%c)%4b%=%{getcwd()}

    " Python
    let g:pyindent_open_paren = 'shiftwidth()'
    let g:python_no_doctest_highlight = 1

    " Plugin - YouCompleteMe
    let g:ycm_add_preview_to_completeopt="popup"
    let g:ycm_auto_hover = ""
    let g:ycm_clangd_binary_path = exepath("clangd")
    let g:ycm_clangd_uses_ycmd_caching = 0
    let g:ycm_enable_diagnostic_highlighting = 0
    let g:ycm_enable_diagnostic_signs = 0
    let g:ycm_error_symbol = "E"
    let g:ycm_key_list_select_completion = ['<C-n>']
    let g:ycm_show_detailed_diag_in_popup = 1
    let g:ycm_warning_symbol = "W"

    " Plugin - vim-closetag
    let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.jsx,*.ts,*.tsx,*.xml'
    let g:closetag_filetypes = 'html,xhtml,phtml,js,jsx,ts,tsx,xml'

    " Plugin - FZF
    set runtimepath+=~/.fzf
    let g:fzf_vim = {}
    let g:fzf_vim.preview_window = ['hidden']
    let g:fzf_layout = { 'down': '20%' }

    " :H
    "           Opens help in new buffer
    command! -nargs=? -complete=help H :enew | :set buftype=help | :h <args>

    " :KillTrailingWhitespace
    "           Remove trailing whitespace from entire file
    "           (inspired by: https://github.com/mislav/vimfiles)
    command! KillTrailingWhitespace :normal :%s/ *$//g<cr><c-o><cr><c-l>

    " :FormatRange
    "           This command is a thin wrapper around FormatRange() to allow the cursor
    "           to return to the original position. Without this, FormatRange, which
    "           accepts a range, puts the cursor at the beginning of the range after
    "           completing. When the range is the entire buffer, this means jumping to
    "           line 1... sigh.
    "           (credit to: https://stackoverflow.com/a/73002057)
    command! -range -bar FormatRange
        \ let s:pos = getcurpos() |
        \ <line1>,<line2>call FormatRange() |
        \ call setpos('.', s:pos)

     tnoremap <esc> <c-w>N
     tnoremap jk    <c-w>N
     inoremap jk    <esc>

     nnoremap <space> :
     vnoremap <space> :

     " C and D delete or change until the end of the line, but Y doesn't
     " :h Y actually suggests this mapping
     noremap Y y$

     " Jump to beginning and end of line easier
     noremap H ^
     noremap L $

     inoremap " ""<left>
     inoremap ' ''<left>
     inoremap ( ()<left>
     inoremap [ []<left>
     inoremap ` ``<left>
     inoremap { {}<left>

     " Easier window navigation
     nnoremap <c-h> <c-w><c-h>
     nnoremap <c-j> <c-w><c-j>
     nnoremap <c-k> <c-w><c-k>
     nnoremap <c-l> <c-w><c-l>

     " Put cursor in middle of screen after jumping half-screens
     nnoremap <c-d> <c-d>zz
     nnoremap <c-u> <c-u>zz

     noremap <leader>1 1gt
     noremap <leader>2 2gt
     noremap <leader>3 3gt
     noremap <leader>4 4gt
     noremap <leader>5 5gt
     noremap <leader>6 6gt
     noremap <leader>7 7gt
     noremap <leader>8 8gt
     noremap <leader>9 9gt
     noremap <silent> <leader>0 :tablast<cr>

     nnoremap <silent> <leader>c :.,$s/<c-r><c-w>/<c-r><c-w>/gc<c-f>
     nnoremap <silent> <leader>a :call ToggleHeaderSource()<cr>
     noremap  <silent> <leader>e :nohlsearch<cr>
     nnoremap <silent> <leader>r :%FormatRange<cr>
     vnoremap <silent> <leader>r :call FormatRange()<cr>

     inoremap <expr> <cr> search('\%#[])}]', 'n') ? '<cr><esc>O' : '<cr>'
     nnoremap <expr> *    ':%s/'.expand('<cword>').'//gn<CR>'

     nnoremap <silent> <leader><tab>    :bn<cr>

     nnoremap <leader>b :Buffers<cr>
     nnoremap <leader>f :GFiles<cr>
     nnoremap <leader>l :BLines<cr>
endfunction

function! FormatRange() range
    " Format current buffer based on file extension
    " TODO: (5) Formatting buffer with range does not respect contextual indentation
    silent write
    if index(["c", "cpp", "h"], expand("%:e")) >= 0
        silent execute a:firstline ',' a:lastline '!clang-format'
    elseif index(["csv"], expand("%:e")) >= 0
        silent execute a:firstline ',' a:lastline '!column -s, -t'
    elseif index(["json"], expand("%:e")) >= 0
        silent execute a:firstline ',' a:lastline '!jq --indent 4 .'
    elseif index(["py"], expand("%:e")) >= 0
        silent execute a:firstline ',' a:lastline '!~/.pytools/bin/black - -q'
        silent execute a:firstline ',' a:lastline '!~/.pytools/bin/isort --force-single-line-imports -'
    else
        echo "Error: No formatter program specified"
        return
    endif
    echo "Formatting ... OK"
    silent write

endfunction

function! ToggleHeaderSource()
    if index(["h"], expand("%:e")) >= 0
        silent execute "e %<.cpp"
    elseif index(["cpp"], expand("%:e")) >= 0
        silent execute "e %<.h"
    else
        echo "Error: must .cpp or .h file"
        return
    endif
endfunction

function! InsertTabWrapper()
    " <Tab> indents if at the beginning of a line; otherwise does completion
    " Credit: https://github.com/mislav/vimfiles
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-n>"
    endif
endfunction

function! SetTermWindowMargin(margin)
    " Set the width of the terminal to be a:margin columns less than the available space.
    " This is a workaround to address the situation where long lines are wrapped in the
    " terminal by inserting newlines in the terminal output. When going to terminal
    " normal mode (and showing line numbers) the wrapping gets ugly. This basically pads
    " the terminal so that showing line numbers doesn't fudge up the wrapping.
    "
    " See https://github.com/vim/vim/issues/2865.
    execute "set termwinsize=0x" . (winwidth("%") - a:margin)

endfunction

function! OnTerminalOpen()
    set nospell
    set colorcolumn=
    set nohidden
    call SetTermWindowMargin(6)
endfunction

function! OnVimResized()
    call SetTermWindowMargin(6)
endfunction

call SetupAll()

" Turn off hints (eg, 'You discovered the command-line window...')
autocmd! vimHints

augroup __twc_terminal
    autocmd!
    autocmd TerminalOpen * call OnTerminalOpen()
    autocmd VimResized * call OnVimResized()
augroup END

augroup __twc_cmdwin
    autocmd!
    autocmd CmdwinEnter : set colorcolumn=
augroup END
