" ========================================================================================
" Contents
"
"   1.  Options
"   2.  Plugin settings
"   3.  Commands
"   4.  Mappings
"   5.  Functions
"   6.  Autocommands
"

" ========================================================================================
" 1. Options

" see
"   :h xterm-true-color
"   :h termguicolors
"   :h t_8f
"   :h t_8b
"
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

colorscheme gruber
filetype plugin indent on
set backspace=indent,eol,start
set cinoptions+==0  " see :h cinoption-values
set cinoptions+=f0  " see :h cinoption-values
set cinoptions+=g0  " see :h cinoption-values
set cmdwinheight=12
set colorcolumn=100
set cursorline
set directory=$HOME/.vim/swapfiles//
set display=truncate
set expandtab
set foldcolumn=1
set formatlistpat="^\s*[\d\a-]+[:.)\t ]\s*"
set formatoptions=cro/qj  " see :h fo-table
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=trail:∙,tab:→\∙  " see :h i_CTRL-V_digit (trailing:u2219, tab:u2192)
set makeprg=make\ -j
set nojoinspaces
set nrformats+=alpha
set number
set pastetoggle=<F2>
set relativenumber
set scrolloff=5
set shiftwidth=4
set showcmd
set smartcase
set softtabstop=4
set spell
set splitright
set statusline=\ %y%r\ %f\%m\ %4p%%\ (%l,%c)%4b%=%{getcwd()}
set tabline=%!Tabline()
set tabstop=4
set termguicolors
set textwidth=89
set timeout
set timeoutlen=500
set ttimeoutlen=1000
set updatetime=100
set wildignorecase
set wildmenu
set wildmode=longest:full
syntax on


" ========================================================================================
" 2. Plugin settings

" Builtin
runtime ftplugin/man.vim

" Python
let g:pyindent_open_paren = 'shiftwidth()'
let g:python_no_doctest_highlight = 1

" YouCompleteMe
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

" vim-closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.jsx,*.ts,*.tsx,*.xml'
let g:closetag_filetypes = 'html,xhtml,phtml,js,jsx,ts,tsx,xml'

" vim-commentary

" vim-fzf
set runtimepath+=~/.fzf
let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['right,50%', 'ctrl-/']
let g:fzf_layout = { 'down': '50%' }

" vim-gitgutter


" ========================================================================================
" 3. Commands

" :H
"           Opens help in new buffer
command! -nargs=? -complete=help H :enew | :set buftype=help | :h <args>

" :KillTrailingWhitespace
"           Remove trailing whitespace from entire file
"           (inspired by: https://github.com/mislav/vimfiles)
command! -bar KillTrailingWhitespace :normal :%s/ *$//g<cr><c-o><cr><c-l> | :nohlsearch<cr>

" :FormatRange
"           This command is a thin wrapper around FormatRange() to allow the cursor
"           to return to the original position. Without this, FormatRange, which
"           accepts a range, puts the cursor at the beginning of the range after
"           completing. When the range is the entire buffer, this means jumping to
"           line 1... sigh.
"
"           (credit: https://stackoverflow.com/a/73002057)
command! -range -bar FormatRange
    \ let s:pos = getcurpos() |
    \ <line1>,<line2>call <SID>FormatRange() |
    \ call setpos('.', s:pos)

" :Rg
"           Alternate vim-fzf :Rg command to not match filenames.
"
"           (credit: https://stackoverflow.com/a/62745519)
command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \     "rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>),
    \     1,
    \     fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}),
    \     <bang>0
    \ )

command! -range Disable <line1>,<line2>call <SID>Disable()
command! -range Enable <line1>,<line2>call <SID>Enable()
command! -range MemberSort <line1>,<line2>call <SID>MemberSort()


" ========================================================================================
" 4. Mappings

tnoremap <esc> <c-w>N
tnoremap jk    <c-w>N
inoremap jk    <esc>

" C and D delete or change until the end of the line, but Y doesn't
" see :h Y
noremap Y y$

" Jump to beginning and end of line easier
noremap H ^
noremap L $

" Auto-closing
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

