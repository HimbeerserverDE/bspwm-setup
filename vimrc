if 1
	augroup vimStartup
		au!
	
		autocmd BufReadPost *
			\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
			\ |		exe "normal! g`\""
			\ | endif
	augroup END
endif

augroup go_save | au!
	autocmd BufWritePost *.go !goimports -l -w '%:p:h'
	autocmd BufWritePost *.go edit!
	autocmd BufWritePost *.go redraw!
augroup end

augroup rust_save | au!
	autocmd BufWritePost *.rs !cargo fmt
	autocmd BufWritePost *.rs edit!
	autocmd BufWritePost *.rs redraw!
augroup end

autocmd FileType rust setlocal ts=4 sw=4 expandtab
autocmd FileType rust set shiftwidth=4
autocmd FileType rust set softtabstop=4

nnoremap <Enter> moO<Esc>`o

set autoindent
set number
set tabstop=4
set background=dark # make 256color in tmux work
syntax on
