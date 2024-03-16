function zz#Enable()
	inoremap <expr> <Tab> <SID>onTabPress()
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

