function! SetupGlobal()
	" These properties are set up for all instances of Vim.

	" GENERAL ---------------------------------------------------------------------------
	
    set textwidth=89
    set colorcolumn=90

	" Do not wrap text while typing - only when done explicitly (e.g., 'gq')
	set formatoptions-=t

    set tabstop=4 
    set shiftwidth=4

    set number
	set relativenumber

    filetype indent on

	inoremap jk <Esc>
	nnoremap <space> :
	
	" Auto-complete quotes, parentheses, etc.
    inoremap " ""<left>
    inoremap ' ''<left>
    inoremap ` ``<left>
    inoremap ( ()<left>
    inoremap [ []<left>
	inoremap { {}<left>
	inoremap <lt> <lt>><left>

    " <Tab> snaps out of enclosing tokens (e.g., '', (), [])
    inoremap <expr> <Tab> search('\%#[]>)}''"`]', 'n') ? '<Right>' : '<Tab>'

	" Search and replace for the word under the cursor
	nnoremap <leader>d :.,$s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i

	" NAVIGATION ------------------------------------------------------------------------
	
	" Center cursor on screen after jumping half-screens
	nnoremap <C-d> <C-d>zz
	nnoremap <C-u> <C-u>zz

	" Swap G and gg
	nnoremap gg G
	nnoremap G gg

	" BUFFERS ---------------------------------------------------------------------------
	
	" Cycle through buffers
	noremap <leader><tab> :bn<cr>

	" List buffers and prompt for selecting a new buffer
	nnoremap <leader>b :ls<cr>:b

	" SPLITS ----------------------------------------------------------------------------
	
	" Cycle through splits
	noremap <leader>w <C-w>w

	" OTHER -----------------------------------------------------------------------------

	call StatusLine()

	noremap <Up> <NOP>
	noremap <Down> <NOP>
	noremap <Left> <NOP>
	noremap <Right> <NOP>


endfunction


function! SetupPython()
	" These properties are only set up for Python files.
	
    set tabstop=4       " how many cols of a \t is worth
    set shiftwidth=4    " how many cols of a lvl of indentation is
    set expandtab       " tabs are replaced with spaces
    
    set autoindent
    set smartindent

	set colorcolumn 90, 100

endfunction


function! SetupC()
	" These properties are only set up for C files.
	
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
	inoremap # #<Space><Space>#<left><left>

	set autoindent
	set smartindent

endfunction


function! SetupVimPlug()

	" Install VimPlug, if it isn't already installed
	let data_dir = '~/.vim'
	if empty(glob(data_dir . '/autoload/plug.vim'))
	  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif

endfunction


function! ColorSchemeVimDeus()

	call plug#begin('~/.vim/bundle/')
	Plug 'ajmwagar/vim-deus'
	call  plug#end()

	" These are needed for vim-deus
	set t_Co=256
	set termguicolors

	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

	set background=dark    " Setting dark mode
	colorscheme deus
	let g:deus_termcolors=256

endfunction


function! StatusLine()

	hi StatusLine  ctermfg=black cterm=bold

	" Clear status line when .vimrc is loaded
	set statusline=

	" Status line left side
	set statusline+=\ (%Y)\ %F\ %M\ %R

	" Use a divider to separate the left side from the right side
	set statusline+=%=

	" Status line right side
	set statusline+=\ ASCII:\ %b\ HEX:\ 0x%B\ (%l,%c)

	" Show the status on the second to last line
	set laststatus=2

endfunction


" main entry point
call SetupGlobal()
autocmd BufNewFile,BufRead *.py call SetupPython()
autocmd BufNewFile,BufRead *.c,*.h call SetupC()
autocmd BufNewFile,BufRead *.html call SetupHTML()

