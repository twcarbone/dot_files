setlocal signcolumn=yes

" Insert a Doxygen-style comment block
command DoxyBlock normal i /**<cr>@brief<cr>@detail<cr>@note<cr>@param<cr>@return<cr>/<esc>5k$
