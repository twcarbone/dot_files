function! SetupGlobal()
	" These properties are set up for all instances of Vim.

    set number

	" auto-closing
    inoremap " ""<left>
    inoremap ' ''<left>
    inoremap ` ``<left>
    inoremap ( ()<left>
    inoremap [ []<left>
	inoremap { {}<left>
	"inoremap <lt> <lt>><left>

	" remap escape
	inoremap jk <Esc>

    " Ctrl + PgUp and Ctrl + PgDn to switch between tabs
    nnoremap <C-PageDown> gt
    nnoremap <C-PageUp> gT

	" remap switching between buffers
	map bn :bn<cr>
	map bp :bp<cr>
	map bd :bd<cr>

    " tab 'snaps' out of (), [], and {}
    inoremap <expr> <Tab> search('\%#[]>)}]', 'n') ? '<Right>' : '<Tab>'

    " tab also snaps out of single and double quotes
    inoremap <expr> <Tab> search('\%#[]>)}''"`]', 'n') ? '<Right>' : '<Tab>'

	call plug#begin('~/.vim/bundle/')
	Plug 'ajmwagar/vim-deus'
	"Plug 'alvan/vim-closetag'
	call  plug#end()

	" These are needed for vim-deus
	set t_Co=256
	set termguicolors

	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

	set background=dark    " Setting dark mode
	colorscheme deus
	let g:deus_termcolors=256

	let g:closetag_shortcut = '>'
    
    set textwidth=79    
    set colorcolumn=80

    set tabstop=4 
    set shiftwidth=4

	" STATUS LINE --------------------------------------------------------- {{{
	
	" Set statusline color
	hi StatusLine  ctermfg=black cterm=bold
	
	" Clear status line when vimrc is reloaded.
	set statusline=

	" Status line left side.
	set statusline+=\ (%Y)\ %F\ %M\ %R

	" Use a divider to separate the left side from the right side.
	set statusline+=%=

	" Status line right side.
	set statusline+=\ ASCII:\ %b\ HEX:\ 0x%B\ (%l,%c)

	" Show the status on the second to last line.
	set laststatus=2

	" }}}

endfunction

function! SetupPython()
	" These properties are only set up for Python files.
	
    syntax enable

    set tabstop=4       " how many cols of a \t is worth
    set shiftwidth=4    " how many cols of a lvl of indentation is
    set expandtab       " tabs are replaced with spaces
    
    set autoindent
    set smartindent

	" Ctrl + j to comment block of code
	" Ctrl + k to uncomment block of code
	vnoremap <silent> <C-j> :s/^/#/<cr>:noh<cr>
	vnoremap <silent> <C-k> :s/^#//<cr>:noh<cr>

	highlight Comment ctermfg=Green
endfunction

function! SetupC()
	" These properties are only set up for C files.
	
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
	inoremap # #<Space><Space>#<left><left>

	set autoindent
	set smartindent

endfunction

" main entry point
call SetupGlobal()
autocmd BufNewFile,BufRead *.py call SetupPython()
autocmd BufNewFile,BufRead *.c,*.h call SetupC()
autocmd BufNewFile,BufRead *.html call SetupHTML()


