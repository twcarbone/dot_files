function! s:SetupAll()

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
    set makeprg=make\ -j
    set pastetoggle=<F2>        " Toggle paste mode
    set scrolloff=5             " Keep 1 line above/below cursor
    set shiftwidth=4            " How many character blocks are inserted using >>
    set softtabstop=4           " How much whitespace is inserted/removed on tab/backspace
    set tabline=%!Tabline()
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
    command! -bar KillTrailingWhitespace
        \ :normal :%s/ *$//g<cr><c-o><cr><c-l> |
        \ :nohlsearch<cr>

    " :FormatRange
    "           This command is a thin wrapper around FormatRange() to allow the cursor
    "           to return to the original position. Without this, FormatRange, which
    "           accepts a range, puts the cursor at the beginning of the range after
    "           completing. When the range is the entire buffer, this means jumping to
    "           line 1... sigh.
    "           (credit to: https://stackoverflow.com/a/73002057)
    command! -range -bar FormatRange
        \ let s:pos = getcurpos() |
        \ <line1>,<line2>call <SID>FormatRange() |
        \ call setpos('.', s:pos)

    command! -range Disable <line1>,<line2>call <SID>Disable()
    command! -range Enable <line1>,<line2>call <SID>Enable()

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

    " Leader mappings
     noremap <silent> <leader>0         :tablast<cr>
     noremap          <leader>1         1gt
     noremap          <leader>2         2gt
     noremap          <leader>3         3gt
     noremap          <leader>4         4gt
     noremap          <leader>5         5gt
     noremap          <leader>6         6gt
     noremap          <leader>7         7gt
     noremap          <leader>8         8gt
     noremap          <leader>9         9gt
    nnoremap <silent> <leader>a         :call <SID>ToggleHeader()<cr>
    nnoremap          <leader>b         :Buffers<cr>
    nnoremap <silent> <leader>c         :nohlsearch<cr>
                                        \ :.,$s/<c-r><c-w>/<c-r><c-w>/gc<c-f>bbb
    nnoremap <silent> <leader>cw        :botright cwindow 20<cr>
     noremap <silent> <leader>e         :nohlsearch<cr>
    nnoremap          <leader>f         :Files<cr>
    nnoremap          <leader>g         :GFiles<cr>
    nnoremap          <leader>l         :BLines<cr>
    nnoremap <silent> <leader>r         :%FormatRange<cr>
    vnoremap <silent> <leader>r         :call <SID>FormatRange()<cr>
    nnoremap <silent> <leader>s         :source ~/.vimrc<cr>
                                        \ :call <SID>ShowInfo("Sourcing ~/.vimrc ... OK")<cr>
    nnoremap <silent> <leader><tab>     :bn<cr>

    inoremap <expr> <cr> search('\%#[])}]', 'n') ? '<cr><esc>O' : '<cr>'
    nnoremap <expr> *    ':%s/'.expand('<cword>').'//gn<CR>'
endfunction

function! s:ShowError(str)
    echo "Error: " .. a:str
endfunction

function! s:ShowInfo(str)
    echo "Info: " .. a:str
endfunction

function! s:EditIfExists(path)
    if filereadable(a:path) == 0
        call <SID>ShowError("no such file: " .. a:path)
    else
        execute "edit " .. a:path
    endif
endfunction

function! s:Disable() range
    if index(["c", "cpp", "h"], expand("%:e")) == -1
        call <SID>ShowError("Must be c file")
        return
    endif

    let failed = append(a:firstline - 1, "#if 0")
    let failed = append(a:lastline + 1, "#endif")
endfunction

function! s:Enable() range
    if index(["c", "cpp", "h"], expand("%:e")) == -1
        call <SID>ShowError("Must be c file")
        return
    elseif getline(a:firstline) != "#if 0"
        call <SID>ShowError("Range must start with '#if 0'")
        return
    elseif getline(a:lastline) != "#endif"
        call <SID>ShowError("Range must end with '#endif'")
        return
    endif

    silent execute a:lastline 'd'
    silent execute a:firstline 'd'
endfunction

function! s:FormatRange() range
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
        call <SID>ShowError("No formatter program specified")
        return
    endif
    call <SID>ShowInfo("Formatting ... OK")
    silent write

endfunction

function! s:ToggleHeader()
    if index(["h"], expand("%:e")) >= 0
        call <SID>EditIfExists(expand("%:r") .. ".cpp")
    elseif index(["cpp"], expand("%:e")) >= 0
        call <SID>EditIfExists(expand("%:r") .. ".h")
    else
        call <SID>ShowError("Must be c file")
    endif
endfunction

function! s:InsertTabWrapper()
    " <Tab> indents if at the beginning of a line; otherwise does completion
    " Credit: https://github.com/mislav/vimfiles
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-n>"
    endif
endfunction

function! s:SetTermWindowMargin(margin)
    " Set the width of the terminal to be a:margin columns less than the available space.
    " This is a workaround to address the situation where long lines are wrapped in the
    " terminal by inserting newlines in the terminal output. When going to terminal
    " normal mode (and showing line numbers) the wrapping gets ugly. This basically pads
    " the terminal so that showing line numbers doesn't fudge up the wrapping.
    "
    " See https://github.com/vim/vim/issues/2865.
    execute "set termwinsize=0x" . (winwidth("%") - a:margin)

endfunction

function! s:OnTerminalOpen()
    set nospell
    set colorcolumn=
    set nohidden
    call <SID>SetTermWindowMargin(6)
endfunction

function! s:OnVimResized()
    call <SID>SetTermWindowMargin(6)
endfunction

function! Tabline()
    " Credit: https://github.com/mkitt/tabline.vim
    let s = ''
    for i in range(tabpagenr('$'))
        let tab = i + 1
        let winnr = tabpagewinnr(tab)
        let buflist = tabpagebuflist(tab)
        let bufnr = buflist[winnr - 1]
        let bufname = bufname(bufnr)
        let bufmodified = getbufvar(bufnr, "&mod")

        let s .= '%' . tab . 'T'
        let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
        let s .= ' ' . tab .':'
        let s .= (bufname != '' ? '['. fnamemodify(bufname, ':t') . '] ' : '[No Name] ')

        if bufmodified
            let s .= '[+] '
        endif
    endfor

    let s .= '%#TabLineFill#'
    if (exists("g:tablineclosebutton"))
        let s .= '%=%999XX'
    endif
    return s
endfunction

call <SID>SetupAll()

" Turn off hints (eg, 'You discovered the command-line window...')
autocmd! vimHints

augroup __twc_terminal
    autocmd!
    autocmd TerminalOpen * call <SID>OnTerminalOpen()
    autocmd VimResized * call <SID>OnVimResized()
augroup END

augroup __twc_cmdwin
    autocmd!
    autocmd CmdwinEnter : set colorcolumn=
augroup END