" Put cursor in middle of screen after jumping
nnoremap <c-d> <c-d>zz
nnoremap <c-u> <c-u>zz
nnoremap <c-o> <c-o>zz
nnoremap <c-i> <c-i>zz

" Ctrl-s to write current buffer
nnoremap <c-s> :w<cr>

" Leader
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
nnoremap <silent> <leader>a         :call <SID>ToggleCppHeader()<cr>
nnoremap          <leader>b         :Buffers<cr>
nnoremap <silent> <leader>c         :nohlsearch<cr> :.,$s/<c-r><c-w>/<c-r><c-w>/gc<c-f>bbb
 noremap <silent> <leader>e         :nohlsearch<cr>
nnoremap          <leader>f         :Files<cr>
nnoremap          <leader>g         :GFiles<cr>
nnoremap          <leader>i         :Rg<cr>
nnoremap          <leader>j         :Jumps<cr>
nnoremap          <leader>l         :BLines<cr>
nnoremap <silent> <leader>r         :%FormatRange<cr>
vnoremap <silent> <leader>r         :call <SID>FormatRange()<cr>
nnoremap <silent> <leader>s         :source ~/.vimrc<cr> :call <SID>ShowInfo("Sourcing ~/.vimrc ... OK")<cr>
nnoremap <silent> <leader><tab>     :bn<cr>

inoremap <expr> <cr> search('\%#[])}]', 'n') ? '<cr><esc>O' : '<cr>'
nnoremap <expr> *    ':%s/'.expand('<cword>').'//gn<CR>'


" ========================================================================================
" 5. Functions

function! s:ShowError(str)
    echohl ErrorMsg
    echo "Error: " .. a:str
    echohl None
endfunction


function! s:ShowInfo(str)
    echo "Info: " .. a:str
endfunction


" @brief
"   Open a file for editing, if it exists.
"
" @return
"   0 (success) if the file exists
"   1 (fail) if the file does not exist
"
function! s:EditIfExists(path)
    if filereadable(a:path) == 0
        call <SID>ShowError("no such file: " .. a:path)
        return 1
    else
        execute "edit " .. a:path
        return 0
    endif
endfunction

" @brief
"   Enclose a range with `#if 0` and `#endif`
"
function! s:Disable() range
    if index(["c", "cpp", "h"], expand("%:e")) == -1
        call <SID>ShowError("Must be c file")
        return
    endif

    let failed = append(a:firstline - 1, "#if 0")
    let failed = append(a:lastline + 1, "#endif")
endfunction

" @brief
"   Remove `#if 0` and `#endif` macros from a range.
"
" @post
"   Lines `#if 0` and `#endif` deleted from the current buffer.
"
" @note
"   Range must start and end on `#if 0` and `#endif`, respectively.
"
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


" @brief
"   Compare two C-style declarations
"
" @return
"    =  0 if lines are equal
"   >=  1 if lhs sorts after rhs
"   <= -1 if lhs sort before rhs
"
" @example
"
"   bool finished;
"   QString name;
"   int count;
"
"   sorts to:
"
"   int count;
"   bool finished;
"   QString name;
"
function! s:MemberCompare(lhs, rhs)
    let l:lhs_words = split(a:lhs)
    let l:rhs_words = split(a:rhs)
    return strlen(l:lhs_words[0]) - strlen(l:rhs_words[0])
endfunction


" @brief
"   Sort from `first_line` to `last_line` in the current buffer according to compare
"   function `func`.
"
" @post
"   In-place sort of `first_line` through `last_line` in the current buffer.
"
" @return
"   0 for success, 1 for failure
"
function! s:SortBufLines(first_line, last_line, func)
    let l:lines = getline(a:first_line, a:last_line)
    let failed = deletebufline(bufname(), a:first_line, a:last_line)
    let l:sortedlines = sort(l:lines, a:func)
    return append(a:first_line - 1, l:sortedlines)
endfunction


" @brief
"   Sort C-style declarations
"
" @example
"
"   bool finished;
"   QString name;
"   int count;
"
"   sorts to
"
"   int count;
"   bool finished;
"   QString name;
"
function! s:MemberSort() range
    call <SID>SortBufLines(a:firstline, a:lastline, "<SID>MemberCompare")
endfunction


