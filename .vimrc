function! SetupGlobal()
	" These properties are set up for all instances of Vim.

	" GENERAL ---------------------------------------------------------------------------

	" Required for 24-bit truecolor
	if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
		let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
		let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	endif
	set termguicolors

	syntax on

	let g:chs_terminal_italics = 1

	let g:pyindent_open_paren = 'shiftwidth()'
	let g:python_no_doctest_highlight = 1

	colorscheme chs

	set spell

	" Configure tab completion for files
	" wildmode, wildmenu - first tab completes as much as possible, second tab shows
	" list, third tab cycles through list
	set wildmode=longest,full
	set wildmenu
	
	" textwidth - Automatically wrap text at this column
	" colorcolumn - Display a vertical bar at this column
	set textwidth=89
	set colorcolumn=90

	" Do not wrap text automatically while typing, only when using ':gq'
	set formatoptions-=t

	" tabstop - How many character blocks a tab byte appears as on the screen
	" shiftwidth - How many character blocks are inserted using >> (and friends)
	set tabstop=4
	set shiftwidth=4

	" number - Show absolute number of current line
	" relativenumber - Show relative numbers for all other lines
	set number
	set relativenumber

	" Load the indent file based on file type
	filetype indent on

	inoremap jk <Esc>
	nnoremap <space> :

	" Swap normal G and gg, logic being gg == 'good game' == end of file
	nnoremap gg G
	nnoremap G gg

	" Use # to search for word under cursor (without moving to next occurrence)
	nnoremap # #N
	
	" Auto-complete quotes, parentheses, etc.
	inoremap " ""<left>
	inoremap ' ''<left>
	inoremap ` ``<left>
	inoremap ( ()<left>
	inoremap [ []<left>
	inoremap { {}<left>

	" Double of open paren, bracket, or curly inserts indented blank line
	inoremap (( (<cr>)<esc>O
	inoremap [[ [<cr>]<esc>O
	inoremap {{ {<cr>}<esc>O

	" Tab snaps out of enclosing characters (e.g., '', (), [])
	inoremap <expr> <Tab> search('\%#[]>)}''"`]', 'n') ? '<Right>' : '<Tab>'

	" \-d to to find and replace for the word under the cursor
	nnoremap <leader>d :.,$s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i

	" incsearch - highlight matches while typing a regex
	" hlsearch - highlight search matches
	set incsearch
	set hlsearch

	" Use Ctrl-l to clear any highlighted search patterns
	noremap <silent> <c-l> :nohlsearch<cr>

	" NAVIGATION ------------------------------------------------------------------------
	
	" Center cursor on screen after jumping half-screens
	nnoremap <C-d> <C-d>zz
	nnoremap <C-u> <C-u>zz

	" Swap G and gg (gg == 'good game' == end of file)
	nnoremap gg G
	nnoremap G gg

	" BUFFERS ---------------------------------------------------------------------------
	
	" \-Tab to cycle through buffers
	noremap <leader><tab> :bn<cr>

	" \-b to list active buffers and prompt for a buffer switch
	nnoremap <leader>b :ls<cr>:b

	" :H <command> opens help ('starting.txt') for <command> in new buffer
	command! -nargs=1 -complete=help H :enew | :set buftype=help | :h <args>

	" SPLITS ----------------------------------------------------------------------------
	
	" \-w to cycle through splits
	noremap <leader>w <C-w>w

	" PLUGIN CONFIGURATION --------------------------------------------------------------

	" vim-closetag
	" Default filenames and filetypes do not include *.js
	let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.jsx'
	let g:closetag_filetypes = 'html,xhtml,phtml,js,jsx'

	" OTHER -----------------------------------------------------------------------------

	call StatusLine()

	noremap <Up> <NOP>
	noremap <Down> <NOP>
	noremap <Left> <NOP>
	noremap <Right> <NOP>


endfunction


function! SetupPython()
	" These properties are only set up for Python files.
	
	" expandtab - Insert *tabstop* space bytes instead of a tab byte
	" softtabstop - How much whitespace is inserted/removed when pressing Tab/Backspace
	set expandtab
	set softtabstop=4

	" Start a python docstring on the line below.
	" Inserts two sets of triple quotes below the current line, with the cursor sitting
	" in insert mode on the line between the quotes.
	map <leader>k o"""<cr><esc>ko

	set colorcolumn=90,100

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

