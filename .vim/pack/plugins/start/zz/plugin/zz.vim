if has( 'vim_starting' )
	augroup zzStart
		autocmd!
		autocmd VimEnter * call zz#Enable()
	augroup END
endif
