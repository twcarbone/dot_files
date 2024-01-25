function! SetupGlobal()

	"""" 24-bit true color

	if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
		let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
		let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	endif


	"""" Basic settings

	filetype indent on			" Load the indent file based on file type
	syntax on					" Enable syntax highlighting
	set termguicolors			" Use 24-bit 'true color' attributes (e.g., 'guifg')
	set spell					" Highlight bad spelling
	set number					" Show line numbers
	set relativenumber			" Show relative line numbers above/below cursor
	set incsearch				" Highlight matches while typing a regex
	set hlsearch				" Highlight search matches
	set noshowmode				" Do not show '-- INSERT --' below statusline
								" This is handled by lightline.vim
	set laststatus=2			" Show status line on 2nd to last line
	set pastetoggle=<F2>		" Toggle 'INSERT (paste)' mode
	set textwidth=89			" Wrap text at this column
	set colorcolumn=90			" Show vertical bar at this column
	set signcolumn=no			" Do not show anything int he gutter


	"""" Filetype settings

	" Python
	let g:pyindent_open_paren = 'shiftwidth()'
	let g:python_no_doctest_highlight = 1

	" C / C++
	set cinoptions+=f0			" First opening brace at column 0

	" C++
	set cinoptions+=g0			" Scope declarations at column 0


	"""" Colorscheme Chs

	let g:chs_terminal_italics = 1
	colorscheme chs


	"""" YouCompleteMe

	let g:ycm_key_list_select_completion = ['<C-n>']
	let g:ycm_add_preview_to_completeopt="popup"
	let g:ycm_show_detailed_diag_in_popup = 1

	highlight YcmErrorLine guibg=#3f0000
	highlight YcmErrorSection gui=NONE

	nnoremap gd :YcmCompleter GoToDefinition<cr>
	nnoremap <leader>f :YcmCompleter FixIt<cr>


	"""" vim-closetag

	" Default filenames and filetypes do not include *.js
	let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.jsx,*.ts,*.tsx'
	let g:closetag_filetypes = 'html,xhtml,phtml,js,jsx,ts,tsx'


	"""" lightline

	let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileencoding', 'filetype', 'charvalue' ] ]
      \ },
      \ 'component': {
      \   'charvalue': '%3b (0x%2B)',
      \ },
      \ }


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

	" tabstop - How many character blocks a tab byte appears as on the screen
	" shiftwidth - How many character blocks are inserted using >> (and friends)
	" expandtab - Insert *tabstop* space bytes instead of a tab byte
	" softtabstop - How much whitespace is inserted/removed when pressing Tab/Backspace
	set tabstop=4
	set shiftwidth=4


	"""" Mappings

	" Basics 
	inoremap jk <Esc>
	nnoremap <space> :
	noremap <Up> <NOP>
	noremap <Down> <NOP>
	noremap <Left> <NOP>
	noremap <Right> <NOP>

	" Swap normal G and gg, logic being gg == 'good game' == end of file
	noremap gg G
	noremap G gg

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
	inoremap <expr> <cr> search('\%#[])}]', 'n') ? '<cr><esc>O' : '<cr>'

	" \-c to to find and replace for the word under the cursor
	nnoremap <leader>c :.,$s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i

	" Use Ctrl-l to clear any highlighted search patterns
	noremap <silent> <c-l> :nohlsearch<cr>

	" Center cursor on screen after jumping half-screens
	nnoremap <C-d> <C-d>zz
	nnoremap <C-u> <C-u>zz

	" Swap G and gg (gg == 'good game' == end of file)
	nnoremap gg G
	nnoremap G gg

	" Cycle through buffers
	noremap <leader><tab> :bn<cr>

	" List active buffers and prompt for a buffer switch
	nnoremap <leader>b :ls<cr>:b

	" :H <command> opens help ('starting.txt') for <command> in new buffer
	command! -nargs=1 -complete=help H :enew | :set buftype=help | :h <args>

	" Cycle through splits
	noremap <leader>w <C-w>w


endfunction


function! SetupPython()
	" These properties are only set up for Python files.
	
	" See 'Tab settings' for definitions
	set expandtab
	set softtabstop=4

	" Start a python docstring on the line below.
	" Inserts two sets of triple quotes below the current line, with the cursor sitting
	" in insert mode on the line between the quotes.
	map <leader>k o"""<cr><esc>ko

	set colorcolumn=90,120

endfunction


function! SetupC()
	" These properties are only set up for C files.
	
	" See 'Tab settings' for definitions
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

	" See 'Tab settings' for definitions
	set tabstop=2
	set shiftwidth=2
	set expandtab
	set softtabstop=2

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


" main entry point
call SetupGlobal()
autocmd BufNewFile,BufRead *.py call SetupPython()
autocmd BufNewFile,BufRead *.c,*.h call SetupC()
autocmd BufNewFile,BufRead *.html call SetupHTML()

