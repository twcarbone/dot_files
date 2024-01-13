function zz#Enable()
	inoremap <expr> <Tab> <SID>onTabPress()
	nnoremap <expr> <leader>p <SID>onLeaderPPress()
endf!

function s:onTabPress()

	if search('\%#[]>)}''"`]', 'n')
		" Snap out of quotes, parentheses, etc.
		return  "\<Right>"
	elseif search('\%#<', 'n')
		" Snap to end of enclosing tag
		return "\<C-O>f>\<Right>"
	else
		" Regular-degular tab
		return "\<Tab>"
	endif

endf!

function s:onLeaderPPress()
	" Run code formatting based on file extension

	let l:usePrettier = ["js", "ts", "jsx", "tsx", "json", "css", "html"]
	let l:useClangFormat = ["cpp", "h"]
	let l:useBlack = ["py"]

	if index(l:usePrettier, expand("%:e")) >= 0
		" Prettier
		:PrettierAsync
	elseif index(l:useClangFormat, expand("%:e")) >= 0
		" clang-format
		:call system("clang-format -i " . expand("%"))
	elseif index(l:useBlack, expand("%:e")) >= 0
		" Black + isort
		:call system("black " . expand("%"))
		:call system("isort " . expand("%"))
	endif

endf!
