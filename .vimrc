function! SetupAll()

    """" 24-bit true color

    if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif


    """" Basic

    " This needs to be sourced if vim was built from source
    source $VIMRUNTIME/defaults.vim

    " Turn off hints (e.g., 'You discovered the command-line window...')
    autocmd! vimHints

    " Vim swap files
    set directory=$HOME/.vim/swapfiles//

    filetype indent on          " Load the indent file based on file type
    set colorcolumn=90          " Show vertical bar at this column
    set cursorline              " Enable syntax highlighting on the current line
    set hidden                  " Do not prompt to save buffers when switching
    set laststatus=2            " Show status line on 2nd to last line
    set number                  " Show line numbers
    set pastetoggle=<F2>        " Toggle 'INSERT (paste)' mode
    set relativenumber          " Show relative line numbers above/below cursor
    set scrolloff=1             " Keep 1 line above/below cursor
    set spell                   " Highlight bad spelling
    set splitright              " Put new split to the right, not left
    set termguicolors           " Use 24-bit 'true color' attributes (e.g., 'guifg')
    set textwidth=89            " Wrap text at this column
    syntax on                   " Enable syntax highlighting


    """" Colorscheme

    colorscheme gruber


    """" Filetype settings

    " Python
    let g:pyindent_open_paren = 'shiftwidth()'
    let g:python_no_doctest_highlight = 1

    " C / C++
    set cinoptions+=f0          " First opening brace at column 0

    " C++
    set cinoptions+=g0          " Access modifiers at column 0


    """" netrw

    " noma - buffer cannot be modified
    " nomod - buffer is considered to be not modified
    " rnu - display current line number and relative line numbers
    " nobl - do not display in buffer list
    " nowrap - do not wrap long lines
    " ro - read-only
    let g:netrw_bufsettings = 'noma nomod rnu nobl nowrap ro'

    let g:netrw_banner=0        " Do not show banner
    let g:netrw_liststyle=3     " Tree listing style
    let g:netrw_winsize=30      " Occupy 30% of the total width


    """" YouCompleteMe

    let g:ycm_add_preview_to_completeopt="popup"
    let g:ycm_auto_hover = ""
    let g:ycm_clangd_binary_path = exepath("clangd")
    let g:ycm_clangd_uses_ycmd_caching = 0
    let g:ycm_enable_diagnostic_highlighting = 0
    let g:ycm_enable_diagnostic_signs = 1
    let g:ycm_error_symbol = "E"
    let g:ycm_key_list_select_completion = ['<C-n>']
    let g:ycm_show_detailed_diag_in_popup = 1
    let g:ycm_warning_symbol = "W"


    """" vim-closetag

    let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.jsx,*.ts,*.tsx,*.xml'
    let g:closetag_filetypes = 'html,xhtml,phtml,js,jsx,ts,tsx,xml'


    """" FZF

    set runtimepath+=~/.fzf
    let g:fzf_vim = {}
    let g:fzf_vim.preview_window = ['hidden']
    let g:fzf_layout = { 'down': '20%' }


    """" Wildmenu

    " wildmode, wildmenu - first tab completes as much as possible, second tab shows
    " list, third tab cycles through list
    set wildmode=longest,full
    set wildmenu


    """" Wrapping

    " c - Auto-wrap comments using textwidth; insert the comment leader automatically
    " r - Automatically insert comment leader after hitting <Enter> in Insert mode
    " o - Automatically insert comment leader after hitting 'o' or 'O' in Normal mode
    " q - Allow formatting of comments using `gq`
    set formatoptions=croq


    """" Tabs

    " expandtab - Insert *tabstop* space bytes instead of a tab byte
    " shiftwidth - How many character blocks are inserted using >> (and friends)
    " softtabstop - How much whitespace is inserted/removed when pressing Tab/Backspace
    " tabstop - How many character blocks a tab byte appears as on the screen
    set expandtab
    set shiftwidth=4
    set softtabstop=4
    set tabstop=4


    """" Searching

    " hlsearch - Highlight search matches
    " ignorecase - Case-insensitive searching
    " incsearch - Highlight matches while typing a search regex
    " smartcase - Searches with all lowercase are case-insensitive; searches containing
    "             at least one capital are case-sensitive (\c and \C override this
    "             behavior)
    set hlsearch
    set ignorecase
    set incsearch
    set smartcase


    """" Whitespace

    " list - Show invisible characters from 'listchars'
    " listchars - trail:U2219,tab:U2192
    set list
    set listchars=trail:∙,tab:→\∙


    """" Statusline

    set statusline=\ %y%r\ %f\%m\ %4p%%\ (%l,%c)%4b%=%{getcwd()}


    """" Commands

    " :H opens help in new buffer
    command! -nargs=1 -complete=help H :enew | :set buftype=help | :h <args>

    " Remove trailing whitespace from entire file
    " Inspired by: https://github.com/mislav/vimfiles
    command! KillTrailingWhitespace :normal :%s/ *$//g<cr><c-o><cr><c-l>

    " This command is a thin wrapper around FormatRange() to allow the cursor to return
    " to the original position. Without this, FormatRange, which accepts a range, puts
    " the cursor at the beginning of the range after completing. When the range is the
    " entire buffer, this means jumping to line 1... sigh.
    " Credit to: https://stackoverflow.com/a/73002057.
    command! -range -bar FormatRange
        \ let s:pos = getcurpos() |
        \ <line1>,<line2>call FormatRange() |
        \ call setpos('.', s:pos)


    """"" Mappings

    " TODO: (4) 'nnoremap <expr> *' jumps to beginning of line

     noremap                    G               gg
     noremap                    gg              G
     noremap <silent>           <c-l>           :nohlsearch<cr>
     noremap                    Y               y$

    inoremap                    "               ""<left>
    inoremap                    '               ''<left>
    inoremap                    (               ()<left>
    inoremap                    <               <><left>
    inoremap                    [               []<left>
    inoremap                    `               ``<left>
    inoremap                    jk              <Esc>
    inoremap                    {               {}<left>
    inoremap          <expr>    <cr>            search('\%#[])}]', 'n') ? '<cr><esc>O' : '<cr>'

    nnoremap                    <c-d>           <c-d>zz
    nnoremap                    <c-u>           <c-u>zz
    nnoremap                    <leader>b       :Buffers<cr>
    nnoremap                    <leader>d       <plug>(YCMHover)
    nnoremap                    <leader>f       :GFiles<cr>
    nnoremap                    <leader>l       :BLines<cr>
    nnoremap                    <space>         :
    nnoremap                    gd              :YcmCompleter GoToDefinition<cr>
    nnoremap                    q<space>        q:
    nnoremap          <expr>    *               ':%s/'.expand('<cword>').'//gn<CR>'
    nnoremap <silent>           <leader><tab>   :bn<cr>
    nnoremap <silent>           <leader>h       :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/b
    nnoremap <silent>           <leader>hgg     :.,$s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/b
    nnoremap <silent>           <leader>hl      :.s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/b
    nnoremap <silent>           <leader>m       :w<cr> :tab term make<cr>
    nnoremap <silent>           <leader>r       :%FormatRange<cr>
    nnoremap <silent>           <leader>sv      :source ~/.vimrc<cr>
    nnoremap <silent>           <leader>t       :vertical term<cr>
    nnoremap <silent> <expr>    <leader>j       InsertDoxygenCommentBlock()

    tnoremap                    <esc>           <C-w>N
    tnoremap                    jk              <C-w>N

    vnoremap                    <space>         :
    vnoremap <silent>           <leader>r       :call FormatRange()<cr>

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

function! InsertDoxygenCommentBlock()
    if index(["c", "cpp", "h"], expand("%:e")) >= 0
        return "o/**\<cr>/\<esc>O
            \@brief\<cr>
            \@detail\<cr>
            \@note\<cr>
            \@param[in]\<cr>
            \@exception\<cr>
            \@return
            \\<esc>kkkkkA"
    endif
endfunction

function! SetupPython()
    set colorcolumn=90
endfunction

function! SetupC()
    set signcolumn=yes
endfunction

function! SetupMarkup()
    set autoindent
    set smartindent
    silent! iunmap <
endfunction

function! SetupCSV()
    set nowrap
    set colorcolumn=
endfunction

function! SetupDiff()
    set readonly
    set nospell
endfunction

function! SetupLog()
    set colorcolumn=
    set nospell
    set nowrap
    set readonly
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
autocmd BufNewFile,BufRead *.c,*.cpp,*.h    call SetupC()
autocmd BufNewFile,BufRead *.csv            call SetupCSV()
autocmd BufNewFile,BufRead *.diff           call SetupDiff()
autocmd BufNewFile,BufRead *.html,*.xml     call SetupMarkup()
autocmd BufNewFile,BufRead *.log            call SetupLog()
autocmd BufNewFile,BufRead *.py             call SetupPython()
autocmd TerminalOpen *                      call OnTerminalOpen()
autocmd VimResized *                        call OnVimResized()