" @brief
"   Format a range according to the buffer file type.
"
" @detail
"   Supported file types:
"       h, c, cpp
"       csv
"       python
"
" @bug
"   Formatting buffer with range does not respect contextual indentation
"   https://github.com/twcarbone/dot_files/issues/5
"
function! s:FormatRange() range
    silent write
    if &filetype ==# "c" || &filetype ==# "cpp"
        silent execute a:firstline ',' a:lastline '!clang-format'
    elseif &filetype ==# "csv"
        silent execute a:firstline ',' a:lastline '!column -s, -t'
    elseif &filetype ==# "json"
        silent execute a:firstline ',' a:lastline '!jq --indent 4 .'
    elseif &filetype ==# "python"
        silent execute a:firstline ',' a:lastline '!~/.pytools/bin/black - -q'
        silent execute a:firstline ',' a:lastline '!~/.pytools/bin/isort --force-single-line-imports -'
    elseif &filetype ==# "xml"
        call setenv("XMLLINT_INDENT", "    ")
        silent execute a:firstline ',' a:lastline '!xmllint --format -'
    else
        call <SID>ShowError("FormatRange: filetype not supported: " .. &filetype)
        return
    endif
    call <SID>ShowInfo("FormatRange: formatting ... OK")
    silent write

endfunction


" @brief
"   Toggle between a .cpp file and its header, and vice versa.
"
"   1 - Look in the current directory for a .cpp or .h of the same name.
"   2 - If 1 fails, and the file ends in .cpp , look in a child 'include' directory.
"   3 - If 1 fails, and the file ends in .h, look in the parent directory. We may be
"       inside of a child 'include' directory.
"   4 - Error if 1, 2, and 3 fail.
"
function! s:ToggleCppHeader()
    silent write

    let l:ext = expand("%:e")
    let l:parent_dir = expand('%:p:.:h:h') .. '/'
    let l:child_dir = expand('%:p:.:h') .. '/include/'

    if l:ext == 'h'
        let l:failed = <SID>EditIfExists(expand('%:s?\.h?\.cpp?:p:.'))
        if l:failed == 1
            let l:failed = <SID>EditIfExists(l:parent_dir .. expand('%:s?\.h?\.cpp?:t'))
        endif
    elseif l:ext == 'cpp'
        let l:failed = <SID>EditIfExists(expand('%:s?\.cpp?\.h?:p:.'))
        if l:failed == 1
            let l:failed = <SID>EditIfExists(l:child_dir .. expand('%:s?\.cpp?\.h?:t'))
        endif
    else
        call <SID>ShowError("Must be .h or .cpp file")
    endif
endfunction


" @brief
"   <Tab> indents if at the beginning of the line, otherwise does completion
"
" @author
"   https://github.com/mislav/vimfiles
"
function! s:InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-n>"
    endif
endfunction


" @brief
"   Set the terminal width to margin columns less than the available space.
"
" @detail
"   This is a workaround to address the situation where long lines are wrapped in the
"   terminal by inserting newlines in the terminal output. When going to terminal normal
"   mode (and showing line numbers) the wrapping gets ugly. This basically pads the
"   terminal so that showing line numbers doesn't fudge up the wrapping.
"
" @see
"   https://github.com/vim/vim/issues/2865.
"
function! s:SetTermWindowMargin(margin)
    execute "set termwinsize=0x" . (winwidth("%") - a:margin)
endfunction


function! s:HandleTerminalOpen()
    set nospell
    set colorcolumn=
    set nohidden
    call <SID>SetTermWindowMargin(6)
endfunction


function! s:HandleVimResized()
    call <SID>SetTermWindowMargin(6)
endfunction


" @brief
"   Show the name of the active buffer in the tab.
"
" @author
"   https://github.com/mkitt/tabline.vim
"
function! Tabline()
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


" ========================================================================================
" 6. Autocommands

augroup __twc_terminal
    autocmd!
    autocmd TerminalOpen * call <SID>HandleTerminalOpen()
    autocmd VimResized * call <SID>HandleVimResized()
augroup END


augroup __twc_cmdwin
    autocmd!
    autocmd CmdwinEnter : set colorcolumn=
augroup END
