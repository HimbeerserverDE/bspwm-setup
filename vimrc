if 1
	augroup vimStartup
		au!
	
		autocmd BufReadPost *
			\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
			\ |		exe "normal! g`\""
			\ | endif
	augroup END
endif

autocmd FileType rust setlocal ts=4 sw=4 expandtab

nnoremap <Enter> moO<Esc>`o

set autoindent
set number
set tabstop=4
set softtabstop=4
set shiftwidth=4

syntax on
